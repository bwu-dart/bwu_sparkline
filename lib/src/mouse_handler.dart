part of bwu_sparkline;

class MouseHandler {
  Options _options;

  int currentPageX = 0;
  int currentPageY = 0;
  List<BwuSparkline> splist = [];
  SpTooltip tooltip = null;
  bool over = false;
  bool displayTooltips = !options.disableTooltips;
  bool highlightEnabled = !options.disableHighlight;
  dom.CanvasRenderingContext2D canvas;
  dom.HtmlElement currentEl;

  dom.HtmlElement _el;

  MouseHandler (this._el, this._options);

  void registerSparkline(BwuSparkline sp) {
    splist.add(sp);
    if (over) {
      updateDisplay();
    }
  }

  void registerCanvas(dom.CanvasRenderingContext2D canvas) {
    this.canvas = canvas;
    canvas.canvas.onMouseEnter.listen(mouseenter);
    canvas.canvas.onMouseLeave.listen(mouseleave);
    canvas.canvas.onClick.listen(mouseclick);
  }

  void reset(bool removeTooltip) {
    this.splist = [];
    if (tooltip != null && removeTooltip) {
      tooltip.remove();
      tooltip = null;
    }
  }

  void mouseclick(e) {
    var clickEvent = $.Event('sparklineClick');
    clickEvent.originalEvent = e;
    clickEvent.sparklines = splist;
    el.trigger(clickEvent);
  }

  void mouseenter(e) {
    dom.document.body.unbind('mousemove.jqs');
    dom.document.body.bind('mousemove.jqs', mousemove);
    over = true;
    currentPageX = e.pageX;
    currentPageY = e.pageY;
    currentEl = e.target;
    if (tooltip == null && displayTooltips) {
        tooltip = new dom.Element.tag('sp-tooltip');
        tooltip.options = _options;
        tooltip.updatePosition(e.pageX, e.pageY);
    }
    this.updateDisplay();
  }

  void mouseleave(e) {
    dom.document.body.unbind('mousemove.jqs');
    var splist = this.splist,
         spcount = splist.length,
         needsRefresh = false,
         sp, i;
    this.over = false;
    this.currentEl = null;

    if (this.tooltip) {
        this.tooltip.remove();
        this.tooltip = null;
    }

    for (i = 0; i < spcount; i++) {
        sp = splist[i];
        if (sp.clearRegionHighlight()) {
            needsRefresh = true;
        }
    }

    if (needsRefresh) {
        this.canvas.render();
    }
  }

  void mousemove(e) {
    this.currentPageX = e.pageX;
    this.currentPageY = e.pageY;
    this.currentEl = e.target;
    if (this.tooltip != null) {
      this.tooltip.updatePosition(e.pageX, e.pageY);
    }
    this.updateDisplay();
  }

  void updateDisplay() {
    var splist = splist,
         spcount = splist.length,
         needsRefresh = false,
         offset = canvas.canvas.offset(),
         localX = currentPageX - offset.left,
         localY = currentPageY - offset.top,
         tooltiphtml, sp, i, result, changeEvent;
    if (!this.over) {
      return;
    }
    for (i = 0; i < spcount; i++) {
      sp = splist[i];
      result = sp.setRegionHighlight(this.currentEl, localX, localY);
      if (result) {
          needsRefresh = true;
      }
    }
    if (needsRefresh) {
      changeEvent = $.Event('sparklineRegionChange');
      changeEvent.sparklines = splist;
      el.trigger(changeEvent);
      if (tooltip != null) {
          tooltiphtml = '';
          for (i = 0; i < spcount; i++) {
              sp = splist[i];
              tooltiphtml += sp.getCurrentRegionTooltip();
          }
          this.tooltip.setContent(tooltiphtml);
      }
      if (!disableHighlight) {
          canvas.render();
      }
    }
    if (result == null) {
        this.mouseleave(null);
    }
  }
}