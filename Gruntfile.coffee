module.exports = (grunt) ->
  "use strict"

  require("jit-grunt") grunt,
    haml: "grunt-haml-php"

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    banner: "/*! <%= pkg.name %> - v<%= pkg.version %>\n" + "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" + "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %> <<%= pkg.author.homepage %>>" + " */\n\n"

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

    browserify:
      dist:
        options:
          global: yes
          banner: "<%= banner %>"
        files: [{
          src: [
            "src/themes/theme-juice/scripts/**/*.coffee"
            "src/themes/theme-juice/scripts/**/*.js"
          ]
          dest: "app/themes/theme-juice/assets/scripts/main.js"
        }]

    compass:
      dist:
        options:
          cssDir: "app/themes/theme-juice/assets/css"
          httpPath: "/"
          outputStyle: "expanded"
          require: ["flint", "sass-globbing", "graphite", "sassy-export", "stampy"]
          sassDir: "src/themes/theme-juice/styles"

    copy:
      templates:
        files: [{
          expand: yes
          cwd: "src/themes"
          src: ["**/*.php"]
          dest: "app/themes/"
          rename: (dest, src) -> dest + src.replace(/\/templates\//, "/")
        }]

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
          src: ["**/*.{woff,woff2,tff,eot,svg,otf}"]
          dest: "app/themes/theme-juice/assets/fonts/"
          rename: (dest, src) -> dest + src.replace(/\/fonts\//, "/assets/fonts/")
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

    uglify:
      options:
        banner: "<%= banner %>"
      dist:
        src: ["app/themes/theme-juice/assets/scripts/main.js"]
        dest: "app/themes/theme-juice/assets/scripts/main.min.js"

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
          src: ["**/*.{png,jpg,gif}"]
          dest: "app/themes/theme-juice/assets/images/"
        }, {
          expand: yes
          cwd: "src/themes/theme-juice/svg"
          src: ["**/*.svg"]
          dest: "app/themes/theme-juice/assets/svg/"
        }]

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

      templates:
        files: [
          "src/themes/**/*.haml"
          "src/themes/**/*.php"
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
          "src/themes/theme-juice/images/**/*.png"
          "src/themes/theme-juice/images/**/*.gif"
          "src/themes/theme-juice/svg/**/*.svg"
        ]
        tasks: ["newer:imagemin"]
        options:
          livereload: yes

  # Default task
  grunt.registerTask "default", [
    "clean"
    "file-creator"
    "copy:favicon"
    "copy:fonts"
    "imagemin"
    "templates"
    "styles"
    "scripts"
    "watch"
  ]

  # Build task
  grunt.registerTask "build", [
    "clean"
    "file-creator"
    "copy:favicon"
    "copy:fonts"
    "imagemin"
    "templates"
    "styles"
    "scripts"
  ]

  # Templates
  grunt.registerTask "templates", [
    "copy:templates"
    "haml"
  ]

  # Styles
  grunt.registerTask "styles", [
    "compass"
    "cssmin"
  ]

  # Scripts
  grunt.registerTask "scripts", [
    "browserify"
    "uglify"
  ]
