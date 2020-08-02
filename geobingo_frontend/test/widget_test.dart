// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geobingo_frontend/data/tiles.dart';
import 'package:http/http.dart' as http;
import 'package:geobingo_frontend/main.dart';

void main() {
  // test("Testing API", () async {
  //   var body = {
  //     "action": "addBingoRound",
  //     "query": {
  //       "id": null,
  //       "name": null,
  //       "bingoTiles": {
  //         "data": {
  //           "id": null,
  //           "isCompleted": null,
  //           "place": null,
  //           "place_name": null,
  //           "position": null
  //         },
  //         "__args": {
  //           "sortBy": ["position"],
  //           "sortDesc": [false]
  //         }
  //       },
  //       "__args": {
  //         "name": "Some Bingo Round2",
  //         "length": 25,
  //         "latitude": 40.78382,
  //         "longitude": -73.97779
  //       }
  //     }
  //   };

  //   var encoder = JsonEncoder();
  //   var bodyInString = encoder.convert(body);
  //   var client = http.Client();
  //   var resp = await client.post(
  //       "https://us-central1-geobingo-bd1a6.cloudfunctions.net/api/jql",
  //       body: bodyInString,
  //       headers: {
  //         "Content-Type": "application/json",
  //       });
  //   var jsonData = json.decode(resp.body);
  //   print(jsonData['data']['bingoTiles']);
  //   Tiles tiles = Tiles.fromJson(jsonData["data"]["bingoTiles"]['data']);
  //   tiles.tile.forEach((element) {
  //     print(element.placeName);
  //   });
  // });
}
