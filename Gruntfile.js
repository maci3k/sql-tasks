/*global module*/
module.exports = function (grunt)
{
    'use strict';

    grunt.initConfig({
        mochaTest: {
            options: {
                recursive: true,
                src: ['test/generic.spec.js'],
                ui: 'bdd'
            },
            default: {
                options: {
                    reporter: 'spec'
                },
                src: ['<%=mochaTest.options.src%>']

            },
            verify: {
                options: {
                    reporter: 'mocha-junit-reporter',
                    reporterOptions: {
                        mochaFile: 'target/test-results.xml'
                    }
                },
                src: ['<%=mochaTest.options.src%>']
            }
        }
    });
    grunt.loadNpmTasks('grunt-mocha-test');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.registerTask('verify', ['mochaTest:verify']);
    grunt.registerTask('test', ['mochaTest:default']);
};
