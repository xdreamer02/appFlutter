import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  latLngBounds(double ltA, double lgA, double ltB, double lgB) {
    dynamic slt, slg;
    dynamic nlt, nlg;

    if (ltA <= ltB) {
      slt = ltA;
      nlt = ltB;
    } else {
      slt = ltB;
      nlt = ltA;
    }
    if (lgA <= lgB) {
      slg = lgA;
      nlg = lgB;
    } else {
      slg = lgB;
      nlg = lgA;
    }
    return LatLngBounds(
        northeast: LatLng(nlt, nlg), southwest: LatLng(slt, slg));
  }
}
