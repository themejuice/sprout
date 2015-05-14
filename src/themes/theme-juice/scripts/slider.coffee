###
# Slider
#
# @example
#    ```haml
#    .slider__wrapper
#      .slider
#        .slider__slide.slider__slide--active
#          ...
#        .slider__slide
#          ...
#        .slider__slide
#          ...
#        .slider__slide
#          ...
#    ```
#
# @author Ezekiel Gabrielse, Produce Results
# @link https://produceresults.com
###
module.exports =
class Slider

  ###
  # Constructor
  #
  # @param {Object} obj            - Object containing selectors and settings
  #
  # @prop {Integer} obj.interval   - Duration of each slide interval
  # @prop {Integer} obj.transition - Duration of transitional fade
  # @prop {Bool}    obj.adjust     - Automatically adjust parent height
  #
  # @return {Void}
  ###
  constructor: (@obj) ->

    $.each @obj, (el, settings) =>

      # Set active class
      settings.active = el[1..-1]

      # Adjust slider on initial load
      @.adjustParent $(el).first(), $(el).first().parent()

      # Set interval for slider
      setInterval () =>
        $currentSlide = $(el).first()
        $nextSlide = $currentSlide.next()
        $slideParent = $currentSlide.parent()

        # Set transitions on parent
        if settings.adjust is on
          $slideParent.css {
            "-moz-transition": "500ms"
            "-o-transition": "500ms"
            "-webkit-transition": "500ms"
            "transition": "500ms"
          }

        @.fadeToNextSlide $currentSlide, $nextSlide, $slideParent, settings
      , settings.interval

  ###
  # Fade to next slide
  #
  # @param {Object} $currentSlide - jQuery object for current slide
  # @param {Object} $nextSlide    - jQuery object for next slide
  # @param {Object} $slideParent  - jQuery object for slide's parent
  # @param {Object} settings      - Object containing slider settings
  #
  # @return {Void}
  ###
  fadeToNextSlide: ($currentSlide, $nextSlide, $slideParent, settings) ->

    # If current slide's height is less than next slide's height, adjust height
    #  now, else adjust it after new slide is revealed
    if settings.adjust is on and $currentSlide.height() < $nextSlide.height()
      @.adjustParent $nextSlide, $slideParent

    $nextSlide.addClass(settings.active).fadeIn settings.transition, () =>
      $currentSlide.fadeOut(0).removeClass(settings.active).appendTo $slideParent

      if settings.adjust is on and $currentSlide.height() > $nextSlide.height()
        @.adjustParent $nextSlide, $slideParent

  ###
  # Adjust parent height to match child's height
  #
  # @param {Object} $el      - jQuery object of slider
  # @param {Object} $parent  - jQuery object of slider parent
  #
  # @return {Void}
  ###
  adjustParent: ($el, $parent) ->
    $parent.css { "height": $el.css("height") }
