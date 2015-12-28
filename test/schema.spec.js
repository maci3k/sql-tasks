'use strict';

var Promise = require('bluebird');
var pg = require('pg');
var fs = require('fs');
var expect = require('chai').expect;

pg.defaults.poolSize = 2;
var pgConnect = Promise.promisify(pg.connect, pg);

var config = {
    db: {
        connectionUrl: process.env.DATABASE_URL || 'postgres://realskill:realskill@localhost/sql-tasks'
    }
};

function getClient()
{
    return pgConnect(config.db.connectionUrl).spread(function (client, done)
    {
        return {query: Promise.promisify(client.query, client), done: done};
    });
}

describe('Schema', function ()
{
    var createSchemaCommand;

    before(function ()
    {
        createSchemaCommand = fs.readFileSync(__dirname + '/../solution/schema.sql');
    });

    beforeEach(function ()
    {
        return getClient().then(function (client)
        {
            return client.query('DROP SCHEMA IF EXISTS public CASCADE').then(function ()
            {
                return client.query('CREATE SCHEMA public');
            }).then(function ()
            {
                return client.query(createSchemaCommand.toString());
            }).then(client.done);
        });
    });

    describe('users table', function ()
    {
        describe('when new row is inserted without id', function ()
        {
            it('should automatically generate id from users_id_sequence', function ()
            {
                return getClient().then(function (client)
                {
                    return client.query('INSERT INTO users(email) VALUES (\'example@email.com\'),(\'another@email.com\')').then(function ()
                    {
                        return client.query('SELECT * FROM users');
                    }).then(function (result)
                    {
                        var expectedResultRows = [{id: '1', email: 'example@email.com'}, {id: '2', email: 'another@email.com'}];
                        expect(result.rows).to.eql(expectedResultRows);
                    }).then(client.done)
                });
            });
        });

        describe('when new row is inserted without email', function ()
        {
            it('should reject the operation', function ()
            {
                return getClient().then(function (client)
                {
                    return client.query('INSERT INTO users(id) VALUES (100)').then(function (res)
                    {
                        throw new Error('expected opration fail');
                    }).catch(function (err)
                    {
                        expect(err.routine).to.equal('ExecConstraints');
                        expect(err.code).to.equal('23502');
                    }).then(client.done)
                });
            });
        });
        describe('when new row is inserted with already existing email', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with email longer than 256 characters', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with email that does not contain @ character', function ()
        {
            it('should reject the operation');
        });

        describe('when user is removed', function ()
        {
            it('should remove all associated threads');
            it('should remove all associated posts');
        });
    });

    describe('threads table', function ()
    {
        describe('when new row is inserted without id', function ()
        {
            it('should automatically generate id from threads_id_sequence');
        });
        describe('when new row is inserted without title', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with title longer than 256 characters', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted without author_id', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with author_id that does not match any users.id', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted without create_date', function ()
        {
            it('should set create_date to current date');
        });
    });

    describe('posts table', function ()
    {
        describe('when new row is inserted without id', function ()
        {
            it('should automatically generate id from posts_id_sequence');
        });
        describe('when new row is inserted without body', function ()
        {
            it('should accept the operation');
        });
        describe('when new row is inserted without author_id', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with author_id that does not match any users.id', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted without create_date', function ()
        {
            it('should set create_date to current date');
        });
        describe('when new row is inserted without thread_id', function ()
        {
            it('should reject the operation');
        });
        describe('when new row is inserted with thread_id that does not match any threads.id', function ()
        {
            it('should reject the operation');
        });
    });

});
