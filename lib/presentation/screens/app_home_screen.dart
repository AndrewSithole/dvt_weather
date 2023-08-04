import 'dart:convert';
import 'package:dvt_weather/cubit/location_cubit.dart';
import 'package:dvt_weather/cubit/preferences_cubit.dart';
import 'package:intl/intl.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/cubit/weather_cubit.dart';
import 'package:dvt_weather/presentation/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dvt_weather/presentation/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_widgets.dart';

class AppHomeScreen extends StatefulWidget{
  @override
  State<AppHomeScreen> createState() => AppHomeScreenState();
}
class AppHomeScreenState extends State<AppHomeScreen>{
  late WeatherCubit _cubit;

  Color _backgroundColor = appSunnyColor;
  bool _isLoading = false;

  void setAppColors(String weatherStatus){
    Color color = appSunnyColor;
    if(weatherStatus=="cloudy") color = appCloudyColor;
    if(weatherStatus=="rainy") color = appRainyColor;
      _backgroundColor = color;
  }
  @override
  void initState() {
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
      drawer: getDrawer(context),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        bloc: BlocProvider.of<WeatherCubit>(context),
  builder: (context, state) {

          if(state.status == WeatherStatus.success){
            setAppColors(state.weather!.daily.weather.image);
          }
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(image: DecorationImage(
              image:
              AssetImage("assets/images/forest_${BlocProvider.of<PreferencesCubit>(context).state.preferences.homeImage}.png"),
              fit: BoxFit.cover
          )),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: (state.status == WeatherStatus.loading || state.status == WeatherStatus.initial)?
            const SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ):(state.status == WeatherStatus.success)?
            (Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" ${state.weather!.daily.main.temp}°", style: mainTemperatureStyle,),
                Text(state.weather!.daily.weather.main.toUpperCase(), style: mainTemperatureDescriptionStyle,),
                20.height
              ],
            )): Text("An error occurred"),
          ),
        ),
        if(state.status == WeatherStatus.success)
          Padding(
            padding: const EdgeInsets.only(left:15, top: 8, bottom: 8, right: 15),
            child: Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("${state.weather!.daily.main.temp_min}°", style: minMaxTemperatureStyle,),
                    3.height,
                    const Text("min", style: subTitleStyle),
                  ],)
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("${state.weather!.daily.main.temp}°", style: minMaxTemperatureStyle,),
                3.height,
                const Text("current", style: subTitleStyle),
              ],)),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${state.weather!.daily.main.temp_max}°", style: minMaxTemperatureStyle,),
                  3.height,
                  const Text("max", style: subTitleStyle,),
                ],)
              )
            ],
          ),
          ),
        if(state.status == WeatherStatus.success) appDivider(),
        if(state.status == WeatherStatus.success)
          Expanded(child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.weather!.weekly.length,
              itemBuilder: (BuildContext context, int index){
              WeatherObject currentDay = state.weather!.weekly[index];
              return Padding(
                  padding: const EdgeInsets.only(left:15, top:8, bottom: 8, right: 15),
              child: Row(
                children: [
                  Expanded(child: Align(
                    alignment: Alignment.centerLeft,
                      child: Text(DateFormat('EEEE').format(currentDay.date), style: minMaxTemperatureStyle,))),
                  Expanded(child: Center(
                    child: Image(image: AssetImage("assets/icons/${currentDay.weather.icon}")),),
                  ),
                  Expanded(child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("${currentDay.main.temp}°", style: minMaxTemperatureStyle,),
                  )),
                ],
              ),);
              })),
      ],
    );
  },
),
    );
  }
}