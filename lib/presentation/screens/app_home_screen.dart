import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dvt_weather/utils/colors.dart';
import 'package:http/http.dart' as http;

class AppHomeScreen extends StatefulWidget{
  @override
  State<AppHomeScreen> createState() => AppHomeScreenState();
}
class AppHomeScreenState extends State<AppHomeScreen>{
  Color _backgroundColor = appSunnyColor;
  bool _isLoading = false;
  String _topImage = "assets/images/forest_sunny.png";
  void setLoading(bool loading){
    setState(() {
      _isLoading = loading;
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  getWeatherData(String lat, String lon) async {
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=f16b5b11d45fae7731e545ca034d3b44");
    setLoading(true);
    try {
      await http.post(url,body:jsonEncode({})).then((response) async {
        debugPrint(response.body);
        var res = jsonDecode(response.body);
        if (response.statusCode != 200 || res["success"] == false) {
        }else{

        }
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  getData(){
    _determinePosition().then((value){
      getWeatherData(value.latitude.toString(), value.longitude.toString());
    }).catchError((error){
      // ToDo: Show error here
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: _backgroundColor),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage(_topImage),
                fit: BoxFit.cover
              )),
            )
          ],
        ),
      ),
    );
  }
}