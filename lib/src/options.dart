library bwu_sparkline.options;

import 'dart:collection' as coll;

import 'options_base.dart';
import 'options_extended.dart';
import 'tooltip_options_extended.dart';

export 'options_base.dart';

/**
 * Default configuration settings
 */

typedef String NumberFormatterFn(String val);

const String BAR_TYPE = 'bar';
const String BOX_TYPE = 'box';
const String BULLET_TYPE = 'bullet';
const String DISCRETE_TYPE = 'discrete';
const String LINE_TYPE = 'line';
const String PIE_TYPE = 'pie';
const String TRISTATE_TYPE = 'tristate';


abstract class Options extends OptionsBase {
  factory Options.forType([String type]) {
    switch(type) {
      case BAR_TYPE:
        return new BarOptions();
      case BOX_TYPE:
        return new BoxOptions();
      case BULLET_TYPE:
        return new BulletOptions();
      case DISCRETE_TYPE:
        return new DiscreteOptions();
      case LINE_TYPE:
        return new LineOptions();
      case PIE_TYPE:
        return new PieOptions();
      case TRISTATE_TYPE:
        return new TristateOptions();
      default:
        return new LineOptions();
    }
  }

  // Settings common to most/all chart types

  static const TYPE = 'type';
  static const LINE_COLOR = 'lineColor';
  static const FILL_COLOR ='fillColor';
  static const DEFAULT_PIXELS_PER_VALUE = 'defaultPixelsPerValue';
  static const WIDTH ='width'; // null is 'auto'
  static const HEIGHT = 'height'; // null is 'auto'
  static const COMPOSITE = 'composite';
  static const TAG_VALUES_ATTRIBUTE = 'tagValuesAttribute';
  static const TAG_OPTIONS_PREFIX = 'tagOptionsPrefix';
  static const ENABLE_TAG_OPTIONS = 'enableTagOptions';
  static const ENABLE_HIGHLIGHT = 'enableHighlight';
  static const HIGHLIGHT_COLOR = 'highlightColor';
  static const HIGHLIGHT_LIGHTEN = 'highlightLighten';
  static const DISABLE_HIDDEN_CHECK = 'disableHiddenCheck';
  static const NUMBER_FORMATTER = 'numberFormatter';
  static const NUMBER_DIGIT_GROUP_COUNT = 'numberDigitGroupCount';
  static const NUMBER_DIGIT_GROUP_SEP = 'numberDigitGroupSep';
  static const NUMBER_DECIMAL_MARK = 'numberDecimalMark';
  static const DISABLE_TOOLTIPS = 'disableTooltips';
  static const DISABLE_INTERACTIONS = 'disableInteraction';
  static const TOOLTIP = 'tooltip';

  Options() : super();
  Options.uninitialized() : super.uninitialized();

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
       TYPE,
       LINE_COLOR,
       FILL_COLOR,
       DEFAULT_PIXELS_PER_VALUE,
       WIDTH,
       HEIGHT,
       COMPOSITE,
       TAG_VALUES_ATTRIBUTE,
       TAG_OPTIONS_PREFIX,
       ENABLE_TAG_OPTIONS,
       ENABLE_HIGHLIGHT,
       HIGHLIGHT_COLOR,
       HIGHLIGHT_LIGHTEN,
       DISABLE_HIDDEN_CHECK,
       NUMBER_FORMATTER,
       NUMBER_DIGIT_GROUP_COUNT,
       NUMBER_DIGIT_GROUP_SEP,
       NUMBER_DECIMAL_MARK,
       DISABLE_TOOLTIPS,
       DISABLE_INTERACTIONS,
       TOOLTIP
       ];

  final Map _defaults = {
    TYPE: LINE_TYPE,
    LINE_COLOR : '#00f',
    FILL_COLOR : '#cdf',
    DEFAULT_PIXELS_PER_VALUE : 3,
    COMPOSITE : false,
    TAG_VALUES_ATTRIBUTE : 'values',
    TAG_OPTIONS_PREFIX : 'spark',
    ENABLE_TAG_OPTIONS : false,
    ENABLE_HIGHLIGHT : true,
    HIGHLIGHT_LIGHTEN : 1.4,
    DISABLE_HIDDEN_CHECK : false,
    NUMBER_DIGIT_GROUP_COUNT : 3,
    NUMBER_DIGIT_GROUP_SEP : ',',
    NUMBER_DECIMAL_MARK : '.',
    DISABLE_TOOLTIPS : false,
    DISABLE_INTERACTIONS : false,
  };

  String get type => _v[TYPE];
  //set type(String val) => _v[TYPE] = val;

  String get lineColor => _v[LINE_COLOR];
  set lineColor(String val) => _v[LINE_COLOR] = val;

  String get fillColor => _v[FILL_COLOR];
  set fillColor(String val) => _v[FILL_COLOR] = val;

  int get defaultPixelsPerValue => _v[DEFAULT_PIXELS_PER_VALUE];
  set defaultPixelsPerValue(int val) => _v[DEFAULT_PIXELS_PER_VALUE] = val;

  int get width => _v[WIDTH]; // null is 'auto'
  set width(int val) => _v[WIDTH] = val; // null is 'auto'

  int get height => _v[HEIGHT]; // null is 'auto'
  set height(int val) => _v[HEIGHT] = val; // null is 'auto'

  bool get composite => _v[COMPOSITE];
  set composite(bool val) => _v[COMPOSITE] = val;

  String get tagValuesAttribute => _v[TAG_VALUES_ATTRIBUTE];
  set tagValuesAttribute(String val) => _v[TAG_VALUES_ATTRIBUTE] = val;

  String get tagOptionsPrefix => _v[TAG_OPTIONS_PREFIX];
  set tagOptionsPrefix(String val) => _v[TAG_OPTIONS_PREFIX] = val;

  bool get enableTagOptions => _v[ENABLE_TAG_OPTIONS];
  set enableTagOptions(bool val) => _v[ENABLE_TAG_OPTIONS] = val;

  bool get enableHighlight => _v[ENABLE_HIGHLIGHT];
  set enableHighlight(bool val) => _v[ENABLE_HIGHLIGHT] = val;

  String get highlightColor => _v[HIGHLIGHT_COLOR];
  set highlightColor(String val) => _v[HIGHLIGHT_COLOR] = val;

  double get highlightLighten => _v[HIGHLIGHT_LIGHTEN];
  set highlightLighten(double val) => _v[HIGHLIGHT_LIGHTEN] = val;

  bool get disableHiddenCheck => _v[DISABLE_HIDDEN_CHECK];
  set disableHiddenCheck(bool val) => _v[DISABLE_HIDDEN_CHECK] = val;

  NumberFormatterFn get numberFormatter => _v[NUMBER_FORMATTER];
  set numberFormatter(NumberFormatterFn val) => _v[NUMBER_FORMATTER] = val;

  int get numberDigitGroupCount => _v[NUMBER_DIGIT_GROUP_COUNT];
  set numberDigitGroupCount(int val) => _v[NUMBER_DIGIT_GROUP_COUNT] = val;

  String get numberDigitGroupSep => _v[NUMBER_DIGIT_GROUP_SEP];
  set numberDigitGroupSep(String val) => _v[NUMBER_DIGIT_GROUP_SEP] = val;

  String get numberDecimalMark => _v[NUMBER_DECIMAL_MARK];
  set numberDecimalMark(String val) => _v[NUMBER_DECIMAL_MARK] = val;

  bool get disableTooltips => _v[DISABLE_TOOLTIPS];
  set disableTooltips(bool val) => _v[DISABLE_TOOLTIPS] = val;

  bool get disableInteraction => _v[DISABLE_INTERACTIONS];
  set disableInteraction(bool val) => _v[DISABLE_INTERACTIONS] = val;

  Tooltip get tooltip => _v[TOOLTIP];
  set tooltip(Tooltip val) => _v[TOOLTIP] = val;

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


