'use strict';

var fs = require('fs');
var Promise = require('bluebird');
var readFile = Promise.promisify(require('fs').readFile);
var expect = require('chai').expect;
var async = require('async');
var Converter = require('csvtojson').Converter;
var pg = require('pg');

var highlighStart = '\x1b[31m';
var highlightEnd = '\x1b[0m';

/*
 This enforce driver to cast bigint (64-bits length) values into javascript (32-bit) integer.
 We advice to do not use bigint data type. However this setting is useful for COUNT aggregations that
 returns bigint.
 Plese refer https://github.com/brianc/node-postgres/wiki/pg#pgdefaultsparseint8
 */
pg.defaults.parseInt8 = true;
pg.defaults.poolSize = 2;

var pgConnect = Promise.promisify(pg.connect, pg);

var config = {
    db: {
        connectionUrl: process.env.DATABASE_URL || 'postgres://realskill:realskill@localhost/realskill'
    }
};

var scenarioFilename = 'scenario.sql';

var SYMBOLS = {
    DELIMITER: '--',
    EXPECT: 'EXPECT',
    STATEMENT: 'STATEMENT',
    FILENAME_START: '='
};

function getClient()
{
    return pgConnect(config.db.connectionUrl).spread(function (client, done)
    {
        return {
            query: Promise.promisify(client.query, client),
            done: done
        };
    });
}

function getFileContents(path)
{
    path = __dirname + '/' + (path.replace(/^[/\s"]+|[/\s"]+$/g, ''));
    return fs.readFileSync(path).toString();
}

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
                obj.body = cleanupBody(getFileContents(filename));
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

    return Promise.map(lines, function (str)
    {
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

function executeSql(specObj)
{
    return getClient().then(function (client)
    {
        return Promise.each(specObj, function (item)
        {
            return client.query(item.body).then(function (result)
            {
                item.result = result.rows;
            }).catch(function (err)
            {
                item.result = [{
                    name: err.cause.name,
                    code: 'SQL-' + err.cause.code
                }];
                item.error = err;
            }).finally(function ()
            {
                return item;
            });
        }).finally(client.done);
    });
}

function printSqlError(stmt)
{
    console.log('   ', highlighStart, ' ! ' + stmt.error.toString());
    if (stmt.error.detail) {
        console.log('        detail: ' + stmt.error.detail);
    }
    console.log('        code: ' + stmt.error.code);
    console.log('        routine: ' + stmt.error.routine, highlightEnd);
}

describe('RealSkill SQL runner', function ()
{
    async.waterfall([
        function (callback)
        {
            it('Parse tests scenarios and execute SQL', function (done)
            {
                readFile(__dirname + '/' + scenarioFilename, 'utf8').then(parse).then(executeSql).then(function (result)
                {
                    callback(null, result);
                    done();
                });
            });
        }
    ], function (err, specObject)
    {
        describe('Evaluate scenario', function ()
        {
            async.each(specObject, function (stmt, callback)
            {
                var label = 'Statement ' + (stmt.comment || stmt.body);
                if (stmt.error && !stmt.expects.length) {
                    printSqlError(stmt);
                }
                describe(label, function ()
                {
                    stmt.expects.forEach(function (expectValue)
                    {
                        var expectLabel = 'should return ' + (expectValue.comment || 'should return valid data set');
                        it(expectLabel, function (done)
                        {
                            expect(stmt.result).to.eql(expectValue.body);
                            if (stmt.error) {
                                printSqlError(stmt);
                            }
                            done();
                            return callback();
                        });
                    });
                });
            });
        });
    });
});
