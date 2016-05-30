(function ()
{
    'use strict';

    var Promise = require('bluebird');
    var Converter = require('csvtojson').Converter;
    var testHelper = require('./testHelper.js');

    var SYMBOLS = {
        DELIMITER: '--',
        EXPECT: 'EXPECT',
        STATEMENT: 'STATEMENT',
        FILENAME_START: '='
    };

    function parse(spec)
    {
        var lines = spec.split(SYMBOLS.DELIMITER);

        function cleanupBody(body)
        {
            return body.replace(/^\s+|\s+$/g, '');
        }

        function parseStatementOrExpect(str, match, type)
        {
            return new Promise(function (resolve)
            {
                var obj = {};
                obj.type = type;
                var filename = match[2];
                var comment = match[3];
                if (filename) {
                    obj.body = cleanupBody(testHelper.getFileContents(filename));
                } else {
                    obj.body = cleanupBody(str.substr(str.indexOf('\n'), str.length));
                }
                if (comment) {
                    obj.comment = comment;
                }
                resolve(obj);
            });
        }

        function parseExpect(str, match)
        {
            return parseStatementOrExpect(str, match, SYMBOLS.EXPECT).then(function (obj)
            {
                var converter = new Converter({
                    noheader: false,
                    quote: '!'
                });
                return new Promise(function (resolve, reject)
                {
                    converter.fromString(obj.body, function (err, json)
                    {
                        if (err) {
                            reject(err);
                            return;
                        }
                        obj.body = json;
                        resolve(obj);
                    });
                });
            });
        }

        function parseStatement(str, match)
        {
            return parseStatementOrExpect(str, match, SYMBOLS.STATEMENT).then(function (obj)
            {
                obj.expects = [];
                return obj;
            });
        }

        function parseRequired(str, match)
        {
            var name = match[2];
            var filename = match[4];
            var comment = match[5];
            var obj = {};

            return new Promise(function (resolve)
            {
                obj.type = SYMBOLS.STATEMENT;
                obj.expects = [];
                obj.required = name;

                if (filename) {
                    obj.body = cleanupBody(testHelper.getFileContents(filename));
                    obj.body = obj.body.replace(/^--.*/gm, '');
                } else {
                    obj.body = cleanupBody(str.substr(str.indexOf('\n'), str.length));
                }
                if (comment) {
                    obj.comment = comment;
                }
                resolve(obj);
            });
        }

        return Promise.map(lines, function (str)
        {
            var matchRequired = str.match(/required expression(="([^"]*)")?\sfile(="([^"]*)")?\s*(.*)?/);
            if (matchRequired) {
                return parseRequired(str, matchRequired);
            }
            var matchStatement = str.match(/statement(="([^"]*)")?\s*(.*)?/);
            if (matchStatement) {
                return parseStatement(str, matchStatement);
            }
            var matchExpect = str.match(/expect(="([^"]*)")?\s*(.*)?/);
            if (matchExpect) {
                return parseExpect(str, matchExpect);
            }
            if (0 === str.length) {
                return false;
            } else {
                throw new Error('Unknown operation type ' + str.substr(0, str.indexOf('\n')));
            }
        }).then(function (data)
        {
            data = data.filter(function (item)
            {
                return null != item && false !== item;
            });
            for (var i = 0, k = 0; i < data.length; i++) {
                if (!data[i]) {
                    data.splice(i, 1);
                    i--;
                } else if (SYMBOLS.STATEMENT === data[i].type) {
                    k = i;
                } else if (SYMBOLS.EXPECT === data[i].type) {
                    data[k].expects.push(data[i]);
                    data.splice(i, 1);
                    i--;
                }
            }
            return data;
        });
    }

    module.exports = {
        parse: parse
    };
})();
