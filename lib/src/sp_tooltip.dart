library bwu_sparkline.sp_tooltip;

import 'dart:html' as dom;
import 'dart:async' as async;

import 'package:polymer/polymer.dart';

import 'package:bwu_sparklines/bwu_sparkline.dart';

@CustomTag('sp-tooltip')
class SpTooltip extends PolymerElement {
  SpTooltip.created() : super.created();

  factory SpTooltip.singleton() {
    if(_toolTip == null) {
      _toolTip = new dom.Element.tag('sp-tooltip');
    }
    return _toolTip;
  }

  static dom.HtmlElement _sizeTip;
  static SpTooltip _toolTip;

  Options options;

  @observable String cssClass;
  @observable bool showTooltip = false;

  int mousex;
  int mousey;
  int offsetLeft;
  int offsetTop;
  int scrollRight;
  int width;
  int height;
  int tooltipOffsetX;
  int tooltipOffsetY;
  bool hidden;
  dom.HtmlElement container;


  int _offset;

  async.StreamSubscription resizeSubscription;
  async.StreamSubscription scrollSubscription;

  bool _isAttached = false;

  @override
  void attached() {
    super.attached();

    // account for the container's location
    //_offset = this.tooltip.offset();
    offsetLeft = offset.left;
    offsetTop = offset.top;
    hidden = true;

    if(resizeSubscription != null) resizeSubscription.cancel();
    if(scrollSubscription != null) scrollSubscription.cancel();
    //$(window).unbind('resize.jqs scroll.jqs');
    resizeSubscription = dom.window.onResize.listen((e) => updateWindowDims());
    scrollSubscription = dom.window.onScroll.listen((e) => updateWindowDims());
    //$(window).bind('resize.jqs scroll.jqs', $.proxy(this.updateWindowDims, this));
    updateWindowDims();

    _isAttached = true;
    if(_attachCompleter != null) {
      _attachCompleter.complete();
    }
  }

  @override
  void detached() {
    super.detached();
    _isAttached = false;
  }

  async.Completer _attachCompleter;

  // TODO make constructor
  async.Future init(Options options) {
    this.options = options;
    cssClass = options.tooltip.cssClass;
    container = options.tooltip.container != null ? options.tooltip.container : dom.document.body;

    //String sizetipStyle = sizeStyle;
    // remove any previous lingering tooltip

    if(_sizeTip != null) _sizeTip.remove();
    if(_isAttached) remove();
    _sizeTip = new dom.Element.html('<div id="jqsizetip" class="${cssClass}"></div>')
      ..style.position ='static'
      ..style.display = 'block'
      ..style.visibility = 'hidden'
      ..style.float = 'left';

    //    this.tooltip = $('<div/>', {
//      id: 'jqstooltip',
//      'class': tooltipClassname
//    }).appendTo(this.container);

    container.append(this);

    _attachCompleter = new async.Completer();
    return _attachCompleter.future;
  }

  void updateWindowDims() {
    scrollTop = dom.window.scrollY;
    scrollLeft = dom.window.scrollX;
    scrollRight = scrollLeft + dom.window.innerWidth; // TODO with
    updatePosition();
  }

  void getSize(dom.DocumentFragment content) {
    _sizeTip
      ..children.clear()
      ..append(content);


    container.append(_sizeTip); //.html(content).appendTo(container);
    width = _sizeTip.offsetWidth + 1; // TODO width
    height = _sizeTip.offsetHeight; // TODO height
    _sizeTip.remove();
  }

  void setContent(String content) {
    if (content == null) {
      this.style.visibility = 'hidden';
      hidden = true;
      return;
    }
    var c = new dom.DocumentFragment.html(content);
    getSize(c);
    ($['jqstooltip'] as dom.HtmlElement)
        ..children.clear()
        ..append(c)
        ..style.width = '${width}px'
        ..style.height = '${height}px'
        ..style.visibility = 'visible';
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
    if (height == 0|| width == 0|| hidden) {
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
    remove();
    _sizeTip.remove();
    //sizetip = tooltip = null;
    //window.unbind('resize.jqs scroll.jqs');
    if(resizeSubscription != null) resizeSubscription.cancel();
    if(scrollSubscription != null) scrollSubscription.cancel();
  }
}