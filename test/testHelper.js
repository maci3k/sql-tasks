(function ()
{
    'use strict';

    var fs = require('fs');
    var Promise = require('bluebird');
    var pg = require('pg');
    var pgConnect = Promise.promisify(pg.connect, pg);

    var config = {
        db: {
            connectionUrl: process.env.DATABASE_URL || 'postgres://realskill:realskill@localhost/realskill'
        }
    };
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

    function getFileContents(path)
    {
        path = __dirname + '/' + (path.replace(/^[/\s"]+|[/\s"]+$/g, ''));
        return fs.readFileSync(path).toString();
    }

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
        console.error('   ', highlighStart, ' ! ' + stmt.error.toString());
        if (stmt.error.detail) {
            console.error('        detail: ' + stmt.error.detail);
        }
        console.error('        code: ' + stmt.error.code);
        console.error('        routine: ' + stmt.error.routine, highlightEnd);
    }

    module.exports = {
        getFileContents: getFileContents,
        getClient: getClient,
        executeSql: executeSql,
        printSqlError: printSqlError
    };
})();
