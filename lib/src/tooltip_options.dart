part of bwu_sparkline;

class TooltipOptions {
  bool skipNull;
  String prefix;
  String suffix;
  String cssClass;
  dom.HtmlElement container;
  SPFormat format;
  int offsetX;
  int offsetY;

  TooltipOptions({
    this.skipNull : true,
    this.prefix : '',
    this.suffix : '',
    this.cssClass : 'jqstooltip',
    this.container,
    this.format,
    this.offsetX : 10,
    this.offsetY : 12
  });

  TooltipOptions.uninitialized();

  void extend(TooltipOptions o) {
    if(o.skipNull != null) skipNull = o.skipNull;
    if(o.prefix != null) prefix = o.prefix;
    if(o.suffix != null) suffix = o.suffix;
    if(o.cssClass != null) cssClass = o.cssClass;
    if(o.container != null) container = o.container;
    if(o.format != null) format = o.format;
    if(o.offsetX != null) offsetX = o.offsetX;
    if(o.offsetY != null) offsetY = o.offsetY;
  }
}

class LineChartTooltipOptions extends TooltipOptions {
  LineChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    int offsetX,
    int offsetY
  })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format =  new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{y}}{{suffix}}');
    }
  }

  LineChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(LineChartTooltipOptions o) => super.extend(o);
}

class BarChartTooltipOptions extends TooltipOptions {
  BarChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format = new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{value}}{{suffix}}');
    }
  }

  BarChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(BarChartTooltipOptions o) => super.extend(o);
}

class BoxChartTooltipOptions extends TooltipOptions {
  Map valueLookups;
  String formatFieldlistKey;

  BoxChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    Map valueLookups,
    String formatFieldlistKey,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format = new SPFormat('{{field:fields}}: {{value}}');
    }

    if(this.valueLookups == null) {
      this.valueLookups = { 'fields': { 'lq': 'Lower Quartile', 'med': 'Median',
        'uq': 'Upper Quartile', 'lo': 'Left Outlier', 'ro': 'Right Outlier',
        'lw': 'Left Whisker', 'rw': 'Right Whisker'} };
    }

    if(this.formatFieldlistKey == null) {
      this.formatFieldlistKey = 'field';
    }
  }

  BoxChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(BoxChartTooltipOptions o) {
    if(o.valueLookups != null) valueLookups = o.valueLookups;
    if(o.formatFieldlistKey != null) formatFieldlistKey = o.formatFieldlistKey;
    super.extend(o);
  }
}

class BulletChartTooltipOptions extends TooltipOptions {
  Map valueLookups;

  BulletChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    Map valueLookups,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY
      ) {
    if(this.format == null) {
      this.format = new SPFormat('{{fieldkey:fields}} - {{value}}');
    }

    if(this.valueLookups == null) {
      this.valueLookups = { 'map': { '-1': 'Loss', '0': 'Draw', '1': 'Win' } };
    }
  }

  BulletChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(BulletChartTooltipOptions o) {
    if(o.valueLookups != null) valueLookups = o.valueLookups;
    super.extend(o);
  }
}

class DiscreteChartTooltipOptions extends TooltipOptions {
  DiscreteChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format =  new SPFormat('{{prefix}}{{value}}{{suffix}}');
    }
  }

  DiscreteChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(DiscreteChartTooltipOptions o) => super.extend(o);
}

class PieChartTooltipOptions extends TooltipOptions {
  PieChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format = new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value}} ({{percent.1}}%)');
    }
  }

  PieChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(PieChartTooltipOptions o) => super.extend(o);
}

class TristateChartTooltipOptions extends TooltipOptions {
  Map valueLookups;

  TristateChartTooltipOptions({
    bool skipNull,
    String prefix,
    String suffix,
    String cssClass,
    dom.HtmlElement container,
    SPFormat format,
    Map valueLookups,
    int offsetX,
    int offsetY
    })
  : super(
      skipNull: skipNull,
      prefix: prefix,
      suffix: suffix,
      cssClass: cssClass,
      container: container,
      format: format,
      offsetX: offsetX,
      offsetY: offsetY) {
    if(this.format == null) {
      this.format = new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value:map}}');
    }

    if(this.valueLookups == null) {
      this.valueLookups = { 'map': { '-1': 'Loss', '0': 'Draw', '1': 'Win' } };
    }
  }

  TristateChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void extend(TristateChartTooltipOptions o) {
    if(o.valueLookups != null) valueLookups = o.valueLookups;
    super.extend(o);
  }
}

