import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:tksmart/model/user_model.dart';
import 'package:tksmart/utility/my_api.dart';
import 'package:tksmart/utility/my_style.dart';

class ShowListAdminAll extends StatefulWidget {
  final UserModel userModel;
  ShowListAdminAll({Key key, this.userModel}) : super(key: key);
  @override
  _ShowListAdminAllState createState() => _ShowListAdminAllState();
}

class _ShowListAdminAllState extends State<ShowListAdminAll> {
  UserModel userModel;
  double lat, lng, lat1, lng1, lat2, lng2, distance;
  String distanceString;
  CameraPosition position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLat1Lng1();
  }

  Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse(userModel.lat);
      lng2 = double.parse(userModel.lng);
    });
    print('lat1 = $lat1, lng1 = $lng1, lat2 = $lat2, lng2 = $lng2');
    distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

    var myFormat = NumberFormat('#0.0#', 'en_US');
    distanceString = myFormat.format(distance);

    print('distance = $distance');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
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
      body: Container(
        child: Column(
          children: [
            lat1 == null ? MyStyle().showProgress() : showMap(),
          ],
        ),
      ),
    );
  }

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng1);
      position = CameraPosition(
        target: latLng1,
        zoom: 16.0,
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

    Marker shopMarker() {
      return Marker(
        markerId: MarkerId('shopMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
        infoWindow: InfoWindow(title: userModel.nameShop),
      );
    }

    Set<Marker> mySet(){
      return <Marker>[userMarker(),shopMarker()].toSet();
    }

    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      height: 250.0,
      child: lat1 == null
          ? MyStyle().showProgress()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) => {},markers: mySet(),
            ),
    );
  }
}
