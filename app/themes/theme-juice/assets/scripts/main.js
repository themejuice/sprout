/*! ThemeJuiceStarter - v0.1.0
* http://themejuice.it
* Copyright (c) 2015 Produce Results <http://produceresults.com> */


(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/*!
Waypoints - 3.1.1
Copyright © 2011-2015 Caleb Troughton
Licensed under the MIT license.
https://github.com/imakewebthings/waypoints/blog/master/licenses.txt
*/
!function(){"use strict";function t(o){if(!o)throw new Error("No options passed to Waypoint constructor");if(!o.element)throw new Error("No element option passed to Waypoint constructor");if(!o.handler)throw new Error("No handler option passed to Waypoint constructor");this.key="waypoint-"+e,this.options=t.Adapter.extend({},t.defaults,o),this.element=this.options.element,this.adapter=new t.Adapter(this.element),this.callback=o.handler,this.axis=this.options.horizontal?"horizontal":"vertical",this.enabled=this.options.enabled,this.triggerPoint=null,this.group=t.Group.findOrCreate({name:this.options.group,axis:this.axis}),this.context=t.Context.findOrCreateByElement(this.options.context),t.offsetAliases[this.options.offset]&&(this.options.offset=t.offsetAliases[this.options.offset]),this.group.add(this),this.context.add(this),i[this.key]=this,e+=1}var e=0,i={};t.prototype.queueTrigger=function(t){this.group.queueTrigger(this,t)},t.prototype.trigger=function(t){this.enabled&&this.callback&&this.callback.apply(this,t)},t.prototype.destroy=function(){this.context.remove(this),this.group.remove(this),delete i[this.key]},t.prototype.disable=function(){return this.enabled=!1,this},t.prototype.enable=function(){return this.context.refresh(),this.enabled=!0,this},t.prototype.next=function(){return this.group.next(this)},t.prototype.previous=function(){return this.group.previous(this)},t.invokeAll=function(t){var e=[];for(var o in i)e.push(i[o]);for(var n=0,r=e.length;r>n;n++)e[n][t]()},t.destroyAll=function(){t.invokeAll("destroy")},t.disableAll=function(){t.invokeAll("disable")},t.enableAll=function(){t.invokeAll("enable")},t.refreshAll=function(){t.Context.refreshAll()},t.viewportHeight=function(){return window.innerHeight||document.documentElement.clientHeight},t.viewportWidth=function(){return document.documentElement.clientWidth},t.adapters=[],t.defaults={context:window,continuous:!0,enabled:!0,group:"default",horizontal:!1,offset:0},t.offsetAliases={"bottom-in-view":function(){return this.context.innerHeight()-this.adapter.outerHeight()},"right-in-view":function(){return this.context.innerWidth()-this.adapter.outerWidth()}},window.Waypoint=t}(),function(){"use strict";function t(t){window.setTimeout(t,1e3/60)}function e(t){this.element=t,this.Adapter=n.Adapter,this.adapter=new this.Adapter(t),this.key="waypoint-context-"+i,this.didScroll=!1,this.didResize=!1,this.oldScroll={x:this.adapter.scrollLeft(),y:this.adapter.scrollTop()},this.waypoints={vertical:{},horizontal:{}},t.waypointContextKey=this.key,o[t.waypointContextKey]=this,i+=1,this.createThrottledScrollHandler(),this.createThrottledResizeHandler()}var i=0,o={},n=window.Waypoint,r=window.onload;e.prototype.add=function(t){var e=t.options.horizontal?"horizontal":"vertical";this.waypoints[e][t.key]=t,this.refresh()},e.prototype.checkEmpty=function(){var t=this.Adapter.isEmptyObject(this.waypoints.horizontal),e=this.Adapter.isEmptyObject(this.waypoints.vertical);t&&e&&(this.adapter.off(".waypoints"),delete o[this.key])},e.prototype.createThrottledResizeHandler=function(){function t(){e.handleResize(),e.didResize=!1}var e=this;this.adapter.on("resize.waypoints",function(){e.didResize||(e.didResize=!0,n.requestAnimationFrame(t))})},e.prototype.createThrottledScrollHandler=function(){function t(){e.handleScroll(),e.didScroll=!1}var e=this;this.adapter.on("scroll.waypoints",function(){(!e.didScroll||n.isTouch)&&(e.didScroll=!0,n.requestAnimationFrame(t))})},e.prototype.handleResize=function(){n.Context.refreshAll()},e.prototype.handleScroll=function(){var t={},e={horizontal:{newScroll:this.adapter.scrollLeft(),oldScroll:this.oldScroll.x,forward:"right",backward:"left"},vertical:{newScroll:this.adapter.scrollTop(),oldScroll:this.oldScroll.y,forward:"down",backward:"up"}};for(var i in e){var o=e[i],n=o.newScroll>o.oldScroll,r=n?o.forward:o.backward;for(var s in this.waypoints[i]){var a=this.waypoints[i][s],l=o.oldScroll<a.triggerPoint,h=o.newScroll>=a.triggerPoint,p=l&&h,u=!l&&!h;(p||u)&&(a.queueTrigger(r),t[a.group.id]=a.group)}}for(var c in t)t[c].flushTriggers();this.oldScroll={x:e.horizontal.newScroll,y:e.vertical.newScroll}},e.prototype.innerHeight=function(){return this.element==this.element.window?n.viewportHeight():this.adapter.innerHeight()},e.prototype.remove=function(t){delete this.waypoints[t.axis][t.key],this.checkEmpty()},e.prototype.innerWidth=function(){return this.element==this.element.window?n.viewportWidth():this.adapter.innerWidth()},e.prototype.destroy=function(){var t=[];for(var e in this.waypoints)for(var i in this.waypoints[e])t.push(this.waypoints[e][i]);for(var o=0,n=t.length;n>o;o++)t[o].destroy()},e.prototype.refresh=function(){var t,e=this.element==this.element.window,i=this.adapter.offset(),o={};this.handleScroll(),t={horizontal:{contextOffset:e?0:i.left,contextScroll:e?0:this.oldScroll.x,contextDimension:this.innerWidth(),oldScroll:this.oldScroll.x,forward:"right",backward:"left",offsetProp:"left"},vertical:{contextOffset:e?0:i.top,contextScroll:e?0:this.oldScroll.y,contextDimension:this.innerHeight(),oldScroll:this.oldScroll.y,forward:"down",backward:"up",offsetProp:"top"}};for(var n in t){var r=t[n];for(var s in this.waypoints[n]){var a,l,h,p,u,c=this.waypoints[n][s],d=c.options.offset,f=c.triggerPoint,w=0,y=null==f;c.element!==c.element.window&&(w=c.adapter.offset()[r.offsetProp]),"function"==typeof d?d=d.apply(c):"string"==typeof d&&(d=parseFloat(d),c.options.offset.indexOf("%")>-1&&(d=Math.ceil(r.contextDimension*d/100))),a=r.contextScroll-r.contextOffset,c.triggerPoint=w+a-d,l=f<r.oldScroll,h=c.triggerPoint>=r.oldScroll,p=l&&h,u=!l&&!h,!y&&p?(c.queueTrigger(r.backward),o[c.group.id]=c.group):!y&&u?(c.queueTrigger(r.forward),o[c.group.id]=c.group):y&&r.oldScroll>=c.triggerPoint&&(c.queueTrigger(r.forward),o[c.group.id]=c.group)}}for(var g in o)o[g].flushTriggers();return this},e.findOrCreateByElement=function(t){return e.findByElement(t)||new e(t)},e.refreshAll=function(){for(var t in o)o[t].refresh()},e.findByElement=function(t){return o[t.waypointContextKey]},window.onload=function(){r&&r(),e.refreshAll()},n.requestAnimationFrame=function(e){var i=window.requestAnimationFrame||window.mozRequestAnimationFrame||window.webkitRequestAnimationFrame||t;i.call(window,e)},n.Context=e}(),function(){"use strict";function t(t,e){return t.triggerPoint-e.triggerPoint}function e(t,e){return e.triggerPoint-t.triggerPoint}function i(t){this.name=t.name,this.axis=t.axis,this.id=this.name+"-"+this.axis,this.waypoints=[],this.clearTriggerQueues(),o[this.axis][this.name]=this}var o={vertical:{},horizontal:{}},n=window.Waypoint;i.prototype.add=function(t){this.waypoints.push(t)},i.prototype.clearTriggerQueues=function(){this.triggerQueues={up:[],down:[],left:[],right:[]}},i.prototype.flushTriggers=function(){for(var i in this.triggerQueues){var o=this.triggerQueues[i],n="up"===i||"left"===i;o.sort(n?e:t);for(var r=0,s=o.length;s>r;r+=1){var a=o[r];(a.options.continuous||r===o.length-1)&&a.trigger([i])}}this.clearTriggerQueues()},i.prototype.next=function(e){this.waypoints.sort(t);var i=n.Adapter.inArray(e,this.waypoints),o=i===this.waypoints.length-1;return o?null:this.waypoints[i+1]},i.prototype.previous=function(e){this.waypoints.sort(t);var i=n.Adapter.inArray(e,this.waypoints);return i?this.waypoints[i-1]:null},i.prototype.queueTrigger=function(t,e){this.triggerQueues[e].push(t)},i.prototype.remove=function(t){var e=n.Adapter.inArray(t,this.waypoints);e>-1&&this.waypoints.splice(e,1)},i.prototype.first=function(){return this.waypoints[0]},i.prototype.last=function(){return this.waypoints[this.waypoints.length-1]},i.findOrCreate=function(t){return o[t.axis][t.name]||new i(t)},n.Group=i}(),function(){"use strict";function t(t){this.$element=e(t)}var e=window.jQuery,i=window.Waypoint;e.each(["innerHeight","innerWidth","off","offset","on","outerHeight","outerWidth","scrollLeft","scrollTop"],function(e,i){t.prototype[i]=function(){var t=Array.prototype.slice.call(arguments);return this.$element[i].apply(this.$element,t)}}),e.each(["extend","inArray","isEmptyObject"],function(i,o){t[o]=e[o]}),i.adapters.push({name:"jquery",Adapter:t}),i.Adapter=t}(),function(){"use strict";function t(t){return function(){var i=[],o=arguments[0];return t.isFunction(arguments[0])&&(o=t.extend({},arguments[1]),o.handler=arguments[0]),this.each(function(){var n=t.extend({},o,{element:this});"string"==typeof n.context&&(n.context=t(this).closest(n.context)[0]),i.push(new e(n))}),i}}var e=window.Waypoint;window.jQuery&&(window.jQuery.fn.waypoint=t(window.jQuery)),window.Zepto&&(window.Zepto.fn.waypoint=t(window.Zepto))}();
},{}],2:[function(require,module,exports){
"use-strict";
var $, Parallax, Reveal, Slider;

$ = (window.$);

$.waypoints = require("waypoints");

Parallax = require("./parallax.coffee");

Reveal = require("./reveal.coffee");

Slider = require("./slider.coffee");

$(document).ready(function() {
  var $accordion, $hamburger, $map, $scrollFrom;
  $hamburger = $(".hamburger");
  $hamburger.click(function() {
    return $(this).next("div").children("ul").slideToggle("fast");
  });
  $map = $(".map");
  $map.click(function() {
    if (!$(this).hasClass("map--focus")) {
      return $(this).addClass("map--focus");
    }
  });
  $accordion = $(".accordion__hook");
  $accordion.click(function() {
    return $(this).parents(".accordion").children(".accordion__content").slideToggle("fast");
  });
  $scrollFrom = $(".scroll-to");
  return $scrollFrom.click(function(e) {
    var $page, $scrollTo;
    e.preventDefault();
    $scrollTo = $($(this).attr("href"));
    $page = $("html, body");
    return $page.stop().animate({
      scrollTop: $scrollTo.offset().top
    }, 360, "swing");
  });
});



},{"./parallax.coffee":3,"./reveal.coffee":4,"./slider.coffee":5,"waypoints":1}],3:[function(require,module,exports){

/*
 * Parallax effect
#
 * @author Ezekiel Gabrielse, Produce Results
 * @link https://produceresults.com
 */
var Parallax;

module.exports = Parallax = (function() {

  /*
   * Add parallax effect to els
  #
   * @param {Object} obj            - Object containing selectors and props
  #
   * @prop {Integer} obj.distance   - Distance of el from main z-index
   * @prop {Integer} obj.offset     - Amount to offset el
   * @prop {Bool}    obj.reverse    - Reverse direction of effect
   * @prop {Bool}    obj.fade       - Toggle opacity fade
   * @prop {Bool}    obj.restrict   - Restrict translate to direction of parallax
   * @prop {Integer} obj.smoothness - Smoothness of animation, uses transition
   * @prop {Bool}    obj.container  - Will apply parallax to el.parent()
   * @prop {Integer} obj.threshold  - Offset amount for Waypoint
   * @prop {Bool}    obj.initialize - Run at start
   * @prop {Bool}    obj.waypoint   - Use waypoint to start parallax
   * @prop {Bool}    obj.mobile     - Parallax effect on mobile
  #
   * @return {Void}
   */
  function Parallax(obj1) {
    this.obj = obj1;
    this.window = $(window);
    $.each(this.obj, (function(_this) {
      return function(el, obj) {
        var $el;
        _this.mobile = obj.mobile;
        if (_this.mobile === true || _this.window.width() > 959) {
          if (obj.container === true) {
            $el = $(el).parent();
          } else {
            $el = $(el);
          }
          if (obj.initialize === true) {
            _this.run($el, obj.distance, obj.offset, obj.reverse, obj.fade, obj.restrict);
          }
          if (obj.waypoint === true) {
            $el.waypoint(function() {
              return _this.activate($el);
            }, {
              offset: obj.threshold,
              continuous: true
            });
          } else {
            _this.activate($el);
          }

          /*
           * Add transitions for smoother scrolling on Windows only
          #
           * @todo - This feels and looks super hacky and probably shouldn't be used
           */
          if (obj.smoothness !== false) {
            if (navigator.platform.match(/(Mac|iPhone|iPod|iPad)/i) == null) {
              $el.css({
                "-moz-transition": obj.smoothness + "ms",
                "-o-transition": obj.smoothness + "ms",
                "-webkit-transition": obj.smoothness + "ms",
                "transition": obj.smoothness + "ms"
              });
            }
          }
          return _this.window.scroll(function() {
            if (_this.isActive($el)) {
              return _this.run($el, obj.distance, obj.offset, obj.reverse, obj.fade, obj.restrict);
            }
          });
        }
      };
    })(this));
  }


  /*
   * Round number
  #
   * @param {Integer} num
   * @param {Integer} precision (2)
  #
   * @return {Integer} - Rounded num
   */

  Parallax.prototype.round = function(num, precision) {
    if (precision == null) {
      precision = 2;
    }
    return +(Math.round(num + ("e+" + precision)) + ("e-" + precision));
  };


  /*
   * Add active class to el
  #
   * @param {Object} $el - Element to activate
  #
   * @return {Void}
   */

  Parallax.prototype.activate = function($el) {
    var ref;
    return $el.toggleClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--active");
  };


  /*
   * Check if parallax is already active
  #
   * @param {Object} $el - Element to check if has active class
  #
   * @return {Bool}
   */

  Parallax.prototype.isActive = function($el) {
    var ref;
    return $el.hasClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--active");
  };


  /*
   * Check if el is in view
  #
   * @param {Object} $el - Element to check
  #
   * @return {Bool}
   */

  Parallax.prototype.isVisible = function($el) {
    var scrolled;
    scrolled = this.round($el.offset().top - this.window.scrollTop(), 0);
    return scrolled < 1500 && scrolled > -1500;
  };


  /*
   * Run parallax effect
  #
   * @param {Object}  $el      - Element to apply parallax to
   * @param {Integer} distance - Distance of el from main z-index
   * @param {Integer} offset   - Amount to offset el
   * @param {Bool}    reverse  - Reverse direction of parallax
   * @param {Bool}    fade     - Toggle opacity fade
   * @param {Bool}    restrict - Restrict translate to direction of parallax
  #
   * @return {Void}
   */

  Parallax.prototype.run = function($el, distance, offset, reverse, fade, restrict) {
    var scrolled, translate;
    if ($el.length) {
      scrolled = ($el.offset().top + offset) - this.window.scrollTop();
      if (this.isVisible($el)) {
        if (fade === true && (scrolled - offset) > 100) {
          $el.css({
            "opacity": 2.0 - ((scrolled - offset) * 0.0025)
          });
        }
        translate = scrolled / distance * (reverse ? -1 : 1);
        if (restrict === false || reverse && translate > 0 || !reverse && translate < 0) {
          return $el.css({
            "-moz-transform": "translate3d(0, " + (this.round(translate)) + "px, 0)",
            "-webkit-transform": "translate3d(0, " + (this.round(translate)) + "px, 0)",
            "transform": "translate3d(0, " + (this.round(translate)) + "px, 0)"
          });
        } else {
          return $el.css({
            "-moz-transform": "translate3d(0, 0, 0)",
            "-webkit-transform": "translate3d(0, 0, 0)",
            "transform": "translate3d(0, 0, 0)"
          });
        }
      }
    }
  };

  return Parallax;

})();



},{}],4:[function(require,module,exports){

/*
 * Slide-in reveal transitions
#
 * @author Ezekiel Gabrielse, Produce Results
 * @link https://produceresults.com
 */
var Reveal;

module.exports = Reveal = (function() {

  /*
   * Add reveal animation to els
  #
   * @param {Object} obj           - Object containing selectors and props
  #
   * @prop {String}  obj.direction - Direction of reveal animation
   * @prop {Integer} obj.offset    - Amount to offset position of el
   * @prop {Integer} obj.delay     - Amount of time in ms to delay animation
   * @prop {Integer} obj.speed     - Speed of the reveal animation in ms
   * @prop {Integer} obj.threshold - Offset amount for Waypoint
   * @prop {Bool}    obj.lock      - Lock element after first reveal
   * @prop {Bool}    obj.mobile    - Reveal effect on mobile
  #
   * @return {Void}
   */
  function Reveal(obj1) {
    this.obj = obj1;
    this.window = $(window);
    $.each(this.obj, (function(_this) {
      return function(el, obj) {
        var $el;
        if (obj.mobile === true || _this.window.width() > 959) {
          $el = $(el);
          $el.css({
            "opacity": 0
          });
          _this.hide($el, obj.direction, obj.offset, obj.delay);
          return $el.waypoint(function() {
            $el.css({
              "-moz-transition": obj.speed + "ms",
              "-o-transition": obj.speed + "ms",
              "-webkit-transition": obj.speed + "ms",
              "transition": obj.speed + "ms"
            });
            if (!_this.isLocked($el)) {
              _this.toggle($el);
              _this.run($el, obj.direction, obj.offset, obj.delay);
            }
            if (obj.lock === true) {
              if (!_this.isLocked($el)) {
                return _this.lock($el);
              }
            }
          }, {
            offset: obj.threshold,
            continuous: true
          });
        }
      };
    })(this));
    if (this.obj.length > 0) {
      this.window.resize((function(_this) {
        return function() {
          return _this.destroy(_this.obj);
        };
      })(this));
    }
  }


  /*
   * Set translate on $el
  #
   * @param {Object}  $el              - Element to apply transform
   * @param {Array}   transform        - Array of translate values
   * @param {Integer} opacity   (null) - Value of opacity of $el
  #
   * @return {Void}
   */

  Reveal.prototype.translate = function($el, transform, opacity) {
    return $el.css({
      "opacity": opacity,
      "-moz-transform": "translate3d(" + (transform.toString()) + ")",
      "-webkit-transform": "translate3d(" + (transform.toString()) + ")",
      "transform": "translate3d(" + (transform.toString()) + ")"
    });
  };


  /*
   * Lock element
  #
   * @param {Object} $el - Element to lock
  #
   * @return {Void}
   */

  Reveal.prototype.lock = function($el) {
    var ref;
    return $el.addClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--locked");
  };


  /*
   * Unlock element
  #
   * @param {Object} $el - Element to unlock
  #
   * @return {Void}
   */

  Reveal.prototype.unlock = function($el) {
    var ref;
    return $el.removeClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--locked");
  };


  /*
   * Check if el is locked
  #
   * @param {Object} $el - Element to check if has active class
  #
   * @return {Bool}
   */

  Reveal.prototype.isLocked = function($el) {
    var ref;
    return $el.hasClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--locked");
  };


  /*
   * Toggle active class to el
  #
   * @param {Object} $el - Element to toggle
  #
   * @return {Void}
   */

  Reveal.prototype.toggle = function($el) {
    var ref;
    return $el.toggleClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--active");
  };


  /*
   * Check if el is active
  #
   * @param {Object} $el - Element to check if has active class
  #
   * @return {Bool}
   */

  Reveal.prototype.isActive = function($el) {
    var ref;
    return $el.hasClass(((ref = $el.prop("class")) != null ? ref.split(" ")[0] : void 0) + "--active");
  };


  /*
   * Destroy all waypoints and reset all els
  #
   * @param {Object} els - Elements to reset
   */

  Reveal.prototype.destroy = function(els) {
    $.waypoints("destroy");
    return $.each(els, (function(_this) {
      return function(el, obj) {
        var $el;
        $el = $(el);
        return _this.translate($el, ["0px", "0px", "0px"], 1);
      };
    })(this));
  };


  /*
   * Run on el
  #
   * @param {Object}  $el       - Element to apply reveal animation
   * @param {String}  direction - Direction of reveal animation
   * @param {Integer} offset    - Amount to offset position of el
   * @param {Integer} delay     - Amount of time to delay animation
  #
   * @return {Void}
   */

  Reveal.prototype.run = function($el, direction, offset, delay) {
    if (this.isActive($el)) {
      return this.reveal($el, direction, offset, delay);
    } else {
      return this.hide($el, direction, offset, delay);
    }
  };


  /*
   * Reveal animation on el
  #
   * @param {Object}  $el       - Element to apply reveal animation
   * @param {String}  direction - Direction of reveal animation
   * @param {Integer} offset    - Amount to offset position of el
   * @param {Integer} delay     - Amount of time to delay animation
  #
   * @return {Void}
   */

  Reveal.prototype.reveal = function($el, direction, offset, delay) {
    switch (direction) {
      case "top":
        this.translate($el, ["0px", "-" + offset + "px", "0px"], 0);
        break;
      case "right":
        this.translate($el, [offset + "px", "0px", "0px"], 0);
        break;
      case "bottom":
        this.translate($el, ["0px", offset + "px", "0px"], 0);
        break;
      case "left":
        this.translate($el, ["-" + offset + "px", "0px", "0px"], 0);
        break;
      default:
        this.translate($el, ["0px", "0px", "0px"], 0);
    }
    return setTimeout((function(_this) {
      return function() {
        return _this.translate($el, ["0px", "0px", "0px"], 1);
      };
    })(this), delay);
  };


  /*
   * Reset reveal animation to hide el
  #
   * @param {Object}  $el       - Element to apply reset
   * @param {String}  direction - Direction of reset animation
   * @param {Integer} offset    - Amount to offset position of el
   * @param {Integer} delay     - Amount of time to delay reset
  #
   * @return {Void}
   */

  Reveal.prototype.hide = function($el, direction, offset, delay) {
    return setTimeout((function(_this) {
      return function() {
        switch (direction) {
          case "top":
            return _this.translate($el, ["0px", "-" + offset + "px", "0px"], 0);
          case "right":
            return _this.translate($el, [offset + "px", "0px", "0px"], 0);
          case "bottom":
            return _this.translate($el, ["0px", offset + "px", "0px"], 0);
          case "left":
            return _this.translate($el, ["-" + offset + "px", "0px", "0px"], 0);
          default:
            return _this.translate($el, ["0px", "0px", "0px"], 0);
        }
      };
    })(this), delay);
  };

  return Reveal;

})();



},{}],5:[function(require,module,exports){

/*
 * Slider
#
 * @example
 *    ```haml
 *    .slider__wrapper
 *      .slider
 *        .slider__slide.slider__slide--active
 *          ...
 *        .slider__slide
 *          ...
 *        .slider__slide
 *          ...
 *        .slider__slide
 *          ...
 *    ```
#
 * @author Ezekiel Gabrielse, Produce Results
 * @link https://produceresults.com
 */
var Slider;

module.exports = Slider = (function() {

  /*
   * Constructor
  #
   * @param {Object} obj            - Object containing selectors and settings
  #
   * @prop {Integer} obj.interval   - Duration of each slide interval
   * @prop {Integer} obj.transition - Duration of transitional fade
   * @prop {Bool}    obj.adjust     - Automatically adjust parent height
  #
   * @return {Void}
   */
  function Slider(obj) {
    this.obj = obj;
    $.each(this.obj, (function(_this) {
      return function(el, settings) {
        settings.active = el.slice(1);
        _this.adjustParent($(el).first(), $(el).first().parent());
        return setInterval(function() {
          var $currentSlide, $nextSlide, $slideParent;
          $currentSlide = $(el).first();
          $nextSlide = $currentSlide.next();
          $slideParent = $currentSlide.parent();
          if (settings.adjust === true) {
            $slideParent.css({
              "-moz-transition": "500ms",
              "-o-transition": "500ms",
              "-webkit-transition": "500ms",
              "transition": "500ms"
            });
          }
          return _this.fadeToNextSlide($currentSlide, $nextSlide, $slideParent, settings);
        }, settings.interval);
      };
    })(this));
  }


  /*
   * Fade to next slide
  #
   * @param {Object} $currentSlide - jQuery object for current slide
   * @param {Object} $nextSlide    - jQuery object for next slide
   * @param {Object} $slideParent  - jQuery object for slide's parent
   * @param {Object} settings      - Object containing slider settings
  #
   * @return {Void}
   */

  Slider.prototype.fadeToNextSlide = function($currentSlide, $nextSlide, $slideParent, settings) {
    if (settings.adjust === true && $currentSlide.height() < $nextSlide.height()) {
      this.adjustParent($nextSlide, $slideParent);
    }
    return $nextSlide.addClass(settings.active).fadeIn(settings.transition, (function(_this) {
      return function() {
        $currentSlide.fadeOut(0).removeClass(settings.active).appendTo($slideParent);
        if (settings.adjust === true && $currentSlide.height() > $nextSlide.height()) {
          return _this.adjustParent($nextSlide, $slideParent);
        }
      };
    })(this));
  };


  /*
   * Adjust parent height to match child's height
  #
   * @param {Object} $el      - jQuery object of slider
   * @param {Object} $parent  - jQuery object of slider parent
  #
   * @return {Void}
   */

  Slider.prototype.adjustParent = function($el, $parent) {
    return $parent.css({
      "height": $el.css("height")
    });
  };

  return Slider;

})();



},{}]},{},[2,3,4,5]);
