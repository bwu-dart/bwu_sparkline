library bwu_sparkline.sp_tooltip;

import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

import 'package:bwu_sparklines/bwu_sparkline.dart';

@CustomTag('sp-tooltip')
class SpTooltip extends PolymerElement {
  Options _options;
  String _sizetip;

  @observable String cssClass;
  @observable bool showSizetip = false;
  @observable bool showTooltip = false;

  SpTooltip.created() : super.created();

  int _offset;

  init(Options options) {
    _options = options;

    //String sizetipStyle = sizeStyle;
    // remove any previous lingering tooltip
//    $('#jqssizetip').remove();
//    $('#jqstooltip').remove();
//    sizetip = '<div/>', {
//      id: 'jqssizetip',
//      style: sizetipStyle,
//      'class': tooltipClassname
//    });
//    this.tooltip = $('<div/>', {
//      id: 'jqstooltip',
//      'class': tooltipClassname
//    }).appendTo(this.container);
    cssClass = options.tooltip.cssClass;

    // account for the container's location
    _offset = this.tooltip.offset();
    offsetLeft = offset.left;
    offsetTop = offset.top;
    hidden = true;
    $(window).unbind('resize.jqs scroll.jqs');
    $(window).bind('resize.jqs scroll.jqs', $.proxy(this.updateWindowDims, this));
    this.updateWindowDims();
  }

  void updateWindowDims() {
    scrollTop = dom.window.scrollTop;
    scrollLeft = dom.window.scrollLeft;
    scrollRight = scrollLeft + window.width;
    updatePosition();
  }

  void getSize(String content) {
    sizetip.html(content).appendTo(container);
    width = sizetip.width() + 1;
    height = sizetip.height();
    sizetip.remove();
  }

  void setContent(String content) {
    if (content == null) {
      tooltip.css('visibility', 'hidden');
      hidden = true;
      return;
    }
    getSize(content);
    tooltip.html(content)
      .css({
          'width': width,
          'height': height,
          'visibility': 'visible'
      });
    if (hidden) {
      hidden = false;
      updatePosition();
    }
  }

  void updatePosition([int x, int y]) {
    if (x == null) {
      if (mousex == null) {
        return;
      }
      x = mousex - offsetLeft;
      y = mousey - offsetTop;
    } else {
      mousex = x = x - offsetLeft;
      mousey = y = y - offsetTop;
    }
    if (!height || !width || hidden) {
      return;
    }

    y -= height + tooltipOffsetY;
    x += tooltipOffsetX;

    if (y < scrollTop) {
      y = scrollTop;
    }
    if (x < scrollLeft) {
      x = scrollLeft;
    } else if (x + width > scrollRight) {
      x = scrollRight - width;
    }

    style
      ..left = '${x}px'
      ..top = '${y}px';
  }

  void remove() {
    tooltip.remove();
    sizetip.remove();
    sizetip = tooltip = null;
    window.unbind('resize.jqs scroll.jqs');
  }
}