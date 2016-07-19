module.exports = (grunt) ->
  "use strict"

  require("jit-grunt") grunt,
    haml: "grunt-haml-php"

  require("time-grunt") grunt

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    banner: "/*! <%= pkg.name %> - v<%= pkg.version %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %> <<%= pkg.author.homepage %>>" + " */\n\n"

    autoprefixer:
      options:
        browsers: [
          '> 1%'
          'Chrome > 0'
          'Explorer >= 8'
          'Firefox >= 4'
          'iOS >= 6'
          'Opera >= 12'
          'Safari > 0'
        ]
      dist:
        files:
          "app/themes/sprout/assets/css/main.css": ["app/themes/sprout/assets/css/main.css"]

    # Be careful with this. This clears _everything_ within
    #  the app/themes/sprout/ directory
    clean:
      theme:
        src: ["app/themes/sprout/**/*"]

    # This create a style.css file required by WordPress
    "file-creator":
      options:
        openFlags: "w+"
      basic:
        "app/themes/sprout/style.css": (fs, fd, done) ->
          pkg = grunt.file.readJSON "package.json"
          fs.writeSync fd, \
            """
            /*
            Theme Name: #{pkg.name.replace(/-/, " ").replace(/(?:^|\s)\S/g, (s) -> s.toUpperCase())}
            Author: #{pkg.author.name}
            Author URI: #{pkg.author.homepage}
            Description: #{pkg.description}
            Version: #{pkg.version}
            */
            """
          done()

    coffee:
      compile:
        options:
          bare: true
          # sourceMap: true
        expand: true
        cwd: "src/themes"
        src: ["**/*.coffee"]
        dest: "src/themes"
        ext: ".js"

    compass:
      dist:
        options:
          cssDir: "app/themes/sprout/assets/css"
          sassDir: "src/themes/sprout/styles"
          httpPath: "/"
          outputStyle: "expanded"
          require: [
            "flint"
            "sass-globbing"
            "graphite-sass"
            "sassy-export"
            "stampy"
          ]

    concat:
      options:
        banner: "<%= banner %>"
      dist:
        dest: "app/themes/sprout/assets/scripts/main.js"
        src: [
          "src/themes/sprout/scripts/vendor/*.js"
          "src/themes/sprout/scripts/app.js"
        ]

    copy:
      favicon:
        files: [{
          expand: yes
          cwd: "src/themes/sprout"
          src: ["favicon.ico"]
          dest: "app/themes/sprout/"
          rename: (dest, src) -> dest + src
        }]

      fonts:
        files: [{
          expand: yes
          cwd: "src/themes/sprout/fonts"
          src: ["**/*.{woff,woff2,ttf,eot,svg,otf}"]
          dest: "app/themes/sprout/assets/fonts/"
          rename: (dest, src) -> dest + src.replace("/fonts/", "/assets/fonts/")
        },
        {
          expand: yes
          cwd: "bower_components/font-awesome/fonts"
          src: ["**/*.*"]
          dest: "app/themes/sprout/assets/fonts/font-awesome/"
        }]

      scripts:
        files:
          "app/themes/sprout/assets/scripts/jquery.min.js": ["bower_components/jquery/dist/jquery.min.js"]

      functions:
        files: [{
          expand: yes
          cwd: "src/themes/sprout/functions"
          src: ["**/*.*"]
          dest: "app/themes/sprout/"
          rename: (dest, src) -> dest + src.replace("/functions/", "/")
        }]

    cssmin:
      dist:
        files:
          "app/themes/sprout/assets/css/main.min.css": ["app/themes/sprout/assets/css/main.css"]

    haml:
      templates:
        options:
          enableDynamicAttributes: no
        files: [{
          expand: yes
          cwd: "src/themes"
          src: ["**/*.haml"]
          dest: "app/themes/"
          ext: ".php"
          rename: (dest, src) -> dest + src.replace("/templates/", "/")
        }]

    imagemin:
      dist:
        options:
          optimizationLevel: 3
          svgoPlugins: [
            removeViewBox: no
          ]
        files: [{
          expand: yes
          cwd: "src/themes/sprout/images"
          src: ["**/*.{jpg,jpeg,png,gif,svg}"]
          dest: "app/themes/sprout/assets/images/"
        }]

    uglify:
      options:
        banner: "<%= banner %>"
      dist:
        src: ["app/themes/sprout/assets/scripts/main.js"]
        dest: "app/themes/sprout/assets/scripts/main.min.js"

    watch:
      gruntfile:
        tasks: ["default"]
        files: [
          "Gruntfile.coffee"
          "Gruntfile.js"
        ]

      scripts:
        tasks: ["scripts"]
        files: [
          "src/themes/**/*.coffee"
          "src/themes/**/*.js"
        ]

      styles:
        tasks: ["styles"]
        files: [
          "src/themes/**/*.sass"
          "src/themes/**/*.scss"
        ]

      functions:
        tasks: ["newer:copy:functions"]
        files: ["src/themes/**/*.php"]

      templates:
        tasks: ["newer:haml"]
        files: ["src/themes/**/*.haml"]

      fonts:
        tasks: ["newer:copy:fonts"]
        files: ["src/themes/sprout/fonts/**/*.{woff,woff2,ttf,eot,svg,otf}"]

      images:
        tasks: ["newer:imagemin"]
        files: ["src/themes/sprout/images/**/*.{jpg,jpeg,png,gif,svg}"]

      livereload:
        options:
          livereload: yes
        files: [
          "app/themes/sprout/assets/fonts/**/*.{woff,woff2,ttf,eot,svg,otf}"
          "app/themes/sprout/assets/images/**/*.{jpg,jpeg,png,gif,svg}"
          "app/themes/sprout/assets/css/**/*.css"
          "app/themes/sprout/assets/scripts/**/*.js"
          "app/themes/sprout/**/*.{html,php}"
        ]

  grunt.registerTask "default", [
    "build"
    "watch"
  ]

  grunt.registerTask "build", [
    "clean"
    "file-creator"
    "imagemin"
    "assets"
    "templates"
    "styles"
    "scripts"
  ]

  grunt.registerTask "assets", [
    "copy:favicon"
    "copy:fonts"
    "copy:functions"
  ]

  grunt.registerTask "templates", [
    "haml"
  ]

  grunt.registerTask "styles", [
    "compass"
    "autoprefixer"
    "cssmin"
  ]

  grunt.registerTask "scripts", [
    "copy:scripts"
    "coffee"
    "concat"
    "uglify"
  ]
