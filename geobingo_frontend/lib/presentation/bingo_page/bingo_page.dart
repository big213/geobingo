import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radar_io/flutter_radar_io.dart';
import 'package:geobingo_frontend/data/location.dart';
import 'package:geobingo_frontend/data/repository/data_provider/tiles_request.dart';
import 'package:geobingo_frontend/data/tiles.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/header.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/tiles_component.dart';
import 'package:permission_handler/permission_handler.dart';

class BingoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BingoPageState();
  }
}

class BingoPageState extends State<BingoPage> {
  Tiles tiles;
  TileRequest tilesRequest;
  Location locat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tilesRequest = TileRequest();
    locat = Location();
    locat.lat = 40.78382;
    locat.long = -73.97779;
  }

  Future<void> initRadar() async {
    try {
      await Permission.locationAlways.request();
    } on PlatformException {
      print('There has been an error');
    }
    await FlutterRadarIo.initialize(
        publishableKey: 'prj_test_sk_e303aec5227d9fa0425f041b41be3815a81f3103');
    await FlutterRadarIo.startTracking(
        preset: FlutterRadarIo.TRACKING_PRESET_CONTINUOUS);
  }

  @override
  Widget build(BuildContext context) {
    initRadar();
    // TODO: implement build
    return FutureBuilder(
      future: tilesRequest.getAllTiles(locat),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 1, child: HeaderComponent()),
                  Positioned(
                      bottom: 1,
                      child: TilesComponent(
                        tiles: snapshot.data.tile,
                        position: locat,
                      )),
                ],
              ),
            ),
          );
        }
        return Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
