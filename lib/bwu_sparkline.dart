library bwu_sparkline;

import 'dart:html' as dom;

import 'package:polymer/polymer.dart';
import 'src/utilities.dart';
import 'src/sp_format.dart';
import 'src/sp_tooltip.dart';

part 'src/options.dart';
part 'src/tooltip_options.dart';
part 'src/range_map.dart';
part 'src/mouse_handler.dart';

/**
*
* jquery.sparkline.js
*
* v2.1.2
* (c) Splunk, Inc
* Contact: Gareth Watts (gareth@splunk.com)
* http://omnipotent.net/jquery.sparkline/
*
* Generates inline sparkline charts from data supplied either to the method
* or inline in HTML
*
* Compatible with Internet Explorer 6.0+ and modern browsers equipped with the canvas tag
* (Firefox 2.0+, Safari, Opera, etc)
*
* License: New BSD License
*
* Copyright (c) 2012, Splunk Inc.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright notice,
*       this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright notice,
*       this list of conditions and the following disclaimer in the documentation
*       and/or other materials provided with the distribution.
*     * Neither the name of Splunk Inc nor the names of its contributors may
*       be used to endorse or promote products derived from this software without
*       specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
* SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
* OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
* Usage:
*  $(selector).sparkline(values, options)
*
* If values is undefined or set to 'html' then the data values are read from the specified tag:
*   <p>Sparkline: <span class="sparkline">1,4,6,6,8,5,3,5</span></p>
*   $('.sparkline').sparkline();
* There must be no spaces in the enclosed data set
*
* Otherwise values must be an array of numbers or null values
*    <p>Sparkline: <span id="sparkline1">This text replaced if the browser is compatible</span></p>
*    $('#sparkline1').sparkline([1,4,6,6,8,5,3,5])
*    $('#sparkline2').sparkline([1,4,6,null,null,5,3,5])
*
* Values can also be specified in an HTML comment, or as a values attribute:
*    <p>Sparkline: <span class="sparkline"><!--1,4,6,6,8,5,3,5 --></span></p>
*    <p>Sparkline: <span class="sparkline" values="1,4,6,6,8,5,3,5"></span></p>
*    $('.sparkline').sparkline();
*
* For line charts, x values can also be specified:
*   <p>Sparkline: <span class="sparkline">1:1,2.7:4,3.4:6,5:6,6:8,8.7:5,9:3,10:5</span></p>
*    $('#sparkline1').sparkline([ [1,1], [2.7,4], [3.4,6], [5,6], [6,8], [8.7,5], [9,3], [10,5] ])
*
* By default, options should be passed in as teh second argument to the sparkline function:
*   $('.sparkline').sparkline([1,2,3,4], {type: 'bar'})
*
* Options can also be set by passing them on the tag itself.  This feature is disabled by default though
* as there's a slight performance overhead:
*   $('.sparkline').sparkline([1,2,3,4], {enableTagOptions: true})
*   <p>Sparkline: <span class="sparkline" sparkType="bar" sparkBarColor="red">loading</span></p>
* Prefix all options supplied as tag attribute with "spark" (configurable by setting tagOptionPrefix)
*
* Supported options:
*   lineColor - Color of the line used for the chart
*   fillColor - Color used to fill in the chart - Set to '' or false for a transparent chart
*   width - Width of the chart - Defaults to 3 times the number of values in pixels
*   height - Height of the chart - Defaults to the height of the containing element
*   chartRangeMin - Specify the minimum value to use for the Y range of the chart - Defaults to the minimum value supplied
*   chartRangeMax - Specify the maximum value to use for the Y range of the chart - Defaults to the maximum value supplied
*   chartRangeClip - Clip out of range values to the max/min specified by chartRangeMin and chartRangeMax
*   chartRangeMinX - Specify the minimum value to use for the X range of the chart - Defaults to the minimum value supplied
*   chartRangeMaxX - Specify the maximum value to use for the X range of the chart - Defaults to the maximum value supplied
*   composite - If true then don't erase any existing chart attached to the tag, but draw
*           another chart over the top - Note that width and height are ignored if an
*           existing chart is detected.
*   tagValuesAttribute - Name of tag attribute to check for data values - Defaults to 'values'
*   enableTagOptions - Whether to check tags for sparkline options
*   tagOptionPrefix - Prefix used for options supplied as tag attributes - Defaults to 'spark'
*   disableHiddenCheck - If set to true, then the plugin will assume that charts will never be drawn into a
*           hidden dom element, avoding a browser reflow
*   disableInteraction - If set to true then all mouseover/click interaction behaviour will be disabled,
*       making the plugin perform much like it did in 1.x
*   disableTooltips - If set to true then tooltips will be disabled - Defaults to false (tooltips enabled)
*   disableHighlight - If set to true then highlighting of selected chart elements on mouseover will be disabled
*       defaults to false (highlights enabled)
*   highlightLighten - Factor to lighten/darken highlighted chart values by - Defaults to 1.4 for a 40% increase
*   tooltipContainer - Specify which DOM element the tooltip should be rendered into - defaults to document.body
*   tooltipClassname - Optional CSS classname to apply to tooltips - If not specified then a default style will be applied
*   tooltipOffsetX - How many pixels away from the mouse pointer to render the tooltip on the X axis
*   tooltipOffsetY - How many pixels away from the mouse pointer to render the tooltip on the r axis
*   tooltipFormatter  - Optional callback that allows you to override the HTML displayed in the tooltip
*       callback is given arguments of (sparkline, options, fields)
*   tooltipChartTitle - If specified then the tooltip uses the string specified by this setting as a title
*   tooltipFormat - A format string or SPFormat object  (or an array thereof for multiple entries)
*       to control the format of the tooltip
*   tooltipPrefix - A string to prepend to each field displayed in a tooltip
*   tooltipSuffix - A string to append to each field displayed in a tooltip
*   tooltipSkipNull - If true then null values will not have a tooltip displayed (defaults to true)
*   tooltipValueLookups - An object or range map to map field values to tooltip strings
*       (eg. to map -1 to "Lost", 0 to "Draw", and 1 to "Win")
*   numberFormatter - Optional callback for formatting numbers in tooltips
*   numberDigitGroupSep - Character to use for group separator in numbers "1,234" - Defaults to ","
*   numberDecimalMark - Character to use for the decimal point when formatting numbers - Defaults to "."
*   numberDigitGroupCount - Number of digits between group separator - Defaults to 3
*
* There are 7 types of sparkline, selected by supplying a "type" option of 'line' (default),
* 'bar', 'tristate', 'bullet', 'discrete', 'pie' or 'box'
*    line - Line chart.  Options:
*       spotColor - Set to '' to not end each line in a circular spot
*       minSpotColor - If set, color of spot at minimum value
*       maxSpotColor - If set, color of spot at maximum value
*       spotRadius - Radius in pixels
*       lineWidth - Width of line in pixels
*       normalRangeMin
*       normalRangeMax - If set draws a filled horizontal bar between these two values marking the "normal"
*                      or expected range of values
*       normalRangeColor - Color to use for the above bar
*       drawNormalOnTop - Draw the normal range above the chart fill color if true
*       defaultPixelsPerValue - Defaults to 3 pixels of width for each value in the chart
*       highlightSpotColor - The color to use for drawing a highlight spot on mouseover - Set to null to disable
*       highlightLineColor - The color to use for drawing a highlight line on mouseover - Set to null to disable
*       valueSpots - Specify which points to draw spots on, and in which color.  Accepts a range map
*
*   bar - Bar chart.  Options:
*       barColor - Color of bars for postive values
*       negBarColor - Color of bars for negative values
*       zeroColor - Color of bars with zero values
*       nullColor - Color of bars with null values - Defaults to omitting the bar entirely
*       barWidth - Width of bars in pixels
*       colorMap - Optional mappnig of values to colors to override the *BarColor values above
*                  can be an Array of values to control the color of individual bars or a range map
*                  to specify colors for individual ranges of values
*       barSpacing - Gap between bars in pixels
*       zeroAxis - Centers the y-axis around zero if true
*
*   tristate - Charts values of win (>0), lose (<0) or draw (=0)
*       posBarColor - Color of win values
*       negBarColor - Color of lose values
*       zeroBarColor - Color of draw values
*       barWidth - Width of bars in pixels
*       barSpacing - Gap between bars in pixels
*       colorMap - Optional mappnig of values to colors to override the *BarColor values above
*                  can be an Array of values to control the color of individual bars or a range map
*                  to specify colors for individual ranges of values
*
*   discrete - Options:
*       lineHeight - Height of each line in pixels - Defaults to 30% of the graph height
*       thesholdValue - Values less than this value will be drawn using thresholdColor instead of lineColor
*       thresholdColor
*
*   bullet - Values for bullet graphs msut be in the order: target, performance, range1, range2, range3, ...
*       options:
*       targetColor - The color of the vertical target marker
*       targetWidth - The width of the target marker in pixels
*       performanceColor - The color of the performance measure horizontal bar
*       rangeColors - Colors to use for each qualitative range background color
*
*   pie - Pie chart. Options:
*       sliceColors - An array of colors to use for pie slices
*       offset - Angle in degrees to offset the first slice - Try -90 or +90
*       borderWidth - Width of border to draw around the pie chart, in pixels - Defaults to 0 (no border)
*       borderColor - Color to use for the pie chart border - Defaults to #000
*
*   box - Box plot. Options:
*       raw - Set to true to supply pre-computed plot points as values
*             values should be: low_outlier, low_whisker, q1, median, q3, high_whisker, high_outlier
*             When set to false you can supply any number of values and the box plot will
*             be computed for you.  Default is false.
*       showOutliers - Set to true (default) to display outliers as circles
*       outlierIQR - Interquartile range used to determine outliers.  Default 1.5
*       boxLineColor - Outline color of the box
*       boxFillColor - Fill color for the box
*       whiskerColor - Line color used for whiskers
*       outlierLineColor - Outline color of outlier circles
*       outlierFillColor - Fill color of the outlier circles
*       spotRadius - Radius of outlier circles
*       medianColor - Line color of the median line
*       target - Draw a target cross hair at the supplied value (default undefined)
*
*
*
*   Examples:
*   $('#sparkline1').sparkline(myvalues, { lineColor: '#f00', fillColor: false });
*   $('.barsparks').sparkline('html', { type:'bar', height:'40px', barWidth:5 });
*   $('#tristate').sparkline([1,1,-1,1,0,0,-1], { type:'tristate' }):
*   $('#discrete').sparkline([1,3,4,5,5,3,4,5], { type:'discrete' });
*   $('#bullet').sparkline([10,12,12,9,7], { type:'bullet' });
*   $('#pie').sparkline([1,1,2], { type:'pie' });
*/

/*jslint regexp: true, browser: true, jquery: true, white: true, nomen: false, plusplus: false, maxerr: 500, indent: 4 */

//(function(document, Math, undefined) { // performance/minified-size optimization
//(function(factory) {
//    if(typeof define === 'function' && define.amd) {
//        define(['jquery'], factory);
//    } else if (jQuery && !jQuery.fn.sparkline) {
//        factory(jQuery);
//    }
//}

@CustomTag('bwu-sparkline')
class BwuSparkline extends PolymerElement {
  BwuSparkline.created() : super.created();
//  bool getDefaults;
//  String createClass;
//  int SPFormat;
//  int clipval;
//  int quartile;
//  int normalizeValue;
//  int normalizeValues;
//  int remove;
//  int isNumber;
//  int all;
//  int sum;
//  String addCSS;
//  int ensureArray;
//  int formatNumber;
//  int RangeMap;
//  int MouseHandler;
//  int Tooltip;
//  int barHighlightMixin;
//  int line;
//  int bar;
//  int tristate;
//  int discrete;
//  int bullet;
//  int pie;
//  int box;
//  int defaultStyles;
//  int initStyles;
//  int VShape;
//  int VCanvas_base;
//  int VCanvas_canvas;
//  int VCanvas_vml;
//  int pending;
//  int shapeCount = 0;
//  Map UNSET_OPTION = {};


///**
// * Utilities
// */
//
//createClass = function (/* [baseclass, [mixin, ...]], definition */) {
//    var Class, args;
//    Class = function () {
//        this.init.apply(this, arguments);
//    };
//    if (arguments.length > 1) {
//        if (arguments[0]) {
//            Class.prototype = $.extend(new arguments[0](), arguments[arguments.length - 1]);
//            Class._super = arguments[0].prototype;
//        } else {
//            Class.prototype = arguments[arguments.length - 1];
//        }
//        if (arguments.length > 2) {
//            args = Array.prototype.slice.call(arguments, 1, -1);
//            args.unshift(Class.prototype);
//            $.extend.apply($, args);
//        }
//    } else {
//        Class.prototype = arguments[0];
//    }
//    Class.prototype.cls = Class;
//    return Class;
//};



//// convience method to avoid needing the new operator
//$.spformat = function(format, fclass) {
//    return new SPFormat(format, fclass);
//};


//  // Provide a cross-browser interface to a few simple drawing primitives
//  dom.HtmlElement simpledraw(int width, int height, bool useExisting, bool interact) {
//    dom.HtmlElement target;
//    Function mhandler;
//    if (useExisting && (target = this.data('_jqs_vcanvas'))) {
//        return target;
//    }
//
//    if ($.fn.sparkline.canvas === false) {
//      // We've already determined that neither Canvas nor VML are available
//      return false;
//
//    } else if ($.fn.sparkline.canvas === undefined) {
//      // No function defined yet -- need to see if we support Canvas or VML
//      var el = document.createElement('canvas');
//      if (!!(el.getContext && el.getContext('2d'))) {
//        // Canvas is available
//        $.fn.sparkline.canvas = function(width, height, target, interact) {
//            return new VCanvas_canvas(width, height, target, interact);
//        };
//      } else if (document.namespaces && !document.namespaces.v) {
//        // VML is available
//        document.namespaces.add('v', 'urn:schemas-microsoft-com:vml', '#default#VML');
//        $.fn.sparkline.canvas = function(width, height, target, interact) {
//            return new VCanvas_vml(width, height, target);
//        };
//      } else {
//        // Neither Canvas nor VML are available
//        $.fn.sparkline.canvas = false;
//        return false;
//      }
//    }
//
//    if (width === undefined) {
//        width = $(this).innerWidth();
//    }
//    if (height === undefined) {
//        height = $(this).innerHeight();
//    }
//
//    target = $.fn.sparkline.canvas(width, height, this, interact);
//
//    mhandler = $(this).data('_jqs_mhandler');
//    if (mhandler) {
//        mhandler.registerCanvas(target);
//    }
//    return target;
//  };

  dom.CanvasRenderingContext2D canvas;

  void clearDraw() {
    canvas.setFillColorRgb(255,255,255);
    canvas.rect(0, 0, canvas.canvas.width, canvas.canvas.height);
  }

  List pending = [];
  List<int> _userValues;
  Options _options;

  void init(List<int> userValues, [Options userOptions]) {
    _userValues = userValues;
    _options = userOptions();
//    return this.each(() {
//        var options = new $.fn.sparkline.options(this, userOptions),
//             $this = $(this),
//             render, i;
    if (($(this).html() && !_options.disableHiddenCheck && $(this).is(':hidden')) || !$(this).parents('body').length) {
      if (!_options.composite && $.data(this, '_jqs_pending')) {
        // remove any existing references to the element
        for (int i = pending.length; i; i--) {
          if (pending[i - 1][0] == this) {
            pending.splice(i - 1, 1);
          }
        }
      }
      pending.add([this, render]);
      $.data(this, '_jqs_pending', true);
    } else {
      render.call(this);
    }
  }

  void render () {
    List<int> values;
    int width;
    int height;
    int tmp;
    Function mhandler;
    int sp,
    List<int> vals;

    if (userValues == 'html' || userValues == null) {
      vals = _options.tagValuesAttribute;
      if (vals == null) {
        vals = $this.html();
      }
      values = vals.replace(r'(^\s*<!--)|(-->\s*$)|\s+'/*/g*/, '').split(',');
    } else {
      values = userValues;
    }

    width = _options.width == 'auto' ? values.length * _options.defaultPixelsPerValue : _options.width;
    if (_options.height == 'auto') {
      if (!options.composite || !$.data(this, '_jqs_vcanvas')) {
        // must be a better way to get the line height
        tmp = document.createElement('span');
        tmp.innerHTML = 'a';
        $this.html(tmp);
        height = $(tmp).innerHeight() || $(tmp).height();
        $(tmp).remove();
        tmp = null;
      }
    } else {
      height = _options.height;
    }

    if (!options.disableInteraction) {
      mhandler = $.data(this, '_jqs_mhandler');
      if (!mhandler) {
        mhandler = new MouseHandler(this, options);
        $.data(this, '_jqs_mhandler', mhandler);
      } else if (!options.get('composite')) {
        mhandler.reset();
      }
    } else {
      mhandler = null;
    }

    if (_options.composite && !$.data(this, '_jqs_vcanvas')) {
      if (!$.data(this, '_jqs_errnotify')) {
        alert('Attempted to attach a composite sparkline to an element with no existing sparkline');
        $.data(this, '_jqs_errnotify', true);
      }
      return;
    }

    sp = new $.fn.sparkline[_options.type](this, values, _options, width, height);

    sp.render();

    if (mhandler) {
      mhandler.registerSparkline(sp);
    }
  }


//  $.fn.sparkline.defaults = getDefaults();


  void displayVisible() {
    dom.HtmlElement el;
    int i;
    int pl = pending.length;
    List<int> done = [];
    for (i = 0;  i < pl; i++) {
      el = pending[i][0];
      if ($(el).is(':visible') && !$(el).parents().is(':hidden')) {
        pending[i][1].call(el);
        $.data(pending[i][0], '_jqs_pending', false);
        done.push(i);
      } else if (!$(el).closest('html').length && !$.data(el, '_jqs_pending')) {
        // element has been inserted and removed from the DOM
        // If it was not yet inserted into the dom then the .data request
        // will return true.
        // removing from the dom causes the data to be removed.
        $.data(pending[i][0], '_jqs_pending', false);
        done.push(i);
      }
    }
    for (i = done.length; i; i--) {
      pending.splice(done[i - 1], 1);
    }
  }


  /**
   * User option handler
   */
  class UserOptions {
    UserOptions(String tag, userOptions) {
      var extendedOptions, defaults, base, tagOptionType;
      this.userOptions = userOptions = userOptions || {};
      this.tag = tag;
      this.tagValCache = {};
      defaults = $.fn.sparkline.defaults;
      base = defaults.common;
      this.tagOptionsPrefix = userOptions.enableTagOptions && (userOptions.tagOptionsPrefix || base.tagOptionsPrefix);

      tagOptionType = this.getTagSetting('type');
      if (tagOptionType == UNSET_OPTION) {
        extendedOptions = defaults[userOptions.type || base.type];
      } else {
        extendedOptions = defaults[tagOptionType];
      }
      this.mergedOptions = $.extend({}, base, extendedOptions, userOptions);
    }

    void getTagSetting(String key) {
      bool prefix = this.tagOptionsPrefix;
      int val;
      int i;
      int pairs;
      String keyval;

      if (prefix == null) {
        return UNSET_OPTION;
      }
      if (this.tagValCache.hasOwnProperty(key)) {
        val = this.tagValCache.key;
      } else {
        val = this.tag.getAttribute(prefix + key);
        if (val == null) {
            val = UNSET_OPTION;
        } else if (val.substr(0, 1) == '[') {
          val = val.substr(1, val.length - 2).split(',');
          for (i = val.length; i--;) {
              val[i] = normalizeValue(val[i].replace(r'(^\s*)|(\s*$)' /*/g*/, ''));
          }
        } else if (val.substr(0, 1) == '{') {
          pairs = val.substr(1, val.length - 2).split(',');
          val = {};
          for (i = pairs.length; i--;) {
            keyval = pairs[i].split(':', 2);
            val[keyval[0].replace(r'(^\s*)|(\s*$)'/*/g*/, '')] = normalizeValue(keyval[1].replace(r'(^\s*)|(\s*$)'/*/g*/''));
          }
        } else {
          val = normalizeValue(val);
        }
        this.tagValCache.key = val;
      }
      return val;
    }

    void get(String key, int defaultval) {
      var tagOption = this.getTagSetting(key),
          result;
      if (tagOption !== UNSET_OPTION) {
          return tagOption;
      }
      return (result = this.mergedOptions[key]) == undefined ? defaultval : result;
    }
  }


  class _Base{
    bool disabled = false;

    _Base(dom.HtmlElement el, List<int> values, Options options, int width, int height) {
      this.el = el;
      this.$el = $(el);
      this.values = values;
      this.options = options;
      this.width = width;
      this.height = height;
      this.currentRegion = undefined;
    }

    /**
     * Setup the canvas
     */
    void initTarget() {
      var interactive = !this.options.disableInteraction;
      if (!(this.target = this.$el.simpledraw(this.width, this.height, this.options.get('composite'), interactive))) {
        this.disabled = true;
      } else {
        this.canvasWidth = this.target.pixelWidth;
        this.canvasHeight = this.target.pixelHeight;
      }
    }

    /**
     * Actually render the chart to the canvas
     */
    void render() {
      if (this.disabled) {
        this.el.innerHTML = '';
        return false;
      }
      return true;
    }

    /**
     * Return a region id for a given x/y co-ordinate
     */
    void getRegion(int x, int y) {
    }

    /**
     * Highlight an item based on the moused-over x,y co-ordinate
     */
    bool setRegionHighlight(dom.HtmlElement el, int x, int y) {
      var currentRegion = this.currentRegion,
        highlightEnabled = !this.options.get('disableHighlight'),
        newRegion;
      if (x > this.canvasWidth || y > this.canvasHeight || x < 0 || y < 0) {
        return null;
      }
      newRegion = this.getRegion(el, x, y);
      if (currentRegion != newRegion) {
        if (currentRegion != null && highlightEnabled) {
          this.removeHighlight();
        }
        this.currentRegion = newRegion;
        if (newRegion != null && highlightEnabled) {
          this.renderHighlight();
        }
        return true;
      }
      return false;
    }

    /**
     * Reset any currently highlighted item
     */
    void clearRegionHighlight() {
      if (this.currentRegion != null) {
        this.removeHighlight();
        this.currentRegion = undefined;
        return true;
      }
      return false;
    }

    void renderHighlight() {
        this.changeHighlight(true);
    }

    void removeHighlight() {
      this.changeHighlight(false);
    }

    void changeHighlight(bool highlight) {}

    /**
     * Fetch the HTML to display as a tooltip
     */
    String getCurrentRegionTooltip() {
      var options = this.options;
      String header = '';
      List<int> entries = [];
      List<int> fields;
      List<String> formats;
      int formatlen;
      int fclass;
      String text;
      int i;
      bool showFields;
      bool showFieldsKey;
      List<int> newFields;
      int fv;
      int formatter;
      String format;
      int fieldlen;
      int j;
      if (this.currentRegion == null) {
        return '';
      }
      fields = this.getCurrentRegionFields();
      formatter = options.tooltipFormatter;
      if (formatter != null) {
        return formatter(this, options, fields);
      }
      if (options.tooltipChartTitle) {
        header += '<div class="jqs jqstitle">' + options.get('tooltipChartTitle') + '</div>\n';
      }
      formats = this.options.tooltipFormat;
      if (!formats) {
        return '';
      }
      if (!$.isArray(formats)) {
        formats = [formats];
      }
      if (!$.isArray(fields)) {
        fields = [fields];
      }
      showFields = this.options.get('tooltipFormatFieldlist');
      showFieldsKey = this.options.get('tooltipFormatFieldlistKey');
      if (showFields && showFieldsKey) {
        // user-selected ordering of fields
        newFields = [];
        for (i = fields.length; i--;) {
          fv = fields[i][showFieldsKey];
          if ((j = $.inArray(fv, showFields)) != -1) {
            newFields[j] = fields[i];
          }
        }
        fields = newFields;
      }
      formatlen = formats.length;
      fieldlen = fields.length;
      for (i = 0; i < formatlen; i++) {
        format = formats[i];
        if (format is String) {
          format = new SPFormat(format);
        }
        fclass = format.fclass || 'jqsfield';
        for (j = 0; j < fieldlen; j++) {
          if (!fields[j].isNull || !options.get('tooltipSkipNull')) {
            $.extend(fields[j], {
              prefix: options.get('tooltipPrefix'),
              suffix: options.get('tooltipSuffix')
            });
            text = format.render(fields[j], options.get('tooltipValueLookups'), options);
            entries.push('<div class="' + fclass + '">' + text + '</div>');
          }
        }
      }
      if (entries.length > 0) {
        return header + entries.join('\n');
      }
      return '';
    }

    void getCurrentRegionFields() {}

    void calcHighlightColor(String color, Options options) {
      String highlightColor = options.highlightColor;
      bool lighten = options.highlightLighten;
      bool parse;
      bool mult;
      String rgbnew;
      int i;
      if (highlightColor != null) {
        return highlightColor;
      }
      if (lighten) {
        // extract RGB values
        parse = r'^#([0-9a-f])([0-9a-f])([0-9a-f])$'/*/i*/.exec(color) || r'^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$'/*/i*/.exec(color);
        if (parse) {
          rgbnew = [];
          mult = color.length == 4 ? 16 : 1;
          for (i = 0; i < 3; i++) {
            rgbnew[i] = clipval(Math.round(parseInt(parse[i + 1], 16) * mult * lighten), 0, 255);
          }
          return 'rgb(' + rgbnew.join(',') + ')';
        }
      }
      return color;
    }
  }

  class BarHighlightMixin  {
    void changeHighlight(bool highlight) {
      int currentRegion = this.currentRegion;
      int target = this.target;
      int shapeids = this.regionShapes[currentRegion];
      List<int> newShapes;
      // will be null if the region value was null
      if (shapeids != null) {
        newShapes = this.renderRegion(currentRegion, highlight);
        if ($.isArray(newShapes) || $.isArray(shapeids)) {
          target.replaceWithShapes(shapeids, newShapes);
          this.regionShapes[currentRegion] = $.map(newShapes, function (newShape) {
            return newShape.id;
          });
        } else {
          target.replaceWithShape(shapeids, newShapes);
          this.regionShapes[currentRegion] = newShapes.id;
       }
      }
    }

    void render() {
      List<int> values = this.values;
      int target = this.target;
      List<int> regionShapes = this.regionShapes;
      List<int> shapes;
      List<int> ids;
      int i;
      int j;

      if (!super.render()) {
        return;
      }
      for (i = values.length; i--; i > 0) {
        shapes = this.renderRegion(i);
        if (shapes != null) {
          if (shapes is List) {
            ids = [];
            for (j = shapes.length; j--; j > 0) {
              shapes[j].append();
              ids.add(shapes[j].id);
            }
            regionShapes[i] = ids;
          } else {
            shapes.append();
            regionShapes[i] = shapes.id; // store just the shapeid
          }
        } else {
          // null value
          regionShapes[i] = null;
        }
      }
      target.render();
    }
  }

  /**
   * Line charts
   */
  class Line {
    Line (dom.HtmlElement el, List<int> values, Options options, int width, int height) : super(el, values, options, width, height) {
      List<int> vertices = [];
      List<int> regionMap = [];
      List<int> xvalues = [];
      List<int> yvalues = [];
      List<int> yminmax = [];
      int hightlightSpotId = null;
      int lastShapeId = null;
      initTarget();
    }

    void getRegion(dom.HtmlElement el, int x, int y) {
      int i,
      Map regionMap = this.regionMap; // maps regions to value positions
      for (i = regionMap.length; i--; i > 0) {
        if (regionMap[i] != null && x >= regionMap[i][0] && x <= regionMap[i][1]) {
          return regionMap[i][2];
        }
      }
      return undefined;
    }

    void getCurrentRegionFields() {
      var currentRegion = this.currentRegion;
      return {
        'isNull': this.yvalues[currentRegion] == null,
        'x': this.xvalues[currentRegion],
        'y': this.yvalues[currentRegion],
        'color': this.options.lineColor,
        'fillColor': this.options.fillColor,
        'offset': currentRegion
      };
    }

    void renderHighlight() {
      int currentRegion = this.currentRegion;
      int target = this.target;
      int vertex = this.vertices[currentRegion];
      Options options = this.options;
      int spotRadius = options.spotRadius;
      String highlightSpotColor = options.highlightSpotColor;
      String highlightLineColor = options.highlightLineColor;
      bool highlightSpot = false;
      bool highlightLine = false;

      if (vertex == null) {
        return;
      }
      if (spotRadius && highlightSpotColor != null) {
        highlightSpot = target.drawCircle(vertex[0], vertex[1],
            spotRadius, undefined, highlightSpotColor);
        this.highlightSpotId = highlightSpot.id;
        target.insertAfterShape(this.lastShapeId, highlightSpot);
      }
      if (highlightLineColor != null) {
          highlightLine = target.drawLine(vertex[0], this.canvasTop, vertex[0],
              this.canvasTop + this.canvasHeight, highlightLineColor);
          this.highlightLineId = highlightLine.id;
          target.insertAfterShape(this.lastShapeId, highlightLine);
      }
    }

    void removeHighlight() {
      int target = this.target;
      if (this.highlightSpotId != null) {
        target.removeShapeId(this.highlightSpotId);
        this.highlightSpotId = null;
      }
      if (this.highlightLineId != null) {
          target.removeShapeId(this.highlightLineId);
          this.highlightLineId = null;
      }
    }

    void scanValues() {
      List<int> values = this.values;
      int valcount = values.length;
      List<int>xvalues = this.xvalues;
      List<int> yvalues = this.yvalues;
      int yminmax = this.yminmax;
      int i;
      int val;
      bool isStr;
      bool isArray;
      int sp;
      for (i = 0; i < valcount; i++) {
        val = values[i];
        isStr = values[i] == is String;
        isArray = values[i]) is List;
        sp = isStr && values[i].split(':');
        if (isStr && sp.length == 2) { // x:y
          xvalues.add(Number(sp[0]));
          yvalues.add(Number(sp[1]));
          yminmax.add(Number(sp[1]));
        } else if (isArray) {
          xvalues.add(val[0]);
          yvalues.add(val[1]);
          yminmax.add(val[1]);
        } else {
          xvalues.add(i);
          if (values[i] == null || values[i] == 'null') {
            yvalues.push(null);
          } else {
            yvalues.push(Number(val));
            yminmax.push(Number(val));
          }
        }
      }
      if (this.options.xvalues != null) {
        xvalues = this.options.xvalues;
      }

      this.maxy = this.maxyorg = math.max(Math, yminmax);
      this.miny = this.minyorg = math.min(Math, yminmax);

      this.maxx = math.max(Math, xvalues);
      this.minx = math.min(Math, xvalues);

      this.xvalues = xvalues;
      this.yvalues = yvalues;
      this.yminmax = yminmax;
    }

    void processRangeOptions() {
      Options options = this.options;
      int normalRangeMin = options.normalRangeMin;
      int normalRangeMax = options.normalRangeMax;

      if (normalRangeMin != null) {
        if (normalRangeMin < this.miny) {
          this.miny = normalRangeMin;
        }
        if (normalRangeMax > this.maxy) {
          this.maxy = normalRangeMax;
        }
      }
      if (options.chartRangeMin != null && (options.chartRangeClip || options.chartRangeMin < this.miny)) {
        this.miny = options.chartRangeMin;
      }
      if (options.chartRangeMax != null && (options.chartRangeClip || options.chartRangeMax > this.maxy)) {
        this.maxy = options.chartRangeMax;
      }
      if (options.chartRangeMinX != null && (options.chartRangeClipX || options.chartRangeMinX < this.minx)) {
        this.minx = options.chartRangeMinX;
      }
      if (options.chartRangeMaxX != null && (options.chartRangeClipX || options.chartRangeMaxX > this.maxx)) {
        this.maxx = options.chartRangeMaxX;
      }
    }

    void drawNormalRange(int canvasLeft, int canvasTop, int canvasHeight, int canvasWidth, int rangey) {
      int normalRangeMin = this.options.normalRangeMin;
      int normalRangeMax = this.options.normalRangeMax;
      int ytop = canvasTop + (canvasHeight - (canvasHeight * ((normalRangeMax - this.miny) / rangey))).round();
      int height = ((canvasHeight * (normalRangeMax - normalRangeMin)) / rangey).round();
      this.target.drawRect(canvasLeft, ytop, canvasWidth, height, undefined, this.options.normalRangeColor).append();
    }

    void render() {
      Options options = this.options;
      int target = this.target;
      int canvasWidth = this.canvasWidth;
      int canvasHeight = this.canvasHeight;
      List<int>vertices = this.vertices;
      int spotRadius = options.spotRadius;
      Map regionMap = this.regionMap;
      int rangex;
      int rangey;
      int yvallast;
      int canvasTop;
      int canvasLeft;
      int vertex;
      int path;
      List<int> paths;
      int x;
      int y;
      int xnext;
      int xpos;
      int xposnext;
      int last;
      int next;
      int yvalcount;
      List<int> lineShapes;
      List<int>fillShapes;
      int plen;
      int valueSpots;
      bool hlSpotsEnabled;
      String color;
      List<int> xvalues;
      List<int> yvalues;
      int i;

      if (!super.render()) {
        return;
      }

      this.scanValues();
      this.processRangeOptions();

      xvalues = this.xvalues;
      yvalues = this.yvalues;

      if (!this.yminmax.length || this.yvalues.length < 2) {
        // empty or all null valuess
        return;
      }

      canvasTop = canvasLeft = 0;

      rangex = this.maxx - this.minx == 0 ? 1 : this.maxx - this.minx;
      rangey = this.maxy - this.miny == 0 ? 1 : this.maxy - this.miny;
      yvallast = this.yvalues.length - 1;

      if (spotRadius && (canvasWidth < (spotRadius * 4) || canvasHeight < (spotRadius * 4))) {
        spotRadius = 0;
      }
      if (spotRadius) {
        // adjust the canvas size as required so that spots will fit
        hlSpotsEnabled = options.highlightSpotColor &&  !options.disableInteraction;
        if (hlSpotsEnabled || options.minSpotColor || (options.spotColor && yvalues[yvallast] == this.miny)) {
          canvasHeight -= spotRadius.ceil();
        }
        if (hlSpotsEnabled || options.maxSpotColor || (options.spotColor && yvalues[yvallast] == this.maxy)) {
            canvasHeight -= spotRadius.ceil();
            canvasTop += spotRadius.ceil();
        }
        if (hlSpotsEnabled ||
             ((options.minSpotColor || options.maxSpotColor) && (yvalues[0] == this.miny || yvalues[0] == this.maxy))) {
            canvasLeft += spotRadius.ceil();
            canvasWidth -= spotRadius.ceil();
        }
        if (hlSpotsEnabled || options.spotColor ||
          (options.minSpotColor || options.maxSpotColor &&
            (yvalues[yvallast] == this.miny || yvalues[yvallast] == this.maxy))) {
          canvasWidth -= Math.ceil(spotRadius);
        }
      }


      canvasHeight--;

      if (options.normalRangeMin != null && !options.drawNormalOnTop) {
        this.drawNormalRange(canvasLeft, canvasTop, canvasHeight, canvasWidth, rangey);
      }

      path = [];
      paths = [path];
      last = next = null;
      yvalcount = yvalues.length;
      for (i = 0; i < yvalcount; i++) {
        x = xvalues[i];
        xnext = xvalues[i + 1];
        y = yvalues[i];
        xpos = canvasLeft + ((x - this.minx) * (canvasWidth / rangex)).round();
        xposnext = i < yvalcount - 1 ? canvasLeft + ((xnext - this.minx) * (canvasWidth / rangex)).round() : canvasWidth;
        next = xpos + ((xposnext - xpos) / 2);
        regionMap[i] = [last || 0, next, i];
        last = next;
        if (y == null) {
          if (i != 0) {
            if (yvalues[i - 1] != null) {
              path = [];
              paths.add(path);
            }
            vertices.add(null);
          }
        } else {
          if (y < this.miny) {
            y = this.miny;
          }
          if (y > this.maxy) {
            y = this.maxy;
          }
          if (!path.length) {
            // previous value was null
            path.add([xpos, canvasTop + canvasHeight]);
          }
          vertex = [xpos, canvasTop + Math.round(canvasHeight - (canvasHeight * ((y - this.miny) / rangey)))];
          path.add(vertex);
          vertices.add(vertex);
        }
      }

      lineShapes = [];
      fillShapes = [];
      plen = paths.length;
      for (i = 0; i < plen; i++) {
        path = paths[i];
        if (path.length > 0) {
          if (options.fillColor) {
            path.add([path[path.length - 1][0], (canvasTop + canvasHeight)]);
            fillShapes.add(path.slice(0));
            path.pop();
          }
          // if there's only a single point in this path, then we want to display it
          // as a vertical line which means we keep path[0]  as is
          if (path.length > 2) {
            // else we want the first value
            path[0] = [path[0][0], path[1][1]];
          }
          lineShapes.add(path);
        }
      }

      // draw the fill first, then optionally the normal range, then the line on top of that
      plen = fillShapes.length;
      for (i = 0; i < plen; i++) {
        target.drawShape(fillShapes[i],
            options.fillColor, options.fillColor).append();
      }

      if (options.normalRangeMin != null && options.drawNormalOnTop) {
        this.drawNormalRange(canvasLeft, canvasTop, canvasHeight, canvasWidth, rangey);
      }

      plen = lineShapes.length;
      for (i = 0; i < plen; i++) {
        target.drawShape(lineShapes[i], options.lineColor, null,
            options.lineWidth).append();
      }

      if (spotRadius && options.valueSpots) {
        valueSpots = options.valueSpots;
        if (valueSpots.get == null) {
          valueSpots = new RangeMap(valueSpots);
        }
        for (i = 0; i < yvalcount; i++) {
          color = valueSpots.get(yvalues[i]);
          if (color) {
              target.drawCircle(canvasLeft + Math.round((xvalues[i] - this.minx) * (canvasWidth / rangex)),
                  canvasTop + Math.round(canvasHeight - (canvasHeight * ((yvalues[i] - this.miny) / rangey))),
                  spotRadius, undefined,
                  color).append();
          }
        }
      }
      if (spotRadius && options.spotColor && yvalues[yvallast] != null) {
        target.drawCircle(canvasLeft + ((xvalues[xvalues.length - 1] - this.minx) * (canvasWidth / rangex)).round(),
            canvasTop + Math.round(canvasHeight - (canvasHeight * ((yvalues[yvallast] - this.miny) / rangey))),
            spotRadius, undefined,
            options.spotColor).append();
      }
      if (this.maxy != this.minyorg) {
        if (spotRadius && options.minSpotColor != null) {
          x = xvalues[$.inArray(this.minyorg, yvalues)];
          target.drawCircle(canvasLeft + Math.round((x - this.minx) * (canvasWidth / rangex)),
              canvasTop + (canvasHeight - (canvasHeight * ((this.minyorg - this.miny) / rangey))).round(),
              spotRadius, undefined,
              options.minSpotColor).append();
        }
        if (spotRadius && options.maxSpotColor != null) {
            x = xvalues[$.inArray(this.maxyorg, yvalues)];
            target.drawCircle(canvasLeft + ((x - this.minx) * (canvasWidth / rangex)).round(),
                canvasTop + (canvasHeight - (canvasHeight * ((this.maxyorg - this.miny) / rangey))).round(),
                spotRadius, undefined,
                options.maxSpotColor).append();
        }
      }

      this.lastShapeId = target.getLastShapeId();
      this.canvasTop = canvasTop;
      target.render();
    }
  }

  /**
   * Bar charts
   */
  class Bar extends _Base with BarHighlightMixin {
    Bar(dom.HemlElement el, List<int> values, Options options, int width, int height) : super(el, values, options, width, height) {
      int barWidth = parseInt(options.get('barWidth'), 10);
      int barSpacing = parseInt(options.get('barSpacing'), 10);
      int chartRangeMin = options.chartRangeMin;
      int chartRangeMax = options.chartRangeMax;
      int chartRangeClip = options.chartRangeClip;
      int stackMin = double.INFINITY;
      int stackMax = double.NEGATIVE_INFINITY;
      bool isStackString;
      int groupMin;
      int groupMax;
      int stackRanges;
      List<int> numValues;
      int i;
      int vlen;
      int range;
      int zeroAxis;
      int xaxisOffset;
      int min;
      int max;
      int clipMin;
      int clipMax;
      bool stacked;
      int vlist;
      int j;
      int slen;
      int svals;
      int val;
      int yoffset;
      int yMaxCalc;
      int canvasHeightEf;

      // scan values to determine whether to stack bars
      vlen = values.length;
      for (i = 0; i < vlen; i++) {
        val = values[i];
        isStackString = val is String && val.indexOf(':') > -1;
        if (isStackString || val is List) {
          stacked = true;
          if (isStackString) {
            val = values[i] = normalizeValues(val.split(':'));
          }
          val = remove(val, null); // min/max will treat null as zero
          groupMin = Math.min.apply(Math, val);
          groupMax = Math.max.apply(Math, val);
          if (groupMin < stackMin) {
            stackMin = groupMin;
          }
          if (groupMax > stackMax) {
            stackMax = groupMax;
          }
        }
      }

      this.stacked = stacked;
      this.regionShapes = {};
      this.barWidth = barWidth;
      this.barSpacing = barSpacing;
      this.totalBarWidth = barWidth + barSpacing;
      this.width = width = (values.length * barWidth) + ((values.length - 1) * barSpacing);

      this.initTarget();

      if (chartRangeClip != null) {
        clipMin = chartRangeMin == null ? double.NEGATIVE_INFINITY : chartRangeMin;
        clipMax = chartRangeMax == null ? double.INFINITY: chartRangeMax;
      }

      numValues = [];
      stackRanges = stacked ? [] : numValues;
      var stackTotals = [];
      var stackRangesNeg = [];
      vlen = values.length;
      for (i = 0; i < vlen; i++) {
        if (stacked) {
          vlist = values[i];
          values[i] = svals = [];
          stackTotals[i] = 0;
          stackRanges[i] = stackRangesNeg[i] = 0;
          for (j = 0, slen = vlist.length; j < slen; j++) {
            val = svals[j] = chartRangeClip ? clipval(vlist[j], clipMin, clipMax) : vlist[j];
            if (val != null) {
              if (val > 0) {
                stackTotals[i] += val;
              }
              if (stackMin < 0 && stackMax > 0) {
                if (val < 0) {
                  stackRangesNeg[i] += val.abs();
                } else {
                  stackRanges[i] += val;
                }
              } else {
                stackRanges[i] += (val - (val < 0 ? stackMax : stackMin)).abs();
              }
              numValues.add(val);
            }
          }
        } else {
            val = chartRangeClip ? clipval(values[i], clipMin, clipMax) : values[i];
            val = values[i] = normalizeValue(val);
            if (val != null) {
              numValues.add(val);
            }
        }
      }
      this.max = max = math.max(Math, numValues);
      this.min = min = math.min(Math, numValues);
      this.stackMax = stackMax = stacked ? math.max(Math, stackTotals) : max;
      this.stackMin = stackMin = stacked ? math.min(Math, numValues) : min;

      if (options.chartRangeMin != null && (options.chartRangeClip || options.chartRangeMin < min)) {
        min = options.chartRangeMin;
      }
      if (options.chartRangeMax != null && (options.chartRangeClip || options.chartRangeMax > max)) {
        max = options.chartRangeMax;
      }

      this.zeroAxis = zeroAxis = options.get('zeroAxis', true);
      if (min <= 0 && max >= 0 && zeroAxis) {
        xaxisOffset = 0;
      } else if (zeroAxis == false) {
        xaxisOffset = min;
      } else if (min > 0) {
        xaxisOffset = min;
      } else {
        xaxisOffset = max;
      }
      this.xaxisOffset = xaxisOffset;

      range = stacked ? (math.max(Math, stackRanges) + math.max(Math, stackRangesNeg)) : max - min;

      // as we plot zero/min values a single pixel line, we add a pixel to all other
      // values - Reduce the effective canvas size to suit
      this.canvasHeightEf = (zeroAxis && min < 0) ? this.canvasHeight - 2 : this.canvasHeight - 1;

      if (min < xaxisOffset) {
        yMaxCalc = (stacked && max >= 0) ? stackMax : max;
        yoffset = (yMaxCalc - xaxisOffset) / range * this.canvasHeight;
        if (yoffset != yoffset.ceil()) {
          this.canvasHeightEf -= 2;
          yoffset = Math.ceil(yoffset);
        }
      } else {
        yoffset = this.canvasHeight;
      }
      this.yoffset = yoffset;

      if (options.colorMap is List) {
        this.colorMapByIndex = options.colorMap;
        this.colorMapByValue = null;
      } else {
        this.colorMapByIndex = null;
        this.colorMapByValue = options.colorMap;
        if (this.colorMapByValue && this.colorMapByValue.get == null) {
          this.colorMapByValue = new RangeMap(this.colorMapByValue);
        }
      }

      this.range = range;
    }

    void getRegion(dom.HtmlElement el, int x, int y) {
      var result = (x / this.totalBarWidth).floor();
      return (result < 0 || result >= this.values.length) ? undefined : result;
    }

    Map getCurrentRegionFields() {
      var currentRegion = this.currentRegion;
      List<int> values = ensureArray(this.values[currentRegion]);
      List<int> result = [];
      int value;
      int i;
      for (i = values.length; i--; i > 0) {
        value = values[i];
        result.add({
          'isNull': value == null,
          'value': value,
          'color': this.calcColor(i, value, currentRegion),
          'offset': currentRegion
        });
      }
      return result;
    }

    void calcColor(int stacknum, int value, int valuenum) {
      var colorMapByIndex = this.colorMapByIndex;
      int colorMapByValue = this.colorMapByValue;
      Options options = this.options;
      String color;
      String newColor;
      if (this.stacked) {
        color = options.stackedBarColor;
      } else {
        color = (value < 0) ? options.negBarColor : options.barColor;
      }
      if (value == 0 && options.zeroColor != null) {
        color = options.zeroColor;
      }
      if (colorMapByValue != null && (newColor = colorMapByValue.get(value))) {
        color = newColor;
      } else if (colorMapByIndex && colorMapByIndex.length > valuenum) {
        color = colorMapByIndex[valuenum];
      }
      return color is List ? color[stacknum % color.length] : color;
    }

    /**
     * Render bar(s) for a region
     */
    void renderRegion(int valuenum, bool highlight) {
      var vals = this.values[valuenum];
      Options options = this.options;
      int xaxisOffset = this.xaxisOffset;
      List<int> result = [];
      int range = this.range;
      bool stacked = this.stacked;
      int target = this.target;
      int x = valuenum * this.totalBarWidth;
      int canvasHeightEf = this.canvasHeightEf;
      int yoffset = this.yoffset;
      int y;
      int height;
      String color;
      bool isNull;
      int yoffsetNeg;
      int i;
      int valcount;
      int val;
      bool minPlotted;
      bool allMin;

      vals = vals is List ? vals : [vals];
      valcount = vals.length;
      val = vals[0];
      isNull = all(null, vals);
      allMin = all(xaxisOffset, vals, true);

      if (isNull) {
        if (options.nullColor) {
          color = highlight ? options.nullColor : this.calcHighlightColor(options.nullColor, options);
          y = (yoffset > 0) ? yoffset - 1 : yoffset;
          return target.drawRect(x, y, this.barWidth - 1, 0, color, color);
        } else {
          return undefined;
        }
      }
      yoffsetNeg = yoffset;
      for (i = 0; i < valcount; i++) {
        val = vals[i];

        if (stacked && val == xaxisOffset) {
          if (!allMin || minPlotted) {
            continue;
          }
          minPlotted = true;
        }

        if (range > 0) {
          height = (canvasHeightEf * ((Math.abs(val - xaxisOffset) / range))).floor() + 1;
        } else {
          height = 1;
        }
        if (val < xaxisOffset || (val == xaxisOffset && yoffset == 0)) {
          y = yoffsetNeg;
          yoffsetNeg += height;
        } else {
          y = yoffset - height;
          yoffset -= height;
        }
        color = this.calcColor(i, val, valuenum);
        if (highlight) {
          color = this.calcHighlightColor(color, options);
        }
        result.add(target.drawRect(x, y, this.barWidth - 1, height - 1, color, color));
      }
      if (result.length == 1) {
        return result[0];
      }
      return result;
    }
  }

  /**
   * Tristate charts
   */
  class Tristate extends _Base with BarHighlightMixin {
    Tristate(dom.HtmlElement el, List<int> values, Options options, int width, int height)
        : super(el, values, options, width, height){
      int barWidth = parseInt(options.barWidth, 10);
      int barSpacing = parseInt(options.barSpacing, 10);

      this.regionShapes = {};
      this.barWidth = barWidth;
      this.barSpacing = barSpacing;
      this.totalBarWidth = barWidth + barSpacing;
      this.values = $.map(values, Number);
      this.width = width = (values.length * barWidth) + ((values.length - 1) * barSpacing);

      if ($.isArray(options.colorMap)) {
        this.colorMapByIndex = options.colorMap;
        this.colorMapByValue = null;
      } else {
        this.colorMapByIndex = null;
        this.colorMapByValue = options.colorMap;
        if (this.colorMapByValue && this.colorMapByValue.get == null) {
            this.colorMapByValue = new RangeMap(this.colorMapByValue);
        }
      }
      this.initTarget();
    }

    void getRegion(dom.HtmlElement el, int x, int y) {
      return (x / this.totalBarWidth).floor();
    }

    Map getCurrentRegionFields() {
      var currentRegion = this.currentRegion;
      return {
        'isNull': this.values[currentRegion] == null,
        'value': this.values[currentRegion],
        'color': this.calcColor(this.values[currentRegion], currentRegion),
        'offset': currentRegion
      };
    }

    String calcColor(int value, int valuenum) {
      var values = this.values;
      Options options = this.options;
      int colorMapByIndex = this.colorMapByIndex;
      int colorMapByValue = this.colorMapByValue;
      String color;
      String newColor;

      if (colorMapByValue && (newColor = colorMapByValue.get(value))) {
        color = newColor;
      } else if (colorMapByIndex && colorMapByIndex.length > valuenum) {
        color = colorMapByIndex[valuenum];
      } else if (values[valuenum] < 0) {
        color = options.negBarColor;
      } else if (values[valuenum] > 0) {
        color = options.posBarColor;
      } else {
        color = options.zeroBarColor;
      }
      return color;
    }

    void renderRegion(int valuenum, int highlight) {
      List<int> values = this.values;
      Options options = this.options;
      int target = this.target;
      int canvasHeight;
      int height;
      int halfHeight;
      int x;
      int y;
      String color;

      canvasHeight = target.pixelHeight;
      halfHeight = (canvasHeight / 2).round();

      x = valuenum * this.totalBarWidth;
      if (values[valuenum] < 0) {
        y = halfHeight;
        height = halfHeight - 1;
      } else if (values[valuenum] > 0) {
        y = 0;
        height = halfHeight - 1;
      } else {
        y = halfHeight - 1;
        height = 2;
      }
      color = this.calcColor(values[valuenum], valuenum);
      if (color == null) {
          return;
      }
      if (highlight) {
        color = this.calcHighlightColor(color, options);
      }
      return target.drawRect(x, y, this.barWidth - 1, height - 1, color, color);
    }
  }

  /**
   * Discrete charts
   */
  class Discrete extends _Base with BarHighlightMixin {
    Discrete (dom.HtmlElement el, List<int> values, Options options, int width, int height)
        : super(this, el, values, options, width, height){
      this.regionShapes = {};
      this.values = values = $.map(values, Number);
      this.min = Math.min.apply(Math, values);
      this.max = Math.max.apply(Math, values);
      this.range = this.max - this.min;
      this.width = width = options.width == 'auto' ? values.length * 2 : this.width;
      this.interval = (width / values.length).floor();
      this.itemWidth = width / values.length;
      if (options.chartRangeMin != null && (options.chartRangeClip || options.chartRangeMin < this.min)) {
          this.min = options.chartRangeMin;
      }
      if (options.chartRangeMax != null && (options.chartRangeClip || options.chartRangeMax > this.max)) {
        this.max = options.chartRangeMax;
      }
      this.initTarget();
      if (this.target) {
        this.lineHeight = options.lineHeight == 'auto' ? (this.canvasHeight * 0.3).round() : options.lineHeight;
      }
    }

    int getRegion(dom.HtmlElement el, int x, int y) {
        return (x / this.itemWidth).floor();
    }

    Map getCurrentRegionFields() {
      var currentRegion = this.currentRegion;
      return {
          'isNull': this.values[currentRegion] == null,
          'value': this.values[currentRegion],
          'offset': currentRegion
      };
    }

    void renderRegion(int valuenum, bool highlight) {
      var values = this.values;
      Options options = this.options;
      int min = this.min;
      int max = this.max;
      int range = this.range;
      int interval = this.interval;
      int target = this.target;
      int canvasHeight = this.canvasHeight;
      int lineHeight = this.lineHeight;
      int pheight = canvasHeight - lineHeight;
      int ytop;
      int val;
      String color;
      int x;

      val = clipval(values[valuenum], min, max);
      x = valuenum * interval;
      ytop = (pheight - pheight * ((val - min) / range)).round();
      color = (options.thresholdColor && val < options.thresholdValue) ? options.thresholdColor : options.lineColor;
      if (highlight) {
        color = this.calcHighlightColor(color, options);
      }
      return target.drawLine(x, ytop, x, ytop + lineHeight, color);
    }
  }

  /**
   * Bullet charts
   */
  class Bullet extends _Base {
    Bullet(dom.HtmlElement el, List<int> values, Options options, int width, int height)
      : super(el, values, options, width, height) {
      int min;
      int max;
      List<int> vals;

      // values: target, performance, range1, range2, range3
      this.values = values = normalizeValues(values);
      // target or performance could be null
      vals = values.slice();
      vals[0] = vals[0] == null ? vals[2] : vals[0];
      vals[1] = values[1] == null ? vals[2] : vals[1];
      min = math.min(Math, values);
      max = math.max(Math, values);
      if (options.base == null) {
        min = min < 0 ? min : 0;
      } else {
        min = options.base;
      }
      this.min = min;
      this.max = max;
      this.range = max - min;
      this.shapes = {};
      this.valueShapes = {};
      this.regiondata = {};
      this.width = width = options.width == 'auto' ? '4.0em' : width;
      this.target = this.$el.simpledraw(width, height, options.composite);
      if (values.length == 0) {
        this.disabled = true;
      }
      this.initTarget();
    }

    void getRegion(dom.HtmlElement el, int x, int y) {
      var shapeid = this.target.getShapeAt(el, x, y);
      return (shapeid != null && this.shapes[shapeid] != null) ? this.shapes[shapeid] : null;
    }

    Map getCurrentRegionFields() {
      var currentRegion = this.currentRegion;
      return {
        'fieldkey': currentRegion.substr(0, 1),
        'value': this.values[currentRegion.substr(1)],
        'region': currentRegion
      };
    }

    void changeHighlight(bool highlight) {
      int currentRegion = this.currentRegion;
      int shapeid = this.valueShapes[currentRegion];
      int shape;
      delete this.shapes[shapeid];
      switch (currentRegion.substr(0, 1)) {
        case 'r':
          shape = this.renderRange(currentRegion.substr(1), highlight);
          break;
        case 'p':
          shape = this.renderPerformance(highlight);
          break;
        case 't':
          shape = this.renderTarget(highlight);
          break;
      }
      this.valueShapes[currentRegion] = shape.id;
      this.shapes[shape.id] = currentRegion;
      this.target.replaceWithShape(shapeid, shape);
    }

    void renderRange(int rn, bool highlight) {
      int rangeval = this.values[rn];
      int rangewidth = (this.canvasWidth * ((rangeval - this.min) / this.range)).round();
      String color = this.options.rangeColors[rn - 2];
      if (highlight) {
        color = this.calcHighlightColor(color, this.options);
      }
      return this.target.drawRect(0, 0, rangewidth - 1, this.canvasHeight - 1, color, color);
    }

    void renderPerformance(bool highlight) {
      int perfval = this.values[1],
      int perfwidth = (this.canvasWidth * ((perfval - this.min) / this.range)).round();
      String color = this.options.get('performanceColor');
      if (highlight) {
        color = this.calcHighlightColor(color, this.options);
      }
      return this.target.drawRect(0, Math.round(this.canvasHeight * 0.3), perfwidth - 1,
          (this.canvasHeight * 0.4).round() - 1, color, color);
    }

    void renderTarget(bool highlight) {
      int targetval = this.values[0];
      int x = (this.canvasWidth * ((targetval - this.min) / this.range) - (this.options.targetWidth / 2)).round();
      int targettop = (this.canvasHeight * 0.10).round();
      int targetheight = this.canvasHeight - (targettop * 2);
      String color = this.options.targetColor;
      if (highlight) {
        color = this.calcHighlightColor(color, this.options);
      }
      return this.target.drawRect(x, targettop, this.options.targetWidth - 1, targetheight - 1, color, color);
    }

    void render() {
      int vlen = this.values.length,
      int target = this.target;
      int i;
      int shape;
      if (!super.render(this)) {
        return;
      }
      for (i = 2; i < vlen; i++) {
        shape = this.renderRange(i).append();
        this.shapes[shape.id] = 'r' + i;
        this.valueShapes['r' + i] = shape.id;
      }
      if (this.values[1] != null) {
        shape = this.renderPerformance().append();
        this.shapes[shape.id] = 'p1';
        this.valueShapes.p1 = shape.id;
      }
      if (this.values[0] != null) {
        shape = this.renderTarget().append();
        this.shapes[shape.id] = 't0';
        this.valueShapes.t0 = shape.id;
      }
      target.render();
    }
  }

  /**
   * Pie charts
   */
  class Pie extends _Base {

    Pie(dom.HtmlElement el, List<int> values, Options options, int width, int height)
        : super(el, values, options, width, height){
      int total = 0;
      int i;

      this.shapes = {}; // map shape ids to value offsets
      this.valueShapes = {}; // maps value offsets to shape ids
      this.values = values = $.map(values, Number);

      if (options.width == 'auto') {
        this.width = this.height;
      }

      if (values.length > 0) {
        for (i = values.length; i--;) {
          total += values[i];
        }
      }
      this.total = total;
      this.initTarget();
      this.radius = (math.min(this.canvasWidth, this.canvasHeight) / 2).floor();
    }

    void getRegion(dom.HtmlElement el, int x, int y) {
        int shapeid = this.target.getShapeAt(el, x, y);
        return (shapeid != null && this.shapes[shapeid] != null) ? this.shapes[shapeid] : null;
    }

    void getCurrentRegionFields() {
      int currentRegion = this.currentRegion;
      return {
        'isNull': this.values[currentRegion] == null,
        'value': this.values[currentRegion],
        'percent': this.values[currentRegion] / this.total * 100,
        'color': this.options.sliceColors[currentRegion % this.options.sliceColors.length],
        'offset': currentRegion
      };
    }

    void changeHighlight(bool highlight) {
      int currentRegion = this.currentRegion;
      int newslice = this.renderSlice(currentRegion, highlight);
      int shapeid = this.valueShapes[currentRegion];
      delete this.shapes[shapeid];
      this.target.replaceWithShape(shapeid, newslice);
      this.valueShapes[currentRegion] = newslice.id;
      this.shapes[newslice.id] = currentRegion;
    }

    void renderSlice(int valuenum, bool highlight) {
      int target = this.target;
      Options options = this.options;
      int radius = this.radius;
      int borderWidth = options.borderWidth;
      int offset = options.offset;
      int circle = 2 * math.PI;
      List<int> values = this.values;
      int total = this.total;
      int next = offset ? (2 * math.PI) * (offset/360) : 0;
      int start;
      int end;
      int i;
      int vlen;
      String color;

      vlen = values.length;
      for (i = 0; i < vlen; i++) {
        start = next;
        end = next;
        if (total > 0) {  // avoid divide by zero
          end = next + (circle * (values[i] / total));
        }
        if (valuenum == i) {
          color = options.sliceColors[i % options.sliceColors.length];
          if (highlight) {
            color = this.calcHighlightColor(color, options);
          }

          return target.drawPieSlice(radius, radius, radius - borderWidth, start, end, undefined, color);
        }
        next = end;
      }
    }

    void render() {
      int target = this.target;
      List<int> values = this.values;
      Options options = this.options;
      int radius = this.radius;
      int borderWidth = options.borderWidth;
      int shape;
      int i;

      if (!super.render()) {
        return;
      }
      if (borderWidth == null) {
        target.drawCircle(radius, radius, Math.floor(radius - (borderWidth / 2)),
            options.borderColor, null, borderWidth).append();
      }
      for (i = values.length; i--;) {
        if (values[i]) { // don't render zero values
          shape = this.renderSlice(i).append();
          this.valueShapes[i] = shape.id; // store just the shapeid
          this.shapes[shape.id] = i;
        }
      }
      target.render();
    }
  }

  /**
   * Box plots
   */
  class Box extends _Base {
    Box(dom.HtmlElement el, List<int> values, Options options, int width, int height)
        : super (el, values, options, width, height) {
      this.values = $.map(values, Number);
      this.width = options.width == 'auto' ? '4.0em' : width;
      this.initTarget();
      if (!this.values.length) {
          this.disabled = 1;
      }
    }

    /**
     * Simulate a single region
     */
    int getRegion() {
        return 1;
    }

    void getCurrentRegionFields() {
      var result = [
          { 'field': 'lq', 'value': this.quartiles[0] },
          { 'field': 'med', 'value': this.quartiles[1] },
          { 'field': 'uq', 'value': this.quartiles[2] }
      ];
      if (this.loutlier != null) {
          result.add({ 'field': 'lo', 'value': this.loutlier});
      }
      if (this.routlier != null) {
          result.add({ 'field': 'ro', 'value': this.routlier});
      }
      if (this.lwhisker != null) {
          result.push({ 'field': 'lw', 'value': this.lwhisker});
      }
      if (this.rwhisker != null) {
          result.push({ 'field': 'rw', 'value': this.rwhisker});
      }
      return result;
    }

    void render() {
      int target = this.target;
      List<int> values = this.values;
      int vlen = values.length;
      Options options = this.options;
      int canvasWidth = this.canvasWidth;
      int canvasHeight = this.canvasHeight;
      int minValue = options.chartRangeMin == null ? math.min(Math, values) : options.chartRangeMin;
      int maxValue = options.chartRangeMax == null ? math.max(Math, values) : options.chartRangeMax;
      int canvasLeft = 0;
      int lwhisker;
      int loutlier;
      int iqr;
      int q1;
      int q2;
      int q3;
      int rwhisker;
      int routlier;
      int i;
      int size;
      int unitSize;

      if (!super.render()) {
        return;
      }

      if (options.raw) {
        if (options.showOutliers && values.length > 5) {
          loutlier = values[0];
          lwhisker = values[1];
          q1 = values[2];
          q2 = values[3];
          q3 = values[4];
          rwhisker = values[5];
          routlier = values[6];
        } else {
          lwhisker = values[0];
          q1 = values[1];
          q2 = values[2];
          q3 = values[3];
          rwhisker = values[4];
        }
      } else {
        values.sort((a, b) { return a - b; });
        q1 = quartile(values, 1);
        q2 = quartile(values, 2);
        q3 = quartile(values, 3);
        iqr = q3 - q1;
        if (options.showOutliers) {
          lwhisker = rwhisker = undefined;
          for (i = 0; i < vlen; i++) {
            if (lwhisker == null && values[i] > q1 - (iqr * options.outlierIQR))) {
              lwhisker = values[i];
            }
            if (values[i] < q3 + (iqr * options.outlierIQR)) {
              rwhisker = values[i];
            }
          }
          loutlier = values[0];
          routlier = values[vlen - 1];
        } else {
          lwhisker = values[0];
          rwhisker = values[vlen - 1];
        }
      }
      this.quartiles = [q1, q2, q3];
      this.lwhisker = lwhisker;
      this.rwhisker = rwhisker;
      this.loutlier = loutlier;
      this.routlier = routlier;

      unitSize = canvasWidth / (maxValue - minValue + 1);
      if (options.showOutliers) {
        canvasLeft = (options.spotRadius).ceil();
        canvasWidth -= 2 * (options.spotRadius).ceil();
        unitSize = canvasWidth / (maxValue - minValue + 1);
        if (loutlier < lwhisker) {
          target.drawCircle((loutlier - minValue) * unitSize + canvasLeft,
              canvasHeight / 2,
              options.spotRadius,
              options.outlierLineColor,
              options.outlierFillColor).append();
        }
        if (routlier > rwhisker) {
          target.drawCircle((routlier - minValue) * unitSize + canvasLeft,
              canvasHeight / 2,
              options.spotRadius,
              options.outlierLineColor,
              options.outlierFillColor).append();
        }
      }

      // box
      target.drawRect(
          ((q1 - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight * 0.1).round(),
          ((q3 - q1) * unitSize).round(),
          (canvasHeight * 0.8).round(),
          options.boxLineColor,
          options.boxFillColor).append();
      // left whisker
      target.drawLine(
          ((lwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 2).round(),
          ((q1 - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 2).round(),
          options.lineColor).append();
      target.drawLine(
          ((lwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 4).round(),
          ((lwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight - canvasHeight / 4).round(),
          options.whiskerColor).append();
      // right whisker
      target.drawLine(((rwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 2).round(),
          ((q3 - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 2).round(),
          options.lineColor).append();
      target.drawLine(
          ((rwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight / 4).round(),
          ((rwhisker - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight - canvasHeight / 4).round(),
          options.whiskerColor).append();
      // median line
      target.drawLine(
          ((q2 - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight * 0.1).round(),
          ((q2 - minValue) * unitSize + canvasLeft).round(),
          (canvasHeight * 0.9).round(),
          options.medianColor).append();
      if (options.target) {
        size = (options.get('spotRadius')).ciel();
        target.drawLine(
            ((options.target - minValue) * unitSize + canvasLeft).round(),
            ((canvasHeight / 2) - size).round(),
            ((options.target - minValue) * unitSize + canvasLeft).round(),
            ((canvasHeight / 2) + size).round(),
            options.targetColor).append();
        target.drawLine(
            ((options.get('target') - minValue) * unitSize + canvasLeft - size).round(),
            (canvasHeight / 2).round(),
            ((options.target - minValue) * unitSize + canvasLeft + size).round(),
            (canvasHeight / 2).round(),
            options.targetColor).append();
      }
      target.render();
    }
  }

  // Setup a very simple "virtual canvas" to make drawing the few shapes we need easier
  // This is accessible as $(foo).simpledraw()

  abstract class VShape  {
    VShape (dom.HtmlElement target, int id, String type, int args) {
      this.target = target;
      this.id = id;
      this.type = type;
      this.args = args;
    }
    VShape append() {
      this.target.appendShape(this);
      return this;
    }
  }

  class VCanvasBase {
    String _pxregex = r'(\d+)(px)?\s*$' /*/i*/;

    VCanvas (int width, int height, dom.HtmlElement target) {
      if (width == null) {
        return;
      }
      this.width = width;
      this.height = height;
      this.target = target;
      this.lastShapeId = null;
      if (target[0]) {
          target = target[0];
      }
      $.data(target, '_jqs_vcanvas', this);
    }

    void drawLine(int x1, int y1, int x2, int y2, String lineColor, int lineWidth) {
      return this.drawShape([[x1, y1], [x2, y2]], lineColor, lineWidth);
    }

    void drawShape(List<int> path, String lineColor, String fillColor, int lineWidth) {
      return this._genShape('Shape', [path, lineColor, fillColor, lineWidth]);
    }

    void drawCircle(int x, int y, int radius, String lineColor, String fillColor, int lineWidth) {
      return this._genShape('Circle', [x, y, radius, lineColor, fillColor, lineWidth]);
    }

    void drawPieSlice(int x, int y, int radius, int startAngle, int endAngle, String lineColor, String fillColor) {
      return this._genShape('PieSlice', [x, y, radius, startAngle, endAngle, lineColor, fillColor]);
    }

    int drawRect(int x, int y, int width, int height, String lineColor, String fillColor) {
      return this._genShape('Rect', [x, y, width, height, lineColor, fillColor]);
    }

    int getElement() {
      return this.canvas;
    }

    /**
     * Return the most recently inserted shape id
     */
    itn getLastShapeId() {
      return this.lastShapeId;
    }

    /**
     * Clear and reset the canvas
     */
    void reset(); /* {
      throw 'reset not implemented';
    }*/

    vid _insert(dom.HtmlElement el, dom.HtmlElement target) {
      $(target).html(el);
    }

    /**
     * Calculate the pixel dimensions of the canvas
     */
    int _calculatePixelDims(int width, int height, int canvas) {
      // TODO This should probably be a configurable option
      var match;
      match = this._pxregex.exec(height);
      if (match) {
        this.pixelHeight = match[1];
      } else {
        this.pixelHeight = $(canvas).height();
      }
      match = this._pxregex.exec(width);
      if (match) {
        this.pixelWidth = match[1];
      } else {
        this.pixelWidth = $(canvas).width();
      }
    }

    /**
     * Generate a shape object and id for later rendering
     */
    void _genShape (String shapetype, int shapeargs) {
      var id = shapeCount++;
      shapeargs.unshift(id);
      return new VShape(this, id, shapetype, shapeargs);
    }

    /**
     * Add a shape to the end of the render queue
     */
    void appendShape(Shape shape); /* {
      throw 'appendShape not implemented';
    }*/

    /**
     * Replace one shape with another
     */
    void replaceWithShape(int shapeid, Shape shape); /* {
      throw 'replaceWithShape not implemented';
    }*/

    /**
     * Insert one shape after another in the render queue
     */
    void insertAfterShape(int shapeid, Shape shape); /* {
      throw 'insertAfterShape not implemented';
    }*/

    /**
     * Remove a shape from the queue
     */
    void removeShapeId(int shapeid); /* {
      throw('removeShapeId not implemented');
    },*/

    /**
     * Find a shape at the specified x/y co-ordinates
     */
    void getShapeAt(dom.HtmlElement el, int x, int y); /* {
        alert('getShapeAt not implemented');
    },*/

    /**
     * Render all queued shapes onto the canvas
     */
    void render(); /* {
        alert('render not implemented');
    }*/
  }

  class VCanvasCanvas extends VCanvasBase {
    VCanvasCanvas(int width, int height, dom.HtmlElement target, bool interact)
        : super(width, height, target) {
      this.canvas = dom.document.createElement('canvas');
      if (target[0]) {
        target = target[0];
      }
      $.data(target, '_jqs_vcanvas', this);
      $(this.canvas).css({ display: 'inline-block', width: width, height: height, verticalAlign: 'top' });
      this._insert(this.canvas, target);
      this._calculatePixelDims(width, height, this.canvas);
      this.canvas.width = this.pixelWidth;
      this.canvas.height = this.pixelHeight;
      this.interact = interact;
      this.shapes = {};
      this.shapeseq = [];
      this.currentTargetShapeId = null;
      $(this.canvas).css({width: this.pixelWidth, height: this.pixelHeight});
    }

    void _getContext(String lineColor, String fillColor, int lineWidth) {
      var context = this.canvas.getContext('2d');
      if (lineColor != null) {
        context.strokeStyle = lineColor;
      }
      context.lineWidth = lineWidth == null? 1 : lineWidth;
      if (fillColor != null) {
        context.fillStyle = fillColor;
      }
      return context;
    }

    void reset() {
      var context = this._getContext();
      context.clearRect(0, 0, this.pixelWidth, this.pixelHeight);
      this.shapes = {};
      this.shapeseq = [];
      this.currentTargetShapeId = undefined;
    }

    void _drawShape(int shapeid, List<int> path, String lineColor, String fillColor, int lineWidth) {
      int context = this._getContext(lineColor, fillColor, lineWidth);
      int i;
      int plen= path.length;
      context.beginPath();
      context.moveTo(path[0][0] + 0.5, path[0][1] + 0.5);
      for (i = 1; i < plen; i++) {
        context.lineTo(path[i][0] + 0.5, path[i][1] + 0.5); // the 0.5 offset gives us crisp pixel-width lines
      }
      if (lineColor != null) {
        context.stroke();
      }
      if (fillColor != null) {
        context.fill();
      }
      if (this.targetX != null && this.targetY != null &&
        context.isPointInPath(this.targetX, this.targetY)) {
        this.currentTargetShapeId = shapeid;
      }
    }

    void _drawCircle(int shapeid, int x, int y, int radius, String lineColor, String fillColor, int lineWidth) {
      var context = this._getContext(lineColor, fillColor, lineWidth);
      context.beginPath();
      context.arc(x, y, radius, 0, 2 * Math.PI, false);
      if (this.targetX != null && this.targetY != null &&
        context.isPointInPath(this.targetX, this.targetY)) {
        this.currentTargetShapeId = shapeid;
      }
      if (lineColor != null) {
        context.stroke();
      }
      if (fillColor != null) {
        context.fill();
      }
    }

    void _drawPieSlice(int shapeid, int x, int y, int radius, int startAngle, int endAngle, String lineColor, String fillColor) {
      int context = this._getContext(lineColor, fillColor);
      context.beginPath();
      context.moveTo(x, y);
      context.arc(x, y, radius, startAngle, endAngle, false);
      context.lineTo(x, y);
      context.closePath();
      if (lineColor != null) {
        context.stroke();
      }
      if (fillColor) {
        context.fill();
      }
      if (this.targetX != null && this.targetY != null &&
        context.isPointInPath(this.targetX, this.targetY)) {
        this.currentTargetShapeId = shapeid;
      }
    }

    void _drawRect(int shapeid, int x, int y, int width, int height, String lineColor, String fillColor) {
      return this._drawShape(shapeid, [[x, y], [x + width, y], [x + width, y + height], [x, y + height], [x, y]], lineColor, fillColor);
    }

    void appendShape(Shape shape) {
      this.shapes[shape.id] = shape;
      this.shapeseq.push(shape.id);
      this.lastShapeId = shape.id;
      return shape.id;
    }

    void replaceWithShape(int shapeid, Shape shape) {
      int  shapeseq = this.shapeseq;
      int  i;
      this.shapes[shape.id] = shape;
      for (i = shapeseq.length; i--;) {
        if (shapeseq[i] == shapeid) {
          shapeseq[i] = shape.id;
        }
      }
      delete this.shapes[shapeid];
    }

    void replaceWithShapes(List<int> shapeids, List<Shape> shapes) {
      int shapeseq = this.shapeseq;
      Map shapemap = {};
      int sid;
      int i;
      int first;

      for (i = shapeids.length; i--; i > 0) {
        shapemap[shapeids[i]] = true;
      }
      for (i = shapeseq.length; i--; I > 0) {
        sid = shapeseq[i];
        if (shapemap[sid]) {
          shapeseq.splice(i, 1);
          delete this.shapes[sid];
          first = i;
        }
      }
      for (i = shapes.length; i--;) {
        shapeseq.splice(first, 0, shapes[i].id);
        this.shapes[shapes[i].id] = shapes[i];
      }
    }

    void insertAfterShape(int shapeid, Shape shape) {
      int shapeseq = this.shapeseq;
      int i;
      for (i = shapeseq.length; i--; i > 0) {
        if (shapeseq[i] == shapeid) {
          shapeseq.splice(i + 1, 0, shape.id);
          this.shapes[shape.id] = shape;
          return;
        }
      }
    }

    void removeShapeId(int shapeid) {
      int shapeseq = this.shapeseq;
      int i;
      for (i = shapeseq.length; i--; i > 0) {
        if (shapeseq[i] == shapeid) {
          shapeseq.splice(i, 1);
          break;
        }
      }
      delete this.shapes[shapeid];
    }

    void getShapeAt(dom.HtmlElement el, int x, int y) {
      this.targetX = x;
      this.targetY = y;
      this.render();
      return this.currentTargetShapeId;
    }

    void render() {
      int shapeseq = this.shapeseq;
      List<Shape> shapes = this.shapes;
      int shapeCount = shapeseq.length;
      int context = this._getContext();
      int shapeid;
      Shape shape;
      int i;
      context.clearRect(0, 0, this.pixelWidth, this.pixelHeight);
      for (i = 0; i < shapeCount; i++) {
        shapeid = shapeseq[i];
        shape = shapes[shapeid];
        this['_draw' + shape.type].apply(this, shape.args);
      }
      if (!this.interact) {
        // not interactive so no need to keep the shapes array
        this.shapes = {};
        this.shapeseq = [];
      }
    }
  }

//  VCanvas_vml = createClass(VCanvas_base, {
//    init: function (width, height, target) {
//        var groupel;
//        VCanvas_vml._super.init.call(this, width, height, target);
//        if (target[0]) {
//            target = target[0];
//        }
//        $.data(target, '_jqs_vcanvas', this);
//        this.canvas = document.createElement('span');
//        $(this.canvas).css({ display: 'inline-block', position: 'relative', overflow: 'hidden', width: width, height: height, margin: '0px', padding: '0px', verticalAlign: 'top'});
//        this._insert(this.canvas, target);
//        this._calculatePixelDims(width, height, this.canvas);
//        this.canvas.width = this.pixelWidth;
//        this.canvas.height = this.pixelHeight;
//        groupel = '<v:group coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '"' +
//                ' style="position:absolute;top:0;left:0;width:' + this.pixelWidth + 'px;height=' + this.pixelHeight + 'px;"></v:group>';
//        this.canvas.insertAdjacentHTML('beforeEnd', groupel);
//        this.group = $(this.canvas).children()[0];
//        this.rendered = false;
//        this.prerender = '';
//    },
//
//    _drawShape: function (shapeid, path, lineColor, fillColor, lineWidth) {
//        var vpath = [],
//            initial, stroke, fill, closed, vel, plen, i;
//        for (i = 0, plen = path.length; i < plen; i++) {
//            vpath[i] = '' + (path[i][0]) + ',' + (path[i][1]);
//        }
//        initial = vpath.splice(0, 1);
//        lineWidth = lineWidth === undefined ? 1 : lineWidth;
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="' + lineWidth + 'px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        closed = vpath[0] === vpath[vpath.length - 1] ? 'x ' : '';
//        vel = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '" ' +
//             ' id="jqsshape' + shapeid + '" ' +
//             stroke +
//             fill +
//            ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + 'px;width:' + this.pixelWidth + 'px;padding:0px;margin:0px;" ' +
//            ' path="m ' + initial + ' l ' + vpath.join(', ') + ' ' + closed + 'e">' +
//            ' </v:shape>';
//        return vel;
//    },
//
//    _drawCircle: function (shapeid, x, y, radius, lineColor, fillColor, lineWidth) {
//        var stroke, fill, vel;
//        x -= radius;
//        y -= radius;
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="' + lineWidth + 'px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        vel = '<v:oval ' +
//             ' id="jqsshape' + shapeid + '" ' +
//            stroke +
//            fill +
//            ' style="position:absolute;top:' + y + 'px; left:' + x + 'px; width:' + (radius * 2) + 'px; height:' + (radius * 2) + 'px"></v:oval>';
//        return vel;
//
//    },
//
//    _drawPieSlice: function (shapeid, x, y, radius, startAngle, endAngle, lineColor, fillColor) {
//        var vpath, startx, starty, endx, endy, stroke, fill, vel;
//        if (startAngle === endAngle) {
//            return '';  // VML seems to have problem when start angle equals end angle.
//        }
//        if ((endAngle - startAngle) === (2 * Math.PI)) {
//            startAngle = 0.0;  // VML seems to have a problem when drawing a full circle that doesn't start 0
//            endAngle = (2 * Math.PI);
//        }
//
//        startx = x + Math.round(Math.cos(startAngle) * radius);
//        starty = y + Math.round(Math.sin(startAngle) * radius);
//        endx = x + Math.round(Math.cos(endAngle) * radius);
//        endy = y + Math.round(Math.sin(endAngle) * radius);
//
//        if (startx === endx && starty === endy) {
//            if ((endAngle - startAngle) < Math.PI) {
//                // Prevent very small slices from being mistaken as a whole pie
//                return '';
//            }
//            // essentially going to be the entire circle, so ignore startAngle
//            startx = endx = x + radius;
//            starty = endy = y;
//        }
//
//        if (startx === endx && starty === endy && (endAngle - startAngle) < Math.PI) {
//            return '';
//        }
//
//        vpath = [x - radius, y - radius, x + radius, y + radius, startx, starty, endx, endy];
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="1px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        vel = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '" ' +
//             ' id="jqsshape' + shapeid + '" ' +
//             stroke +
//             fill +
//            ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + 'px;width:' + this.pixelWidth + 'px;padding:0px;margin:0px;" ' +
//            ' path="m ' + x + ',' + y + ' wa ' + vpath.join(', ') + ' x e">' +
//            ' </v:shape>';
//        return vel;
//    },
//
//    _drawRect: function (shapeid, x, y, width, height, lineColor, fillColor) {
//        return this._drawShape(shapeid, [[x, y], [x, y + height], [x + width, y + height], [x + width, y], [x, y]], lineColor, fillColor);
//    },
//
//    reset: function () {
//        this.group.innerHTML = '';
//    },
//
//    appendShape: function (shape) {
//        var vel = this['_draw' + shape.type].apply(this, shape.args);
//        if (this.rendered) {
//            this.group.insertAdjacentHTML('beforeEnd', vel);
//        } else {
//            this.prerender += vel;
//        }
//        this.lastShapeId = shape.id;
//        return shape.id;
//    },
//
//    replaceWithShape: function (shapeid, shape) {
//        var existing = $('#jqsshape' + shapeid),
//            vel = this['_draw' + shape.type].apply(this, shape.args);
//        existing[0].outerHTML = vel;
//    },
//
//    replaceWithShapes: function (shapeids, shapes) {
//        // replace the first shapeid with all the new shapes then toast the remaining old shapes
//        var existing = $('#jqsshape' + shapeids[0]),
//            replace = '',
//            slen = shapes.length,
//            i;
//        for (i = 0; i < slen; i++) {
//            replace += this['_draw' + shapes[i].type].apply(this, shapes[i].args);
//        }
//        existing[0].outerHTML = replace;
//        for (i = 1; i < shapeids.length; i++) {
//            $('#jqsshape' + shapeids[i]).remove();
//        }
//    },
//
//    insertAfterShape: function (shapeid, shape) {
//        var existing = $('#jqsshape' + shapeid),
//             vel = this['_draw' + shape.type].apply(this, shape.args);
//        existing[0].insertAdjacentHTML('afterEnd', vel);
//    },
//
//    removeShapeId: function (shapeid) {
//        var existing = $('#jqsshape' + shapeid);
//        this.group.removeChild(existing[0]);
//    },
//
//    getShapeAt: function (el, x, y) {
//        var shapeid = el.id.substr(8);
//        return shapeid;
//    },
//
//    render: function () {
//        if (!this.rendered) {
//            // batch the intial render into a single repaint
//            this.group.innerHTML = this.prerender;
//            this.rendered = true;
//        }
//    }
//  }
