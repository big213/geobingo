class Tile {
  int id;
  String placeName;
  String placeID;
  int position;

  Tile({this.id, this.placeName, this.position, this.placeID});

  factory Tile.fromJson(Map<String, dynamic> json) {
    return Tile(
        id: json['id'],
        placeName: json['place_name'],
        placeID: json['place'],
        position: json['position']);
  }
}
