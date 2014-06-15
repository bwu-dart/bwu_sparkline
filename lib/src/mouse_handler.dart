part of bwu_sparkline;

class MouseHandler {
  Options _options;

  int currentPageX = 0;
  int currentPageY = 0;
  List<ChartBase> splist = [];
  SpTooltip tooltip = null;
  bool over = false;
  bool displayTooltips;
  bool highlightEnabled;
  VCanvas canvas;
  dom.HtmlElement currentEl;

  dom.HtmlElement _el;

  MouseHandler (this._el, this._options) {
    displayTooltips = !_options.disableTooltips;
    highlightEnabled = _options.enableHighlight;
  }

  void registerSparkline(ChartBase sp) {
    splist.add(sp);
    if (over) {
      updateDisplay();
    }
  }

  void registerCanvas(VCanvas canvas) {
    this.canvas = canvas;
    canvas.canvas.onMouseEnter.listen(mouseenter);
    canvas.canvas.onMouseLeave.listen(mouseleave);
    canvas.canvas.onClick.listen(mouseclick);
  }

  void reset([bool removeTooltip = false]) {
    splist = [];
    if (tooltip != null && removeTooltip) {
      tooltip.remove();
      tooltip = null;
    }
  }

  void mouseclick(e) {
    var clickEvent = new dom.CustomEvent('sparklineClick');
    clickEvent.detail = {['originalEvent'] : e, 'sparklines': splist};
    _el.dispatchEvent(clickEvent);
  }

  async.StreamSubscription mouseMoveSubscr;
  void mouseenter(e) {
    //dom.document.body.unbind('mousemove.jqs');
    if(mouseMoveSubscr != null) mouseMoveSubscr.cancel();
    mouseMoveSubscr = dom.document.body.on['mousemove.jqs'].listen(mousemove);
    over = true;
    currentPageX = e.page.x;
    currentPageY = e.page.y;
    currentEl = e.target;
    if (tooltip == null && displayTooltips) {
        tooltip = new dom.Element.tag('sp-tooltip');
        tooltip.options = _options;
        tooltip.updatePosition(e.page.x, e.page.x);
    }
    updateDisplay();
  }

  void mouseleave(e) {
    if(mouseMoveSubscr != null) mouseMoveSubscr.cancel();
    //dom.document.body.unbind('mousemove.jqs');
    int spcount = splist.length;
    bool needsRefresh = false;
    ChartBase sp;
    int i;
    over = false;
    currentEl = null;

    if (tooltip != null) {
        tooltip.remove();
        tooltip = null;
    }

    for (i = 0; i < spcount; i++) {
        sp = splist[i];
        if (sp.clearRegionHighlight()) {
            needsRefresh = true;
        }
    }

    if (needsRefresh) {
        canvas.render();
    }
  }

  void mousemove(e) {
    currentPageX = e.pageX;
    currentPageY = e.pageY;
    currentEl = e.target;
    if (tooltip != null) {
      tooltip.updatePosition(e.pageX, e.pageY);
    }
    updateDisplay();
  }

  void updateDisplay() {
    int spcount = splist.length;
    bool needsRefresh;
    math.Rectangle<double> offset = canvas.canvas.offset;
    int localX = currentPageX - offset.left.round();
    int localY = currentPageY - offset.top.round();
    String tooltiphtml;
    ChartBase sp;
    int i;
    bool result;
    dom.CustomEvent changeEvent;
    if (!over) {
      return;
    }
    for (i = 0; i < spcount; i++) {
      sp = splist[i];
      result = sp.setRegionHighlight(/*this.currentEl,*/ localX, localY);
      if (result != null) {
          needsRefresh = true;
      }
    }
    if (needsRefresh) {
      changeEvent = new dom.CustomEvent('sparklineRegionChange');
      changeEvent.detail['sparklines'] = splist;
      _el.dispatchEvent(changeEvent);
      if (tooltip != null) {
          tooltiphtml = '';
          for (i = 0; i < spcount; i++) {
              sp = splist[i];
              tooltiphtml += sp.getCurrentRegionTooltip();
          }
          this.tooltip.setContent(tooltiphtml);
      }
      if (highlightEnabled) {
          canvas.render();
      }
    }
    if (result == null) {
        this.mouseleave(null);
    }
  }
}