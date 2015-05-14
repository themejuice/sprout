###
# Parallax effect
#
# @author Ezekiel Gabrielse, Produce Results
# @link https://produceresults.com
###
module.exports =
class Parallax

  ###
  # Add parallax effect to els
  #
  # @param {Object} obj            - Object containing selectors and props
  #
  # @prop {Integer} obj.distance   - Distance of el from main z-index
  # @prop {Integer} obj.offset     - Amount to offset el
  # @prop {Bool}    obj.reverse    - Reverse direction of effect
  # @prop {Bool}    obj.fade       - Toggle opacity fade
  # @prop {Bool}    obj.restrict   - Restrict translate to direction of parallax
  # @prop {Integer} obj.smoothness - Smoothness of animation, uses transition
  # @prop {Bool}    obj.container  - Will apply parallax to el.parent()
  # @prop {Integer} obj.threshold  - Offset amount for Waypoint
  # @prop {Bool}    obj.initialize - Run at start
  # @prop {Bool}    obj.waypoint   - Use waypoint to start parallax
  # @prop {Bool}    obj.mobile     - Parallax effect on mobile
  #
  # @return {Void}
  ###
  constructor: (@obj) ->
    @window = $(window)

    $.each @obj, (el, obj) =>
      @mobile = obj.mobile

      if @mobile is on or @window.width() > 959

        # Check if el has container
        if obj.container is on
          $el = $(el).parent()
        else
          $el = $(el)

        # Initial run
        if obj.initialize is on
          @.run $el, obj.distance, obj.offset, obj.reverse, obj.fade, obj.restrict

        # Add active class when waypoint is hit
        if obj.waypoint is on
          $el.waypoint =>
            @.activate $el
          , { offset: obj.threshold, continuous: true }
        else
          @.activate $el

        ###
        # Add transitions for smoother scrolling on Windows only
        #
        # @todo - This feels and looks super hacky and probably shouldn't be used
        ###
        if obj.smoothness isnt off
          unless navigator.platform.match(/(Mac|iPhone|iPod|iPad)/i)?
            $el.css {
              "-moz-transition": "#{obj.smoothness}ms"
              "-o-transition": "#{obj.smoothness}ms"
              "-webkit-transition": "#{obj.smoothness}ms"
              "transition": "#{obj.smoothness}ms"
            }

        # Update on scroll
        @window.scroll =>
          if @.isActive $el
            @.run $el, obj.distance, obj.offset, obj.reverse, obj.fade, obj.restrict

  ###
  # Round number
  #
  # @param {Integer} num
  # @param {Integer} precision (2)
  #
  # @return {Integer} - Rounded num
  ###
  round: (num, precision = 2) ->
    +(Math.round(num + "e+#{precision}") + "e-#{precision}")

  ###
  # Add active class to el
  #
  # @param {Object} $el - Element to activate
  #
  # @return {Void}
  ###
  activate: ($el) ->
    $el.toggleClass "#{$el.prop("class")?.split(" ")[0]}--active"

  ###
  # Check if parallax is already active
  #
  # @param {Object} $el - Element to check if has active class
  #
  # @return {Bool}
  ###
  isActive: ($el) ->
    $el.hasClass "#{$el.prop("class")?.split(" ")[0]}--active"

  ###
  # Check if el is in view
  #
  # @param {Object} $el - Element to check
  #
  # @return {Bool}
  ###
  isVisible: ($el) ->
    scrolled = @.round($el.offset().top - @window.scrollTop(), 0)
    return scrolled < 1500 and scrolled > -1500

  ###
  # Run parallax effect
  #
  # @param {Object}  $el      - Element to apply parallax to
  # @param {Integer} distance - Distance of el from main z-index
  # @param {Integer} offset   - Amount to offset el
  # @param {Bool}    reverse  - Reverse direction of parallax
  # @param {Bool}    fade     - Toggle opacity fade
  # @param {Bool}    restrict - Restrict translate to direction of parallax
  #
  # @return {Void}
  ###
  run: ($el, distance, offset, reverse, fade, restrict) ->

    # Make sure el exists
    if $el.length

      # Get scroll amount
      scrolled = ($el.offset().top + offset) - @window.scrollTop()

      # Lets not calculate this if el is off-screen
      if @.isVisible $el

        # Check if fade is enabled
        if fade is on and (scrolled - offset) > 100
          $el.css { "opacity": 2.0 - ((scrolled - offset) * 0.0025) }

        # Calculate translate amount
        translate = scrolled / distance * if reverse then -1 else 1

        # Apply translate if going in active direction
        if restrict is off or reverse and translate > 0 or not reverse and translate < 0
          $el.css {
            "-moz-transform": "translate3d(0, #{@.round(translate)}px, 0)"
            "-webkit-transform": "translate3d(0, #{@.round(translate)}px, 0)"
            "transform": "translate3d(0, #{@.round(translate)}px, 0)"
          }
        # Reset translate if el is inactive
        else
          $el.css {
            "-moz-transform": "translate3d(0, 0, 0)"
            "-webkit-transform": "translate3d(0, 0, 0)"
            "transform": "translate3d(0, 0, 0)"
          }
