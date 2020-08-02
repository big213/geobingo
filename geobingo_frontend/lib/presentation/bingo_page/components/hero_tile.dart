import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geobingo_frontend/data/location.dart';
import 'package:geolocator/geolocator.dart';

class HeroTile extends StatefulWidget {
  final int globalIndexValue;
  int id;
  String placeName;
  String placeID;
  int position;
  Location userPosition;

  HeroTile(
      {Key key,
      this.globalIndexValue,
      this.id,
      this.placeID,
      this.placeName,
      this.userPosition,
      this.position})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HeroTileState();
  }
}

class HeroTileState extends State<HeroTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/second', arguments: {
          "tag": "tag_${widget.globalIndexValue}",
          "position": widget.userPosition,
          "name": widget.placeName
        });
      },
      child: Hero(
        tag: 'tag_${widget.globalIndexValue}',
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(
                (0xffCADF9E),
              )),
          margin: EdgeInsets.only(top: 30, left: 12, right: 12),
          width: 20,
          height: 50,
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
