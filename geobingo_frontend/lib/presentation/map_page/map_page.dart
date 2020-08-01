import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    String tag = args['tag'];
    return Container(
      child: Hero(
        tag: '$tag',
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
