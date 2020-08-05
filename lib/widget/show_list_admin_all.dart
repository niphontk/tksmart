import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tksmart/model/user_model.dart';
import 'package:tksmart/utility/my_api.dart';
import 'package:tksmart/utility/my_constant.dart';
import 'package:tksmart/utility/my_style.dart';
import 'package:tksmart/utility/normal_dialog.dart';

class ShowListAdminAll extends StatefulWidget {
  @override
  _ShowListAdminAllState createState() => _ShowListAdminAllState();
}

class _ShowListAdminAllState extends State<ShowListAdminAll> {
  UserModel userModel;
  double lat1, lng1, lat2, lng2, distance;
  String distanceString;
  CameraPosition position;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url =
        '${MyConstant().domain}/tksmart/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        lat2 = double.parse(userModel.lat);
        lng2 = double.parse(userModel.lng);
        findLat1Lng1();
      }
    });
  }

  Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;

      print('lat1 = $lat1, lng2 = $lng1, lat2 = $lat2, lng2 = $lng2');

      distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

      var myFormat = NumberFormat('#0.0#', 'en_US');
      distanceString = myFormat.format(distance);

      print('distance = $distanceString');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Time'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyStyle().showTitleH2(
                      'คุณอยู่ห่างจากสำนักงาน $distanceString กิโลเมตร'),
                ],
              ),
              showMap(),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng2);
      position = CameraPosition(
        target: latLng1,
        zoom: 15.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('userMarker'),
        position: LatLng(lat1, lng1),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow: InfoWindow(title: 'คุณอยู่ที่นี่'),
      );
    }

    Marker officeMarker() {
      return Marker(
        markerId: MarkerId('officeMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
        infoWindow: InfoWindow(title: 'สำนักงาน'),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), officeMarker()].toSet();
    }

    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 18.0),
      height: 250.0,
      child: lat1 == null
          ? MyStyle().showProgress()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mySet(),
            ),
    );
  }

  Widget saveButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            if (distance < 0.30) {
              normalDialog(context, 'อยู่ในเขตสำนักงาน Check In ได้');
            } else {
              normalDialog(context, 'อยู่นอกเขตสำนักงาน Check In ไม่ได้');
            }
          },
          child: Text(
            'Check In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
