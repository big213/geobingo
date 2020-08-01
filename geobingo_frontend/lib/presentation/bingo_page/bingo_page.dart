import 'package:flutter/material.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/header.dart';
import 'package:geobingo_frontend/presentation/bingo_page/components/tiles.dart';

class BingoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BingoPageState();
  }
}

class BingoPageState extends State<BingoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 1, child: HeaderComponent()),
            Positioned(bottom: 1, child: Tiles()),
          ],
        ),
      ),
    );
  }
}
