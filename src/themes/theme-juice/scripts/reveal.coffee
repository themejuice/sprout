###
# Slide-in reveal transitions
#
# @author Ezekiel Gabrielse, Produce Results
# @link https://produceresults.com
###
module.exports =
class Reveal

  ###
  # Add reveal animation to els
  #
  # @param {Object} obj           - Object containing selectors and props
  #
  # @prop {String}  obj.direction - Direction of reveal animation
  # @prop {Integer} obj.offset    - Amount to offset position of el
  # @prop {Integer} obj.delay     - Amount of time in ms to delay animation
  # @prop {Integer} obj.speed     - Speed of the reveal animation in ms
  # @prop {Integer} obj.threshold - Offset amount for Waypoint
  # @prop {Bool}    obj.lock      - Lock element after first reveal
  # @prop {Bool}    obj.mobile    - Reveal effect on mobile
  #
  # @return {Void}
  ###
  constructor: (@obj) ->
    @window = $(window)

    $.each @obj, (el, obj) =>
      if obj.mobile is on or @window.width() > 959
        $el = $(el)

        # Hide el
        $el.css {
            "opacity": 0
        }

        # Set positioning
        @.hide $el, obj.direction, obj.offset, obj.delay

        # Toggle reveal when waypoint is hit
        $el.waypoint =>

          # Set transitions
          $el.css {
            "-moz-transition": "#{obj.speed}ms"
            "-o-transition": "#{obj.speed}ms"
            "-webkit-transition": "#{obj.speed}ms"
            "transition": "#{obj.speed}ms"
          }

          # Lets make sure the el isn't locked
          unless @.isLocked $el

            # Toggle active class
            @.toggle $el

            # Run reveal
            @.run $el, obj.direction, obj.offset, obj.delay

          # Lock class if lock is on
          if obj.lock is on
            @.lock $el unless @.isLocked $el

        , { offset: obj.threshold, continuous: true }

    # Reset els and destroy waypoints on window resize,
    #  not worth the effort of resetting waypoints.
    if @obj.length > 0
      @window.resize => @.destroy @obj

  ###
  # Set translate on $el
  #
  # @param {Object}  $el              - Element to apply transform
  # @param {Array}   transform        - Array of translate values
  # @param {Integer} opacity   (null) - Value of opacity of $el
  #
  # @return {Void}
  ###
  translate: ($el, transform, opacity) ->
    $el.css {
      "opacity": opacity
      "-moz-transform": "translate3d(#{transform.toString()})"
      "-webkit-transform": "translate3d(#{transform.toString()})"
      "transform": "translate3d(#{transform.toString()})"
    }

  ###
  # Lock element
  #
  # @param {Object} $el - Element to lock
  #
  # @return {Void}
  ###
  lock: ($el) ->
    $el.addClass "#{$el.prop("class")?.split(" ")[0]}--locked"

  ###
  # Unlock element
  #
  # @param {Object} $el - Element to unlock
  #
  # @return {Void}
  ###
  unlock: ($el) ->
    $el.removeClass "#{$el.prop("class")?.split(" ")[0]}--locked"

  ###
  # Check if el is locked
  #
  # @param {Object} $el - Element to check if has active class
  #
  # @return {Bool}
  ###
  isLocked: ($el) ->
    $el.hasClass "#{$el.prop("class")?.split(" ")[0]}--locked"

  ###
  # Toggle active class to el
  #
  # @param {Object} $el - Element to toggle
  #
  # @return {Void}
  ###
  toggle: ($el) ->
    $el.toggleClass "#{$el.prop("class")?.split(" ")[0]}--active"

  ###
  # Check if el is active
  #
  # @param {Object} $el - Element to check if has active class
  #
  # @return {Bool}
  ###
  isActive: ($el) ->
    $el.hasClass "#{$el.prop("class")?.split(" ")[0]}--active"

  ###
  # Destroy all waypoints and reset all els
  #
  # @param {Object} els - Elements to reset
  ###
  destroy: (els) ->

    # Destroy waypoints
    $.waypoints "destroy"

    # Loop over els
    $.each els, (el, obj) =>
      $el = $(el)

      # Fade in and reset el to normal position
      @.translate $el, ["0px", "0px", "0px"], 1

  ###
  # Run on el
  #
  # @param {Object}  $el       - Element to apply reveal animation
  # @param {String}  direction - Direction of reveal animation
  # @param {Integer} offset    - Amount to offset position of el
  # @param {Integer} delay     - Amount of time to delay animation
  #
  # @return {Void}
  ###
  run: ($el, direction, offset, delay) ->
    if @isActive $el
      @.reveal $el, direction, offset, delay
    else
      @.hide $el, direction, offset, delay

  ###
  # Reveal animation on el
  #
  # @param {Object}  $el       - Element to apply reveal animation
  # @param {String}  direction - Direction of reveal animation
  # @param {Integer} offset    - Amount to offset position of el
  # @param {Integer} delay     - Amount of time to delay animation
  #
  # @return {Void}
  ###
  reveal: ($el, direction, offset, delay) ->

    # Prepare position of el
    switch direction
      when "top"
        @.translate $el, ["0px", "-#{offset}px", "0px"], 0
      when "right"
        @.translate $el, ["#{offset}px", "0px", "0px"], 0
      when "bottom"
        @.translate $el, ["0px", "#{offset}px", "0px"], 0
      when "left"
        @.translate $el, ["-#{offset}px", "0px", "0px"], 0
      else
        @.translate $el, ["0px", "0px", "0px"], 0

    # Fade in and reset el to normal position
    setTimeout =>
      @.translate $el, ["0px", "0px", "0px"], 1
    , delay

  ###
  # Reset reveal animation to hide el
  #
  # @param {Object}  $el       - Element to apply reset
  # @param {String}  direction - Direction of reset animation
  # @param {Integer} offset    - Amount to offset position of el
  # @param {Integer} delay     - Amount of time to delay reset
  #
  # @return {Void}
  ###
  hide: ($el, direction, offset, delay) ->

    # Reset position of el
    setTimeout =>
      # Prepare position of el
      switch direction
        when "top"
          @.translate $el, ["0px", "-#{offset}px", "0px"], 0
        when "right"
          @.translate $el, ["#{offset}px", "0px", "0px"], 0
        when "bottom"
          @.translate $el, ["0px", "#{offset}px", "0px"], 0
        when "left"
          @.translate $el, ["-#{offset}px", "0px", "0px"], 0
        else
          @.translate $el, ["0px", "0px", "0px"], 0
    , delay
