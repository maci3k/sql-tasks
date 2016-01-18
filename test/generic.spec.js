var fs = require('fs');
var Promise = require('bluebird');
var readFile = Promise.promisify(require('fs').readFile);
var expect = require('chai').expect;
var async = require('async');
var Converter = require('csvtojson').Converter;
var pg = require('pg');

/*
 This enforce driver to cast bigint (64-bits length) values into javascript (32-bit) integer.
 We advice to do not use bigint data type. However this setting is useful for COUNT aggregations that
 returns bigint.
 Plese refer https://github.com/brianc/node-postgres/wiki/pg#pgdefaultsparseint8
 */
pg.defaults.parseInt8 = true;
pg.defaults.poolSize = 2;

var pgConnect = Promise.promisify(pg.connect, pg);

// TODO set some generic config
var config = {
    db: {
        connectionUrl: process.env.DATABASE_URL || 'postgres://realskill:realskill@localhost/sql-tasks'
    }
};

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
    var parsePromises = [], lines = spec.split(SYMBOLS.DELIMITER);
    lines.forEach(function (str)
    {
        parsePromises.push(new Promise(function (resolve)
        {
            var obj = {};
            if ('statement' === str.substr(0, 9)) {
                obj.type = SYMBOLS.STATEMENT;
                if (SYMBOLS.FILENAME_START === str[9]) {
                    obj.body = getFileContents(str.substr(10, str.indexOf('\n')));
                } else {
                    obj.body = str.substr(str.indexOf('\n'), str.length);
                }
                obj.expects = [];
            } else if ('expect' === str.substr(0, 6)) {
                obj.type = SYMBOLS.EXPECT;
                if (SYMBOLS.FILENAME_START === str[6]) {
                    obj.body = getFileContents(str.substr(7, str.indexOf('\n')));
                } else {
                    obj.body = str.substr(str.indexOf('\n'), str.length);
                }
            } else if (0 === str.length) {
                resolve(false);
            } else {
                throw new Error('Unknown operation type ' + str.substr(0, str.indexOf('\n')));
            }
            obj.body = obj.body.replace(/^\s+|\s+$/g, '');
            if (SYMBOLS.EXPECT === obj.type) {
                var converter = new Converter({noheader: false});
                converter.fromString(obj.body, function (err, json)
                {
                    obj.body = json;
                    resolve(obj);
                });
            } else {
                resolve(obj);
            }
        }));
    });
    return Promise.all(parsePromises).then(function (data)
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
        var promises = [];
        specObj.forEach(function (item)
        {
            promises.push(new Promise(function (resolve)
            {
                client.query(item.body).then(function (result)
                {
                    item.result = result.rows;
                }).catch(function (err)
                {
                    // TODO consider how we can do assertions on errors
                    item.result = JSON.stringify({
                        error: err.cause.toString(),
                        code: err.cause.code,
                        hint: err.cause.hint,
                        char: err.cause.position
                    });
                }).finally(function ()
                {
                    resolve(item)
                });
            }));
        });
        return Promise.all(promises).finally(client.done);
    });
}

describe('Generic SQL test runner', function ()
{
    async.waterfall([
        function (callback)
        {
            it('Prase tests scenerios and execute SQL', function (done)
            {
                readFile(__dirname + '/expects.sql', 'utf8').then(parse).then(executeSql).then(function (result)
                {
                    callback(null, result);
                    done();
                });
            });
        },
    ], function (err, specObject)
    {
        async.each(specObject, function (stmt, callback)
        {
            var label = stmt.body.length > 100 ? stmt.body.substr(0, stmt.body.indexOf('\n')) + '...' : stmt.body;
            describe('Statement \'' + label + '\'', function ()
            {
                stmt.expects.forEach(function (expectValue)
                {
                    it('should return valid data set\n', function (done)
                    {
                        expect(stmt.result).to.eql(expectValue.body);
                        done();
                        return callback();
                    })
                });
            });
        });
    });
});
