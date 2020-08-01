import 'package:flutter/material.dart';
import 'package:geobingo_frontend/presentation/bingo_page/bingo_page.dart';

import 'presentation/map_page/map_page.dart';

void main() {
  runApp(MaterialApp(
    routes: {'/second': (context) => MapPage()},
    home: Scaffold(body: BingoPage()),
  ));
}
