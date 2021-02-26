import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/PicError.png",
                width: 130,
                height: 130,),
            Container(
              height: 20,
            ),
            Text('Opss... \n'
                'Al parecer hemos tenido dificultades para cargar esta sección, por favor ten paciencia, estamos trabajando en ello.',
                textAlign: TextAlign.center,
                style: GoogleFonts.signika(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal
                )),
          ],
        ),
      ),
    );
  }
}
