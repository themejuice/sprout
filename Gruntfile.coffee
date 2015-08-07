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
          "app/themes/theme-juice/assets/css/main.css": ["app/themes/theme-juice/assets/css/main.css"]

    # Be careful with this. This clears _everything_ within
    #  the app/themes/theme-juice/ directory
    clean:
      theme:
        src: ["app/themes/theme-juice/**/*"]

    # This create a style.css file required by WordPress
    "file-creator":
      options:
        openFlags: "w+"
      basic:
        "app/themes/theme-juice/style.css": (fs, fd, done) ->
          fs.writeSync fd, grunt.template.process("/*\nTheme Name: <%= pkg.name %>\nAuthor: <%= pkg.author.name %>\nAuthor URI: <%= pkg.author.homepage %>\nDescription: <%= pkg.description %>\nVersion: <%= pkg.version %>\n*/\n\n")
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
          cssDir: "app/themes/theme-juice/assets/css"
          httpPath: "/"
          outputStyle: "expanded"
          require: ["flint", "sass-globbing", "graphite", "sassy-export", "stampy"]
          sassDir: "src/themes/theme-juice/styles"

    concat:
      options:
        banner: "<%= banner %>"
      dist:
        src: [
          "src/themes/theme-juice/scripts/vendor/*.js"
          "src/themes/theme-juice/scripts/app.js"
        ]
        dest: "app/themes/theme-juice/assets/scripts/main.js"

    copy:
      favicon:
        files: [{
          expand: yes
          cwd: "src/themes/theme-juice"
          src: ["favicon.ico"]
          dest: "app/themes/theme-juice/"
          rename: (dest, src) -> dest + src
        }]

      fonts:
        files: [{
          expand: yes
          cwd: "src/themes/theme-juice/fonts"
          src: ["**/*.{woff,woff2,ttf,eot,svg,otf}"]
          dest: "app/themes/theme-juice/assets/fonts/"
          rename: (dest, src) -> dest + src.replace(/\/fonts\//, "/assets/fonts/")
        },
        {
          expand: true
          cwd: "bower_components/font-awesome/fonts"
          src: ["**/*.*"]
          dest: "app/themes/theme-juice/assets/fonts/"
        }]

      scripts:
        files:
          "app/themes/theme-juice/assets/scripts/jquery.min.js": ["bower_components/jquery/dist/jquery.min.js"]
          "app/themes/theme-juice/assets/scripts/jquery.min.map": ["bower_components/jquery/dist/jquery.min.map"]

      functions:
        files: [{
          expand: yes
          cwd: "src/themes/theme-juice/functions"
          src: ["**/*.*"]
          dest: "app/themes/theme-juice/"
          rename: (dest, src) -> dest + src.replace(/\/functions\//, "/")
        }]

      templates:
        files: [{
          expand: yes
          cwd: "src/themes/theme-juice/templates"
          src: ["**/*.php"]
          dest: "app/themes/theme-juice/"
          rename: (dest, src) -> dest + src.replace(/\/templates\//, "/")
        }]

    cssmin:
      dist:
        files:
          "app/themes/theme-juice/assets/css/main.min.css": ["app/themes/theme-juice/assets/css/main.css"]

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
          rename: (dest, src) -> dest + src.replace(/\/templates\//, "/")
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
          cwd: "src/themes/theme-juice/images"
          src: ["**/*.{jpg,jpeg,png,gif,svg}"]
          dest: "app/themes/theme-juice/assets/images/"
        }]

    uglify:
      options:
        banner: "<%= banner %>"
      dist:
        src: ["app/themes/theme-juice/assets/scripts/main.js"]
        dest: "app/themes/theme-juice/assets/scripts/main.min.js"

    watch:
      gruntfile:
        files: [
          "Gruntfile.coffee"
          "Gruntfile.js"
        ]
        tasks: ["default"]

      scripts:
        files: [
          "src/themes/**/*.coffee"
          "src/themes/**/*.js"
        ]
        tasks: ["scripts"]
        options:
          livereload: yes

      styles:
        files: [
          "src/themes/**/*.sass"
          "src/themes/**/*.scss"
        ]
        tasks: ["styles"]
        options:
          livereload: yes

      functions:
        files: [
          "src/themes/**/*.php"
        ]
        tasks: [
          "newer:copy:functions"
        ]
        options:
          livereload: yes

      templates:
        files: [
          "src/themes/**/*.haml"
        ]
        tasks: [
          "newer:haml"
          "newer:copy:templates"
        ]
        options:
          livereload: yes

      fonts:
        files: [
          "src/themes/theme-juice/fonts/**/*.woff"
          "src/themes/theme-juice/fonts/**/*.woff2"
          "src/themes/theme-juice/fonts/**/*.tff"
          "src/themes/theme-juice/fonts/**/*.eot"
          "src/themes/theme-juice/fonts/**/*.svg"
          "src/themes/theme-juice/fonts/**/*.otf"
        ]
        tasks: ["newer:copy:fonts"]
        options:
          livereload: yes

      images:
        files: [
          "src/themes/theme-juice/images/**/*.jpg"
          "src/themes/theme-juice/images/**/*.jpeg"
          "src/themes/theme-juice/images/**/*.png"
          "src/themes/theme-juice/images/**/*.gif"
          "src/themes/theme-juice/images/**/*.svg"
        ]
        tasks: ["newer:imagemin"]
        options:
          livereload: yes

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
    "copy:templates"
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
