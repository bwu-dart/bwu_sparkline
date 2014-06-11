library bwu_sparkline.sp_tooltip;

import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

import 'package:bwu_sparklines/bwu_sparkline.dart';

@CustomTag('sp-tooltip')
class SpTooltip extends PolymerElement {
  SpTooltip.created() : super.created();

      init(Options options) {
          var tooltipClassname = options.get('tooltipClassname', 'jqstooltip'),
              sizetipStyle = this.sizeStyle,
              offset;
          this.container = options.get('tooltipContainer') || document.body;
          this.tooltipOffsetX = options.get('tooltipOffsetX', 10);
          this.tooltipOffsetY = options.get('tooltipOffsetY', 12);
          // remove any previous lingering tooltip
          $('#jqssizetip').remove();
          $('#jqstooltip').remove();
          this.sizetip = $('<div/>', {
              id: 'jqssizetip',
              style: sizetipStyle,
              'class': tooltipClassname
          });
          this.tooltip = $('<div/>', {
              id: 'jqstooltip',
              'class': tooltipClassname
          }).appendTo(this.container);
          // account for the container's location
          offset = this.tooltip.offset();
          this.offsetLeft = offset.left;
          this.offsetTop = offset.top;
          this.hidden = true;
          $(window).unbind('resize.jqs scroll.jqs');
          $(window).bind('resize.jqs scroll.jqs', $.proxy(this.updateWindowDims, this));
          this.updateWindowDims();
      },

      updateWindowDims: function () {
          this.scrollTop = $(window).scrollTop();
          this.scrollLeft = $(window).scrollLeft();
          this.scrollRight = this.scrollLeft + $(window).width();
          this.updatePosition();
      },

      getSize: function (content) {
          this.sizetip.html(content).appendTo(this.container);
          this.width = this.sizetip.width() + 1;
          this.height = this.sizetip.height();
          this.sizetip.remove();
      },

      setContent: function (content) {
          if (!content) {
              this.tooltip.css('visibility', 'hidden');
              this.hidden = true;
              return;
          }
          this.getSize(content);
          this.tooltip.html(content)
              .css({
                  'width': this.width,
                  'height': this.height,
                  'visibility': 'visible'
              });
          if (this.hidden) {
              this.hidden = false;
              this.updatePosition();
          }
      },

      updatePosition: function (x, y) {
          if (x === undefined) {
              if (this.mousex === undefined) {
                  return;
              }
              x = this.mousex - this.offsetLeft;
              y = this.mousey - this.offsetTop;

          } else {
              this.mousex = x = x - this.offsetLeft;
              this.mousey = y = y - this.offsetTop;
          }
          if (!this.height || !this.width || this.hidden) {
              return;
          }

          y -= this.height + this.tooltipOffsetY;
          x += this.tooltipOffsetX;

          if (y < this.scrollTop) {
              y = this.scrollTop;
          }
          if (x < this.scrollLeft) {
              x = this.scrollLeft;
          } else if (x + this.width > this.scrollRight) {
              x = this.scrollRight - this.width;
          }

          this.tooltip.css({
              'left': x,
              'top': y
          });
      },

      remove: function () {
          this.tooltip.remove();
          this.sizetip.remove();
          this.sizetip = this.tooltip = undefined;
          $(window).unbind('resize.jqs scroll.jqs');
      }
  });
}