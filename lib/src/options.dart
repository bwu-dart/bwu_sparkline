part of bwu_sparkline;

/**
 * Default configuration settings
 */

typedef String NumberFormatterFn(String val);

abstract class Options {
  // Settings common to most/all chart types
  String type;
  String lineColor;
  String fillColor;
  int defaultPixelsPerValue;
  String width;
  String height;
  bool composite;
  String tagValuesAttribute;
  String tagOptionsPrefix;
  bool enableTagOptions;
  bool enableHighlight;
  double highlightLighten;
  bool disableHiddenCheck;
  NumberFormatterFn numberFormatter;
  int numberDigitGroupCount;
  String numberDigitGroupSep;
  String numberDecimalMark;
  bool disableTooltips;
  bool disableInteraction;
  //bool disableHighlight;
  TooltipOptions tooltipOptions;

  Options(
    this.type,
    this.lineColor,
    this.fillColor,
    this.defaultPixelsPerValue,
    this.width,
    this.height,
    this.composite,
    this.tagValuesAttribute,
    this.tagOptionsPrefix,
    this.enableTagOptions,
    this.enableHighlight,
    this.highlightLighten,
    this.disableHiddenCheck,
    this.numberFormatter,
    this.numberDigitGroupCount,
    this.numberDigitGroupSep,
    this.numberDecimalMark,
    this.disableTooltips,
    this.disableInteraction
  ) {
    if(type == null) type =  'line';
    if(lineColor == null) lineColor = '#00f';
    if(fillColor == null) fillColor = '#cdf';
    if(defaultPixelsPerValue == null) defaultPixelsPerValue = 3;
    if(width == null) width = 'auto';
    if(height == null) height = 'auto';
    if(composite == null) composite = false;
    if(tagValuesAttribute == null) tagValuesAttribute = 'values';
    if(tagOptionsPrefix == null) tagOptionsPrefix = 'spark';
    if(enableTagOptions == null) enableTagOptions = false;
    if(enableHighlight == null) enableHighlight = true;
    if(highlightLighten == null) highlightLighten = 1.4;
    if(disableHiddenCheck == null) disableHiddenCheck = false;
    //if(numberFormatter == null) numberFormatter =;
    if(numberDigitGroupCount == null) numberDigitGroupCount = 3;
    if(numberDigitGroupSep == null) numberDigitGroupSep = ',';
    if(numberDecimalMark == null) numberDecimalMark = '.';
    if(disableTooltips == null) disableTooltips = false;
    if(disableInteraction == null) disableInteraction = false;
  }

  Options.uninitialized();

  void extend(Options o) {
    if(o.type != null) type = o.type;
    if(o.lineColor != null) lineColor = o.lineColor;
    if(o.fillColor != null) fillColor = o.fillColor;

    if(o.defaultPixelsPerValue != null) defaultPixelsPerValue = o.defaultPixelsPerValue;
    if(o.width != null) width = o.width;
    if(o.height != null) height = o.height;
    if(o.composite != null) composite = o.composite;
    if(o.tagValuesAttribute != null) tagValuesAttribute = o.tagValuesAttribute;
    if(o.tagOptionsPrefix != null) tagOptionsPrefix = o.tagOptionsPrefix;
    if(o.enableTagOptions != null) enableTagOptions = o.enableTagOptions;
    if(o.enableHighlight != null) enableHighlight = o.enableHighlight;
    if(o.highlightLighten != null) highlightLighten = o.highlightLighten;
    if(o.disableHiddenCheck != null) disableHiddenCheck = o.disableHiddenCheck;
    if(o.numberFormatter != null) numberFormatter = o.numberFormatter;
    if(o.numberDigitGroupCount != null) numberDigitGroupCount = o.numberDigitGroupCount;
    if(o.numberDigitGroupSep != null) numberDigitGroupSep = o.numberDigitGroupSep;
    if(o.numberDecimalMark != null) numberDecimalMark = o.numberDecimalMark;
    if(o.disableTooltips != null) disableTooltips = o.disableTooltips;
    if(o.disableInteraction != null) disableInteraction = o.disableInteraction;
  }
}

// Defaults for line charts
class LineOptions extends Options {
  String spotColor;
  String highlightSpotColor;
  String highlightLineColor;
  double spotRadius;
  String minSpotColor;
  String maxSpotColor;
  int lineWidth;
  int normalRangeMin;
  int normalRangeMax;
  String normalRangeColor;
  bool drawNormalOnTop;
  int chartRangeMin;
  int chartRangeMax;
  int chartRangeMinX;
  int chartRangeMaxX;
  LineChartTooltipOptions tooltipOptions;

  LineOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.spotColor : '#f80',
    this.highlightSpotColor : '#5f5',
    this.highlightLineColor : '#f22',
    this.spotRadius : 1.5,
    this.minSpotColor : '#f80',
    this.maxSpotColor : '#f80',
    this.lineWidth : 1,
    this.normalRangeMin,
    this.normalRangeMax,
    this.normalRangeColor : '#ccc',
    this.drawNormalOnTop : false,
    this.chartRangeMin,
    this.chartRangeMax,
    this.chartRangeMinX,
    this.chartRangeMaxX,
    this.tooltipOptions
  }) : super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  LineOptions.uninitialized() : super.uninitialized();

  @override
  void extend(LineOptions o) {
    if(o.spotColor != null) spotColor = o.spotColor;
    if(o.highlightSpotColor != null) highlightSpotColor = o.highlightSpotColor;
    if(o.highlightLineColor != null) highlightLineColor = o.highlightLineColor;
    if(o.spotRadius != null) spotRadius = o.spotRadius;
    if(o.minSpotColor != null) minSpotColor = o.minSpotColor;
    if(o.maxSpotColor != null) maxSpotColor = o.maxSpotColor;
    if(o.lineWidth != null) lineWidth = o.lineWidth;
    if(o.normalRangeMin != null) normalRangeMin = o.normalRangeMin;
    if(o.normalRangeMax != null) normalRangeMax = o.normalRangeMax;
    if(o.normalRangeColor != null) normalRangeColor = o.normalRangeColor;
    if(o.drawNormalOnTop != null) drawNormalOnTop = o.drawNormalOnTop;
    if(o.chartRangeMin != null) chartRangeMin = o.chartRangeMin;
    if(o.chartRangeMax != null) chartRangeMax = o.chartRangeMax;
    if(o.chartRangeMinX != null) chartRangeMinX = o.chartRangeMinX;
    if(o.chartRangeMinX != null) chartRangeMinX = o.chartRangeMinX;
    if(o.chartRangeMaxX != null) chartRangeMaxX = o.chartRangeMaxX;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
    super.extend(o);
  }
}

// Defaults for bar charts
class BarOptions extends Options {
  String barColor;
  String negBarColor;
  List<String> stackedBarColor;
  String zeroColor;
  String nullColor;
  bool zeroAxis;
  int barWidth;
  int barSpacing;
  int chartRangeMax;
  int chartRangeMin;
  bool chartRangeClip;
  int colorMap;
  BarChartTooltipOptions tooltipOptions;

  BarOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.barColor : '#3366cc',
    this.negBarColor : '#f44',
    this.stackedBarColor : const ['#3366cc', '#dc3912', '#ff9900', '#109618', '#66aa00',
        '#dd4477', '#0099c6', '#990099'],
    this.zeroColor,
    this.nullColor,
    this.zeroAxis : true,
    this.barWidth : 4,
    this.barSpacing : 1,
    this.chartRangeMax,
    this.chartRangeMin,
    this.chartRangeClip : false,
    this.colorMap,
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  BarOptions.uninitialized(): super.uninitialized();

  @override
  void extend(BarOptions o) {
    if(o.barColor != null) barColor = o.barColor;
    if(o.negBarColor != null) negBarColor = o.negBarColor;
    if(o.stackedBarColor != null) stackedBarColor = o.stackedBarColor;
    if(o.zeroColor != null) zeroColor = o.zeroColor;
    if(o.nullColor != null) nullColor = o.nullColor;
    if(o.zeroAxis != null) zeroAxis = o.zeroAxis;
    if(o.barWidth != null) barWidth = o.barWidth;
    if(o.barSpacing != null) barSpacing = o.barSpacing;
    if(o.chartRangeMax != null) chartRangeMax = o.chartRangeMax;
    if(o.chartRangeMin != null) chartRangeMin = o.chartRangeMin;
    if(o.chartRangeClip != null) chartRangeClip = o.chartRangeClip;
    if(o.colorMap != null) colorMap = o.colorMap;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}

            // Defaults for tristate charts
class TristateOptions extends Options {
  int barWidth;
  int barSpacing;
  String posBarColor;
  String negBarColor;
  String zeroBarColor;
  Map colorMap;
  TristateChartTooltipOptions tooltipOptions;

  TristateOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.barWidth : 4,
    this.barSpacing : 1,
    this.posBarColor : '#6f6',
    this.negBarColor : '#f44',
    this.zeroBarColor : '#999',
    this.colorMap : const {},
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  TristateOptions.uninitialized(): super.uninitialized();

  @override
  void extend(TristateOptions o) {
    if(o.barWidth != null) barWidth = o.barWidth;
    if(o.barSpacing != null) barSpacing = o.barSpacing;
    if(o.posBarColor != null) posBarColor = o.posBarColor;
    if(o.negBarColor != null) negBarColor = o.negBarColor;
    if(o.zeroBarColor != null) zeroBarColor = o.zeroBarColor;
    if(o.colorMap != null) colorMap = o.colorMap;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}


// Defaults for discrete charts
class DiscreteOptions extends Options {
  String lineHeight;
  String thresholdColor;
  int thresholdValue;
  int chartRangeMax;
  int chartRangeMin;
  bool chartRangeClip;
  DiscreteChartTooltipOptions tooltipOptions;

  DiscreteOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.lineHeight : 'auto',
    this.thresholdColor,
    this.thresholdValue : 0,
    this.chartRangeMax,
    this.chartRangeMin,
    this.chartRangeClip : false,
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  DiscreteOptions.uninitialized(): super.uninitialized();

  @override
  void extend(DiscreteOptions o) {
    if(o.lineHeight != null) lineHeight = o.lineHeight;
    if(o.thresholdColor != null) thresholdColor = o.thresholdColor;
    if(o.thresholdValue != null) thresholdValue = o.thresholdValue;
    if(o.chartRangeMax != null) chartRangeMax = o.chartRangeMax;
    if(o.chartRangeMin != null) chartRangeMin = o.chartRangeMin;
    if(o.chartRangeClip != null) chartRangeClip = o.chartRangeClip;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}

// Defaults for bullet charts
class BulletOptions extends Options {
  String targetColor;
  int targetWidth; // width of the target bar in pixels
  String performanceColor;
  List<String> rangeColors;
  int base; // set this to a number to change the base start number
  BulletChartTooltipOptions tooltipOptions;

  BulletOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.targetColor : '#f33',
    this.targetWidth : 3,
    this.performanceColor : '#33f',
    this.rangeColors : const ['#d3dafe', '#a8b6ff', '#7f94ff'],
    this.base,
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  BulletOptions.unititialized(): super.uninitialized();

  @override
  void extend(BulletOptions o) {
    if(o.targetColor != null) targetColor = o.targetColor;
    if(o.targetWidth != null) targetWidth = o.targetWidth;
    if(o.performanceColor != null) performanceColor = o.performanceColor;
    if(o.rangeColors != null) rangeColors = o.rangeColors;
    if(o.base != null) base = o.base;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}

// Defaults for pie charts
class PieOptions extends Options {
  int offset;
  List<String> sliceColors;
  int borderWidth;
  String borderColor;
  PieChartTooltipOptions tooltipOptions;

  PieOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.offset : 0,
    this.sliceColors : const ['#3366cc', '#dc3912', '#ff9900', '#109618', '#66aa00',
        '#dd4477', '#0099c6', '#990099'],
    this.borderWidth : 0,
    this.borderColor : '#000',
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  PieOptions.uninitialized(): super.uninitialized();

  @override
  void extend(PieOptions o) {
    if(o.offset != null) offset = o.offset;
    if(o.sliceColors != null) sliceColors = o.sliceColors;
    if(o.borderWidth != null) borderWidth = o.borderWidth;
    if(o.borderColor != null) borderColor = o.borderColor;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}

// Defaults for box plots
class BoxOptions extends Options {
  bool raw;
  String boxLineColor;
  String boxFillColor;
  String whiskerColor;
  String outlierLineColor;
  String outlierFillColor;
  String medianColor;
  bool showOutliers;
  double outlierIQR;
  double spotRadius;
  int target;
  String targetColor;
  int chartRangeMax;
  int chartRangeMin;
  BoxChartTooltipOptions tooltipOptions;

  BoxOptions({
    String type,
    String lineColor,
    String fillColor,
    int defaultPixelsPerValue,
    String width,
    String height,
    bool composite,
    String tagValuesAttribute,
    String tagOptionsPrefix,
    bool enableTagOptions,
    bool enableHighlight,
    double highlightLighten,
    bool disableHiddenCheck,
    NumberFormatterFn numberFormatter,
    int numberDigitGroupCount,
    String numberDigitGroupSep,
    String numberDecimalMark,
    bool disableTooltips,
    bool disableInteraction,

    this.raw : false,
    this.boxLineColor : '#000',
    this.boxFillColor : '#cdf',
    this.whiskerColor : '#000',
    this.outlierLineColor : '#333',
    this.outlierFillColor : '#fff',
    this.medianColor : '#f00',
    this.showOutliers : true,
    this.outlierIQR : 1.5,
    this.spotRadius : 1.5,
    this.target,
    this.targetColor : '#4a2',
    this.chartRangeMax,
    this.chartRangeMin,
    this.tooltipOptions
  }): super(
      type,
      lineColor,
      fillColor,
      defaultPixelsPerValue,
      width,
      height,
      composite,
      tagValuesAttribute,
      tagOptionsPrefix,
      enableTagOptions,
      enableHighlight,
      highlightLighten,
      disableHiddenCheck,
      numberFormatter,
      numberDigitGroupCount,
      numberDigitGroupSep,
      numberDecimalMark,
      disableTooltips,
      disableInteraction
  );

  BoxOptions.uninitialized(): super.uninitialized();

  @override
  void extend(BoxOptions o) {
    if(o.raw != null) raw = o.raw;
    if(o.boxLineColor != null) boxLineColor = o.boxLineColor;
    if(o.boxFillColor != null) boxFillColor = o.boxFillColor;
    if(o.whiskerColor != null) whiskerColor = o.whiskerColor;
    if(o.outlierLineColor != null) outlierLineColor = o.outlierLineColor;
    if(o.outlierFillColor != null) outlierFillColor = o.outlierFillColor;
    if(o.medianColor != null) medianColor = o.medianColor;
    if(o.showOutliers != null) showOutliers = o.showOutliers;
    if(o.outlierIQR != null) outlierIQR = o.outlierIQR;
    if(o.spotRadius != null) spotRadius = o.spotRadius;
    if(o.target != null) target = o.target;
    if(o.targetColor != null) targetColor = o.targetColor;
    if(o.chartRangeMax != null) chartRangeMax = o.chartRangeMax;
    if(o.chartRangeMin != null) chartRangeMin = o.chartRangeMin;
    if(o.tooltipOptions != null) tooltipOptions = o.tooltipOptions;
  }
}
