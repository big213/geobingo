import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TilesState();
  }
}

class TilesState extends State<Tiles> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = generateRow();
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
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: [
              TableRow(children: [...rows]),
              TableRow(children: [...rows]),
              TableRow(children: [...rows]),
              TableRow(children: [...rows]),
              TableRow(children: [...rows])
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateRow() {
    List<Widget> rows = List.generate(5, (index) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          width: 20,
          height: 20,
          child: Icon(Icons.ac_unit),
        ),
      );
    });
    return rows;
  }
}
