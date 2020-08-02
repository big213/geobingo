import 'package:geobingo_frontend/data/tile.dart';

class Tiles {
  List<Tile> tile;

  Tiles({this.tile});

  factory Tiles.fromJson(List<dynamic> json) {
    return Tiles(
        tile:
            List<Tile>.from(json.map((tile) => Tile.fromJson(tile)).toList()));
  }
}
