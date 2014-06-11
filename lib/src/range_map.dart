part of bwu_sparkline;

class RangeMap {
  Map _map;
  List _rangeList;

  RangeMap (Map map) {
    var key, range, rangelist = [];
    for (key in map) {
      if (map.containsKey(key) && key is String && key.indexOf(':') > -1) {
        range = key.split(':');
        range[0] = range[0].length == 0 ? double.NEGATIVE_INFINITY : double.parse(range[0]);
        range[1] = range[1].length == 0 ? double.INFINITY : double.parse(range[1]);
        range[2] = map[key];
        rangelist.add(range);
      }
    }
    _map = map;
    _rangeList = rangelist;
  }

  int get(int value) {
    int i;
    List<int> range;
    int result;
    if ((result = this._map[value]) != null) {
      return result;
    }
    if (_rangeList != null) {
      for (i = _rangeList.length; i--; i > 0) {
        range = _rangeList[i];
        if (range[0] <= value && range[1] >= value) {
          return range[2];
        }
      }
    }
    return null;
  }
}