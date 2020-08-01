import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroTile extends StatefulWidget {
  final int globalIndexValue;

  HeroTile({Key key, this.globalIndexValue}) : super(key: key);

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
        Navigator.pushNamed(context, '/second',
            arguments: {"tag": "tag_${widget.globalIndexValue}"});
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
