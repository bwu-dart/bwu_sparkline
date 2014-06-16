library app_element;

import 'package:polymer/polymer.dart';

import 'package:bwu_sparkline/bwu_sparkline.dart';

@CustomTag('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @observable List values;
  @observable Options dynamicbarOptions;
  @observable Options inlinebarOptions;

  @override
  void attached() {
    super.attached();

    try {
      values = [10,8,5,7,4,4,1];
      // The options for the dynamicbar chart.
      dynamicbarOptions = new BarOptions()..barColor = 'green';

      // The options for the inlinebar chart.
      inlinebarOptions = new BarOptions()..barColor = 'red';

    } on NoSuchMethodError catch (e) {
      print('simple - app-element - attached: $e\n\n${e.stackTrace}');
    }  on RangeError catch (e) {
      print('simple - app-element - attached: $e\n\n${e.stackTrace}');
    } on TypeError catch(e) {
      print('simple - app-element - attached: $e\n\n${e.stackTrace}');
    } catch(e, s) {
      print('simple - app-element - attached: $e\n\n${s}');
    }
  }
}