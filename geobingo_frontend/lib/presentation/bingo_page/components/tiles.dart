import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/hero_tile.dart';
import 'package:geobingo_frontend/presentation/map_page/map_page.dart';

class Tiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TilesState();
  }
}

class TilesState extends State<Tiles> {
  int globalIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 480,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Center(
          child: Table(
            children: [
              TableRow(children: [...generateRow()]),
              TableRow(children: [...generateRow()]),
              TableRow(children: [...generateRow()]),
              TableRow(children: [...generateRow()]),
              TableRow(children: [...generateRow()])
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateRow() {
    List<Widget> rows = List.generate(5, (index) {
      globalIndex++;
      return HeroTile(
        globalIndexValue: globalIndex,
      );
    });
    return rows;
  }
}
