library bwu_sparkline.tooltip_options;

import 'dart:html' as dom;
import 'dart:collection' as coll;

import 'options_base.dart';
import 'options.dart';
import 'sp_format.dart';

typedef String TooltipFormatterFn(BwuSparkline, Options options, List<Map> fields);

class Tooltip extends OptionsBase {
  static const SKIP_NULL = 'skipNull';
  static const PREFIX = 'prefix';
  static const SUFFIX = 'suffix';
  static const CSS_CLASS = 'cssClass';
  static const CONTAINER = 'container';
  static const FORMATS = 'formats';
  static const OFFSET_X = 'offsetX';
  static const OFFSET_Y = 'offsetY';
  static const FORMATTER = 'formatter';
  static const CHART_TITLE = 'chartTitle';

  Tooltip() : super();
  Tooltip.uninitialized() : super.uninitialized();

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
    FORMATTER,
    CHART_TITLE
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

  String get chartTitle => _v[CHART_TITLE];
  set chartTitle(String val) => _v[CHART_TITLE];

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

