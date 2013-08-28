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
                dest: '.compiled/app'
                ext: '.js'
            specs:
                expand: true
                cwd: 'spec'
                src: ['**/*.coffee']
                dest: '.compiled/specs'
                ext: '.js'

        watch:
            coffee:
                files: ["app/**/*.coffee", "spec/**/*.coffee"]
                tasks: ["coffee"]

            jasmine:
                files: [".compiled/**/*"]
                tasks: ["jasmine"]

        jasmine:
            seed:
                options:
                    specs: [".compiled/specs/**/*.js"]

            options:
                template : require('grunt-template-jasmine-curljs')
                templateOptions:
                    curlConfig :
                        paths:
                            app: '.compiled/app'
                            jquery: 'lib/jquery/jquery'
                        packages: [
                            { name: 'curl', location: 'lib/curl/src/curl', main: 'curl' }
                            { name: 'underscore', location: 'lib/lodash/dist', main: 'lodash'}
                            { name: 'lodash', location: 'lib/lodash/dist', main: 'lodash'}
                            { name: 'backbone', location: 'lib/backbone', main: 'backbone', config: cjsLoader}
                            { name: 'knockout', location: 'lib/knockout/build/output', main: 'knockout-latest' }
                            { name: 'knockback', location: 'lib/knockback', main: 'knockback', config: cjsLoader}
                        ]
                helpers : ['spec/javascripts/helpers/*.js']
                vendor: []

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-shell'

    grunt.registerTask 'default', ['coffee', 'jasmine:seed', 'watch']
