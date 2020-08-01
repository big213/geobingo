import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * .49,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xff06BCC1)),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 30,
            child: Text("GEOBINGO", style: GoogleFonts.poppins(fontSize: 35.0)),
          ),
        ],
      ),
    );
  }
}
