import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/logic/cubit/weather_cubit.dart';
import 'package:dvt_weather/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dvt_weather/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class AppHomeScreen extends StatefulWidget{
  @override
  State<AppHomeScreen> createState() => AppHomeScreenState();
}
class AppHomeScreenState extends State<AppHomeScreen>{
  late WeatherCubit _cubit;

  Color _backgroundColor = appSunnyColor;
  bool _isLoading = false;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    debugPrint("Getting location");

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
    try{
      Position location = await Geolocator.getCurrentPosition();
    }catch(error){
      debugPrint("an error occurred");
    }
    Position location = await Geolocator.getCurrentPosition();
    debugPrint("Now loc");

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return location;
  }
  _getWeatherData(){
    debugPrint("Weather data");
    try{
      determinePosition().then((value){
        debugPrint("Weather data - ${value.longitude}");

        BlocProvider.of<WeatherCubit>(context).fetchWeather(value);
        BlocProvider.of<WeatherCubit>(context).fetchWeather(value);
      });
    }catch(error){
      debugPrint("An error occurred" + error.toString());
    }

  }
  void setAppColors(String weatherStatus){
    Color color = appSunnyColor;
    if(weatherStatus=="cloudy") color = appCloudyColor;
    if(weatherStatus=="rainy") color = appRainyColor;
    setStatusBarColor(color, statusBarIconBrightness: Brightness.light);
      _backgroundColor = color;
  }
  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }
  Divider appDivider({Color color = Colors.white}) {
    return Divider(
      height: 1,
      color: color,
      thickness: 1,
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        leading: IconButton(icon: Icon(Icons.menu), iconSize: 30, onPressed: () {  },),// Status bar color
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        bloc: BlocProvider.of<WeatherCubit>(context),
  builder: (context, state) {
          if(state is! WeatherInitial && state is! WeatherLoading){
            setAppColors(state.weather!.daily.weather.image);
          }
    return Container(
        decoration: BoxDecoration(color: _backgroundColor),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(image: DecorationImage(
                  image: (state is WeatherInitial || state is WeatherLoading)?
                  AssetImage("assets/images/sea_sunny.png"):
                  AssetImage("assets/images/sea_${state.weather!.daily.weather.image}.png"),
                  fit: BoxFit.cover
              )),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: (state is WeatherInitial || state is WeatherLoading)?
                const Center(child: Text("Loading")):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${state.weather!.daily.main.temp}°", style: mainTemperatureStyle,),
                    Text(state.weather!.daily.weather.main.toUpperCase(), style: mainTemperatureDescriptionStyle,)
                  ],
                ),
              ),
            ),
            if(state is WeatherSuccess)
              Padding(
                padding: EdgeInsets.only(left:10, top: 8, bottom: 8),
                child: Row(
                children: [
                  Expanded(child: Center(
                    child: Column(children: [
                      Text("${state.weather!.daily.main.temp_min}°", style: minMaxTemperatureStyle,),
                      3.height,
                      const Text("min", style: subTitleStyle),
                    ],),
                  )),
                  Expanded(child: Center(
                    child: Column(children: [
                      Text("${state.weather!.daily.main.temp}°", style: minMaxTemperatureStyle,),
                      3.height,
                      const Text("current", style: subTitleStyle),
                    ],),
                  )),
                  Expanded(child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Text("${state.weather!.daily.main.temp_max}°", style: minMaxTemperatureStyle,),
                      3.height,
                      const Text("max", style: subTitleStyle,),
                    ],),
                  ))
                ],
              ),
              ),
            if(state is WeatherSuccess) appDivider(),
            if(state is WeatherSuccess)
              Expanded(child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.weather!.weekly.length,
                  itemBuilder: (BuildContext context, int index){
                  WeatherObject currentDay = state.weather!.weekly[index];
                  return Padding(
                      padding: EdgeInsets.only(left:10, top:8, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(child: Text(DateFormat('EEEE').format(currentDay.date), style: minMaxTemperatureStyle,)),
                      Expanded(child: Center(
                        child: Image(image: AssetImage("assets/icons/${currentDay.weather.icon}")),),
                      ),
                      Expanded(child: Center(
                        child: Text("${currentDay.main.temp}°", style: minMaxTemperatureStyle,),
                      )),
                    ],
                  ),);
                  })),
          ],
        ),
      );
  },
),
    );
  }
}