(function ()
{
    'use strict';

    var fs = require('fs');
    var Promise = require('bluebird');
    var readFile = Promise.promisify(fs.readFile);
    var expect = require('chai').expect;
    var async = require('async');
    var testHelper = require('./testHelper.js');
    var parse = require('./parse.js').parse;

    var scenarioFilename = 'scenario.sql';

    describe('RealSkill SQL runner', function ()
    {
        async.waterfall([
            function (callback)
            {
                it('Parse tests scenarios and execute SQL', function (done)
                {
                    readFile(__dirname + '/' + scenarioFilename, 'utf8').then(parse).then(testHelper.executeSql).then(function (result)
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
                        testHelper.printSqlError(stmt);
                    }
                    describe(label, function ()
                    {
                        if (stmt.required) {
                            var expectLabel = 'should find ' + '"' + stmt.required + '"';
                            it(expectLabel, function (done)
                            {
                                expect(stmt.body.indexOf(stmt.required)).to.not.equal(-1);
                                if (stmt.error) {
                                    testHelper.printSqlError(stmt);
                                }
                                done();
                                return callback();
                            });
                        }
                        else {
                            stmt.expects.forEach(function (expectValue)
                            {
                                var expectLabel = 'should return ' + (expectValue.comment || 'should return valid data set');
                                it(expectLabel, function (done)
                                {
                                    expect(stmt.result).to.eql(expectValue.body);
                                    if (stmt.error) {
                                        testHelper.printSqlError(stmt);
                                    }
                                    done();
                                    return callback();
                                });
                            });
                            if (!stmt.expects.length) {
                                it('should be successfull', function ()
                                {

                                });
                            }
                        }
                    });
                });
            });
        });
    });
})();
