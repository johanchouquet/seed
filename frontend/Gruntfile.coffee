module.exports = (grunt) ->

    cjsLoader = moduleLoader: 'curl/loader/cjsm11'

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        coffee:
            options:
                bare: true
            compile:
                expand: true
                cwd: 'app'
                src: ['**/*.coffee']
                dest: '../backend/seed/static/app'
                ext: '.js'
            specs:
                expand: true
                cwd: 'spec'
                src: ['**/*.coffee']
                dest: '.compiled/specs'
                ext: '.js'

        compass:
            options:
                bundleExec: true
                outputStyle: 'expanded'

        shell:
            compassClean:
                command: 'compass clean'
                options:
                    stdout: true

        watch:
            coffee:
                files: ["app/**/*.coffee", "spec/**/*.coffee"]
                tasks: ["coffee"]
            jasmine:
                files: ["app/**/*.coffee", "spec/**/*.coffee"]
                tasks: ["jasmine"]

        jasmine:
            seed:
                options:
                    specs: [".compiled/specs/**/*.js"]

            options:
                junit:
                    path: 'src/results'
                    consolidate: true
                template : require('grunt-template-jasmine-curljs')
                templateOptions:
                    curlConfig :
                        paths:
                            app: 'static/app'
                            lib: 'js/lib'
                        packages: [
                            { name: 'bags', location: 'components/bags/dist' }
                            { name: 'curl', location: 'components/curl/src/curl', main: 'curl' }
                            { name: 'Q', location: 'components/q/', main: 'q' }
                            { name: 'underscore', location: 'components/lodash/dist', main: 'lodash'}
                            { name: 'lodash', location: 'components/lodash/dist', main: 'lodash'}
                            { name: 'dojo', location: 'components/dojo'}
                            { name: 'mout', location: 'components/mout/src'}
                            { name: 'backbone', location: 'components/backbone', main: 'backbone', config: cjsLoader}
                            { name: 'knockout', location: 'components/knockout/build/output', main: 'knockout-latest' }
                            { name: 'knockback', location: 'components/knockback', main: 'knockback', config: cjsLoader}
                            { name: 'gridster', location: 'components/gridster', main: 'gridster'}

                        ]
                helpers : ['spec/javascripts/helpers/*.js']
                vendor: []

    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-shell'

    grunt.registerTask 'default', ['coffee', 'shell:compassClean', 'compass:dev']
    grunt.registerTask 'jasmineWatch', ['jasmine', 'watch:jasmine']

