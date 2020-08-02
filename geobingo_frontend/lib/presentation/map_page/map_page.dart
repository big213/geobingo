import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_io/flutter_radar_io.dart';
import 'package:geobingo_frontend/data/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rich_alert/rich_alert.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  GoogleMapController googleMapController;
  Completer<GoogleMapController> _controller;
  Set<Marker> markers;
  Set<Circle> circles;
  Map<dynamic, dynamic> geofences;
  String name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Completer();
    geofences = {};
    markers = {};
    circles = {};
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FlutterRadarIo.stopTracking();
  }

  var heroIcon = Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(
          (0xffCADF9E),
        )),
    margin: EdgeInsets.only(top: 30, left: 12, right: 12),
    width: 50,
    height: 50,
    child: Icon(Icons.ac_unit),
  );

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String tag = args['tag'];
    Location position = args['position'];
    name = args['name'];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xffCADF9E)),
        child: Hero(
          tag: '$tag',
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: GestureDetector(
                  child: heroIcon,
                  onTap: () {
                    if (geofences.length != 0 && circles.length > 0) {
                      showDialog(
                          useRootNavigator: true,
                          routeSettings: RouteSettings(name: "/first"),
                          context: context,
                          builder: (BuildContext context) {
                            return RichAlertDialog(
                              //uses the custom alert dialog
                              alertTitle: richTitle("Congratulation"),
                              alertSubtitle: richSubtitle(
                                  "You found the place and unlocked the tile $name"),
                              alertType: RichAlertType.SUCCESS,
                            );
                          });
                    }
                  },
                ),
                top: 10,
              ),
              Center(
                child: FutureBuilder(
                  future: Future.delayed(Duration(milliseconds: 300)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (_controller.isCompleted) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 100),
                          child: GoogleMap(
                              circles: circles,
                              buildingsEnabled: true,
                              markers: markers,
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(position.lat, position.long),
                                  zoom: 15.0)),
                        );
                      }
                      return Container(
                        height: 300,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 200,
                                child: RaisedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _controller.complete();
                                    });
                                    try {
                                      FlutterRadarIo.trackOnce(
                                        callBack: (
                                            {location,
                                            radarEvents,
                                            radarStatus,
                                            radarUser}) async {
                                          print('callback executing');
                                          position.lat = location['latitude'];
                                          position.long = location['longitude'];
                                          print([radarUser["geofences"]]);
                                          radarUser['geofences'].forEach((geo) {
                                            var center =
                                                geo['geometry']['center'];
                                            var lat = center['latitude'];
                                            var long = center['longitude'];
                                            var radious =
                                                geo['geometry']['radius'];
                                            circles.add(Circle(
                                                circleId: CircleId("cir"),
                                                center: LatLng(lat, long),
                                                fillColor:
                                                    Colors.lightGreenAccent,
                                                radius: radious));
                                          });
                                          setState(() {
                                            geofences = radarUser;

                                            markers.add(Marker(
                                                markerId: MarkerId("f"),
                                                icon: BitmapDescriptor
                                                    .defaultMarker,
                                                position: LatLng(position.lat,
                                                    position.long),
                                                infoWindow: InfoWindow(
                                                    title: "Your position")));
                                          });
                                          print(
                                              "Radar events are: $radarEvents");
                                        },
                                      );
                                    } on Exception {
                                      print('There has been an error');
                                    }
                                  },
                                  child: Text("Open Map"),
                                ),
                              ),
                              Text(
                                "To reveal this tile you must now space travel to a mistical place. ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
