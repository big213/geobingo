import 'package:geobingo_frontend/data/location.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:geobingo_frontend/data/tiles.dart';
import 'package:http/http.dart' as http;
import 'package:geobingo_frontend/main.dart';

class TileRequest {
  Client client = http.Client();

  Future<Tiles> getAllTiles(Location location) async {
    var body = {
      "action": "addBingoRound",
      "query": {
        "id": null,
        "name": null,
        "bingoTiles": {
          "data": {
            "id": null,
            "isCompleted": null,
            "place": null,
            "place_name": null,
            "position": null
          },
          "__args": {
            "sortBy": ["position"],
            "sortDesc": [false]
          }
        },
        "__args": {
          "name": "Some Bingo Round2",
          "length": 25,
          "latitude": location.lat,
          "longitude": location.long
        }
      }
    };

    var encoder = JsonEncoder();
    var bodyInString = encoder.convert(body);
    var client = http.Client();
    var resp = await client.post(
        "https://us-central1-geobingo-bd1a6.cloudfunctions.net/api/jql",
        body: bodyInString,
        headers: {
          "Content-Type": "application/json",
        });
    var jsonData = await json.decode(resp.body);
    Tiles tiles = Tiles.fromJson(jsonData["data"]["bingoTiles"]['data']);
    client.close();
    return tiles;
  }
}
