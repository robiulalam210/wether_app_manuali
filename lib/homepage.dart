import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    wetherData();
    // TODO: implement initState
    super.initState();
  }

  Map<String, dynamic>? wetherMap;
  Map<String, dynamic>? forecastMap;

  wetherData() async {
    var wether =
        "https://api.openweathermap.org/data/2.5/weather?lat=23.790552&lon=90.391769&units=metric&appid=f92bf340ade13c087f6334ed434f9761&fbclid=IwAR0d_W5adDcsxUjpUXS39o645QTXRJHXxASukjhSBstOzGPJGUk1-ZP5xf0";
    var forecast =
        "https://api.openweathermap.org/data/2.5/forecast?lat=23.790552&lon=90.391769&units=metric&appid=f92bf340ade13c087f6334ed434f9761&fbclid=IwAR0d_W5adDcsxUjpUXS39o645QTXRJHXxASukjhSBstOzGPJGUk1-ZP5xf0";

    var recponce_wether = await http.get(Uri.parse(wether));
    var recponce_forecast = await http.get(Uri.parse(forecast));

    setState(() {
      wetherMap = Map<String, dynamic>.from(jsonDecode(recponce_wether.body));
      forecastMap =
          Map<String, dynamic>.from(jsonDecode(recponce_forecast.body));
      print("ppppppppppppppppp $wetherMap");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: wetherMap != null
          ? Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(4),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue,
                              Colors.blueGrey,
                              Colors.lightGreen
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03),
                                          Text(
                                            "${wetherMap!["name"]}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          Text(
                                            "${Jiffy(DateTime.now()).format("MMM do yy, h:mm:a")}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            // padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    maxRadius: 40,
                                    backgroundImage: NetworkImage(
                                        "http://openweathermap.org/img/wn/02d@2x.png"),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                Text(
                                  " ${wetherMap!["weather"][0]["description"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  "${wetherMap!["main"]["temp"]} °",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "🤒Feels_like ${wetherMap!["main"]["feels_like"]}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      "Humidity ${wetherMap!["main"]["humidity"]}, Pressure ${wetherMap!["main"]["pressure"]}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                      " ‍🌫️Sunrise ${Jiffy(DateTime.fromMillisecondsSinceEpoch(wetherMap!["sys"]["sunrise"] * 1000))
                                          .format("h:mm:a")},⭐ Sunset ${Jiffy(DateTime.fromMillisecondsSinceEpoch(wetherMap!
                                      ["sys"]["sunset"] * 1000)).format("h:mm:a")}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecastMap!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                          "${Jiffy(forecastMap!["list"][index]["dt_txt"]).format("EEE,h:mm:a")}"),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Image.network(
                                          "http://openweathermap.org/img/wn/10d@2x.png"),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Text(
                                        "${forecastMap!["list"][index]["weather"][0]["main"]}",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
