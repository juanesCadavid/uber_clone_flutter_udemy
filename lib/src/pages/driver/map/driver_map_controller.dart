import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapController{
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _mapController = Completer();
  CameraPosition initialPosition = CameraPosition(target: LatLng(6.258929, -75.602109),zoom: 14.0);
  
  Future init(BuildContext context){
    this.context = context;
  }

  void onMapCreate(GoogleMapController controller){
    _mapController.complete(controller);
  }

}