library bwu_sparklines.sp_format;

import 'dart:html' as dom;

import 'package:bwu_sparklines/bwu_sparkline.dart';
import 'package:bwu_sparklines/src/utilities.dart';

/**
 * Wraps a format string for tooltips
 * {{x}}
 * {{x.2}
 * {{x:months}}
 */
class SPFormat {
  String fre = r'\{\{([\w.]+?)(:(.+?))?\}\}'; ///g,
  String precre = r'(\w+)\.(\d+)';
  String format;
  String fclass;
  SPFormat(this.format, [this.fclass]);

  void render(Map fields, Map lookups, Options options) {
    Match match;
    String token;
    String lookupkey;
    String fieldvalue;
    int prec;

    return this.format.replace(this.fre, () {
      var lookup;
      token = arguments[1];
      lookupkey = arguments[3];
      match = precre.exec(token);
      if (match != null) {
        prec = match[2];
        token = match[1];
      } else {
        prec = null;
      }
      fieldvalue = fields[token];
      if (fieldvalue == null) {
        return '';
      }
      if (lookupkey != null && lookups != null && lookups[lookupkey] != null) {
        lookup = lookups[lookupkey];
        if (lookup.get) { // RangeMap
            return lookups[lookupkey].get(fieldvalue) || fieldvalue;
        } else {
            return lookups[lookupkey][fieldvalue] || fieldvalue;
        }
      }
      if (isNumber(fieldvalue)) {
        if (options.numberFormatter != null) {
          fieldvalue = options.numberFormatter(fieldvalue);
        } else {
          fieldvalue = formatNumber(fieldvalue, prec,
              options.numberDigitGroupCount,
              options.numberDigitGroupSep,
              options.numberDecimalMark);
        }
      }
      return fieldvalue;
    });
  }
}
