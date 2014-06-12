part of bwu_sparkline;

typedef String TooltipFormatterFn(BwuSparkline, Options options, Map fields);

class TooltipOptions extends OptionsBase {
  static const SKIP_NULL = 'skipNull';
  static const PREFIX = 'prefix';
  static const SUFFIX = 'suffix';
  static const CSS_CLASS = 'cssClass';
  static const CONTAINER = 'container';
  static const FORMATS = 'formats';
  static const OFFSET_X = 'offsetX';
  static const OFFSET_Y = 'offsetY';
  static const FORMATTER = 'formatter';

  TooltipOptions() : super();
  TooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    SKIP_NULL,
    PREFIX,
    SUFFIX,
    CSS_CLASS,
    CONTAINER,
    FORMATS,
    OFFSET_X,
    OFFSET_Y,
    FORMATTER
  ];

  final Map _defaults = {
    SKIP_NULL : true,
    PREFIX : '',
    SUFFIX : '',
    CSS_CLASS : 'jqstooltip',
    OFFSET_X : 10,
    OFFSET_Y : 12
  };

  bool get skipNull => _v[SKIP_NULL];
  set skipNull(bool val) => _v[SKIP_NULL];

  String get prefix => _v[PREFIX];
  set prefix(String val) => _v[PREFIX];

  String get suffix => _v[SUFFIX];
  set suffix(String val) => _v[SUFFIX];

  String get cssClass => _v[CSS_CLASS];
  set cssClass(String val) => _v[CSS_CLASS];

  dom.HtmlElement get container => _v[CONTAINER];
  set container(dom.HtmlElement val) => _v[CONTAINER];

  List<SPFormat> get formats => _v[FORMATS];
  set formats(List<SPFormat> val) => _v[FORMATS];

  int get offsetX => _v[OFFSET_X];
  set offsetX(int val) => _v[OFFSET_X];

  int get offsetY => _v[OFFSET_Y];
  set offsetY(int val) => _v[OFFSET_Y];

  TooltipFormatterFn get formatter => _v[FORMATTER];
  set formatter(TooltipFormatterFn val) => _v[FORMATTER];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }

}

class LineChartTooltipOptions extends TooltipOptions {
  LineChartTooltipOptions() : super();
  LineChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
  ];

  final Map _defaults = {
    TooltipOptions.FORMATS :  [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{y}}{{suffix}}')]
  };
}

class BarChartTooltipOptions extends TooltipOptions {
  BarChartTooltipOptions() : super();
  BarChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
  ];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{value}}{{suffix}}')]
  };
}

class BoxChartTooltipOptions extends TooltipOptions {
  static const VALUE_LOOKUPS = 'valueLookups';
  static const FORMAT_FIELDLIST_KEY = 'formatFieldlistKey';
  static const FORMAT_FIELDLIST = 'formatFieldlist';

  BoxChartTooltipOptions() : super();
  BoxChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    VALUE_LOOKUPS,
    FORMAT_FIELDLIST_KEY,
    FORMAT_FIELDLIST
  ];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('{{field:fields}}: {{value}}')],
    VALUE_LOOKUPS : { 'fields': { 'lq': 'Lower Quartile', 'med': 'Median',
        'uq': 'Upper Quartile', 'lo': 'Left Outlier', 'ro': 'Right Outlier',
        'lw': 'Left Whisker', 'rw': 'Right Whisker'} },
    FORMAT_FIELDLIST_KEY : 'field'
  };

  Map get valueLookups => _v[VALUE_LOOKUPS];
  set valueLookups(Map val) => _v[VALUE_LOOKUPS] = val;

  String get formatFieldlistKey => _v[FORMAT_FIELDLIST_KEY];
  set formatFieldlistKey(String val) => _v[FORMAT_FIELDLIST_KEY] = val;

  List<String> get formatFieldlist => _v[FORMAT_FIELDLIST];
  set formatFieldlist(List<String> val) => _v[FORMAT_FIELDLIST] = val;

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

class BulletChartTooltipOptions extends TooltipOptions {
  static const VALUE_LOOKUPS = 'valueLookups';

  BulletChartTooltipOptions() : super();
  BulletChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [VALUE_LOOKUPS];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('{{fieldkey:fields}} - {{value}}')],
    VALUE_LOOKUPS : { 'fields': {'r': 'Range', 'p': 'Performance', 't': 'Target'} }
  };

  Map get valueLookups => _v[VALUE_LOOKUPS];
  set valueLookups(Map val) => _v[VALUE_LOOKUPS] = val;

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

class DiscreteChartTooltipOptions extends TooltipOptions {
  DiscreteChartTooltipOptions() : super();
  DiscreteChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('{{prefix}}{{value}}{{suffix}}')]
  };
}

class PieChartTooltipOptions extends TooltipOptions {
  PieChartTooltipOptions() : super();
  PieChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value}} ({{percent.1}}%)')]
  };
}

class TristateChartTooltipOptions extends TooltipOptions {
  static const VALUE_LOOKUPS = 'valueLookups';

  TristateChartTooltipOptions() : super();
  TristateChartTooltipOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [VALUE_LOOKUPS];

  final Map _defaults = {
    TooltipOptions.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value:map}}')],
    VALUE_LOOKUPS : { 'map': { '-1': 'Loss', '0': 'Draw', '1': 'Win' } }
  };

  Map get valueLookups => _v[VALUE_LOOKUPS];
  set valueLookups(Map val) => _v[VALUE_LOOKUPS] = val;

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}
