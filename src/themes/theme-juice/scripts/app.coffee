"use-strict"

require "jquery"
require "waypoints"

Parallax = require "./parallax.coffee"
Reveal   = require "./reveal.coffee"
Slider   = require "./slider.coffee"

$(document).ready ->

  # #
  # # Parallax
  # #
  # parallax = new Parallax {
  #   ".slider__wrapper": {
  #     distance: 25
  #     offset: 0
  #     reverse: true
  #     fade: false
  #     restrict: false
  #     smoothness: false
  #     container: false
  #     threshold: 0
  #     initialize: true
  #     waypoint: false
  #     mobile: true
  #   }
  #   ".slider": {
  #     distance: 25
  #     offset: 0
  #     reverse: false
  #     fade: false
  #     restrict: false
  #     smoothness: false
  #     container: false
  #     threshold: 0
  #     initialize: true
  #     waypoint: false
  #     mobile: true
  #   }
  # }

  # #
  # # Reveal
  # #
  # reveal = new Reveal {
  #   ".services__service:nth-child(1)": {
  #     direction: "bottom"
  #     offset: 100
  #     delay: 120
  #     speed: 1000
  #     threshold: 1000
  #     mobile: true
  #   }
  #   ".services__service:nth-child(2)": {
  #     direction: "bottom"
  #     offset: 100
  #     delay: 240
  #     speed: 1000
  #     threshold: 1000
  #     mobile: true
  #   }
  #   ".services__service:nth-child(3)": {
  #     direction: "bottom"
  #     offset: 100
  #     delay: 360
  #     speed: 1000
  #     threshold: 1000
  #     mobile: true
  #   }
  #   ".services__service:nth-child(4)": {
  #     direction: "bottom"
  #     offset: 100
  #     delay: 480
  #     speed: 1000
  #     threshold: 1000
  #     mobile: true
  #   }
  # }

  # #
  # # Slider
  # #
  # slider = new Slider {
  #   ".slider__slide--active": {
  #     "interval": 7500
  #     "transition": 2500
  #     "adjust": false
  #   }
  # }

  #
  # Hamburger menu
  #
  $hamburger = $(".hamburger")

  $hamburger.click () ->
    $(@).next("div").children("ul").slideToggle("fast")

  #
  # Add focus class to map
  #
  $map = $(".map")

  $map.click () ->
    $(@).addClass("map--focus") unless $(@).hasClass("map--focus")

  #
  # Accordion menu
  #
  $accordion = $(".accordion__hook")

  $accordion.click () ->
    $(@).parents(".accordion").children(".accordion__content").slideToggle("fast")

  #
  # Scroll to element
  #
  $scrollFrom = $(".scroll-to")

  $scrollFrom.click (e) ->
    e.preventDefault()

    # Get href
    $scrollTo = $($(@).attr("href"))
    $page = $("html, body")

    # Scroll to href value of element
    $page.stop().animate {
      scrollTop: $scrollTo.offset().top # + if $window.width() > 639 then -100 else -50
    }, 360, "swing"
