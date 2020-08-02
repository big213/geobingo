import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geobingo_frontend/data/location.dart';
import 'package:geobingo_frontend/data/tile.dart';
import 'package:geobingo_frontend/data/tiles.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/hero_tile.dart';
import 'package:geobingo_frontend/presentation/map_page/map_page.dart';
import 'package:geolocator/geolocator.dart';

class TilesComponent extends StatefulWidget {
  final List<Tile> tiles;
  Location position;
  TilesComponent({this.tiles, this.position});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TilesState();
  }
}

class TilesState extends State<TilesComponent> {
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
    List<Widget> rows = List.generate(5, (_) {
      var heroTile = HeroTile(
        globalIndexValue: globalIndex,
        id: widget.tiles[globalIndex].id,
        placeName: widget.tiles[globalIndex].placeName,
        placeID: widget.tiles[globalIndex].placeID,
        userPosition: widget.position,
      );
      globalIndex++;
      return heroTile;
    });
    return rows;
  }
}
