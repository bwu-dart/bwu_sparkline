library bwu_sparklines.tooltip_options_extended;

import 'dart:collection' as coll;

import 'tooltip_options.dart';
import 'sp_format.dart';

export 'tooltip_options.dart';
export 'sp_format.dart';

class LineChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS :  [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{y}}{{suffix}}')]
  };
}

class BarChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{prefix}}{{value}}{{suffix}}')]
  };
}

class BoxChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('{{field:fields}}: {{value}}')],
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

class BulletChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('{{fieldkey:fields}} - {{value}}')],
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

class DiscreteChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('{{prefix}}{{value}}{{suffix}}')]
  };
}

class PieChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value}} ({{percent.1}}%)')]
  };
}

class TristateChartTooltipOptions extends Tooltip {
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
    Tooltip.FORMATS : [new SPFormat('<span style="color: {{color}}">&#9679;</span> {{value:map}}')],
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
