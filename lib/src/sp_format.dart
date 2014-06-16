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

  String render(Map fields, Map lookups, Options options) {
//    String token;
//    String lookupkey;
//    String fieldvalue;
//    int prec;

    List<Match> matches = new RegExp(fre).allMatches(format).toList();

    String result = format;

    matches.forEach((m) {
      result = result.replaceFirst(m.group(0), fieldValue(format, fields, lookups, options, m));
    });
    return result;
    //return fieldValue(format, fields, lookups, options,  matches);
  }

  String fieldValue(String format, Map fields, Map lookups, Options options, Match matches) {
    var lookup;
    String token = matches.group(1);
    String lookupkey = matches.group(3);
    int prec;

    Match match = new RegExp(precre).firstMatch(token);
    if (match != null) {
      var p = match.group(2);
      if(p == null) {
        prec = null;
      } else {
        prec = int.parse(match.group(2), onError: (_) => null);
        token = match.group(1);
      }
    } else {
      prec = null;
    }
    String fieldvalue = fields[token].toString();
    if (fieldvalue == null) {
      return '';
    }
    if (lookupkey != null && lookups != null && lookups[lookupkey] != null) {
      lookup = lookups[lookupkey];
      if (lookup.get) { // RangeMap
          if(lookups[lookupkey].get(fieldvalue) != null) {
            return lookups[lookupkey].get(fieldvalue);
          }
          return fieldvalue;
      } else {
          if(lookups[lookupkey][fieldvalue] != null) {
            return lookups[lookupkey][fieldvalue];
          }
          return fieldvalue;
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
  }
}
