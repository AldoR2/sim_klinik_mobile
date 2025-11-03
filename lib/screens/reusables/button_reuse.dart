import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonReuse extends StatelessWidget {
  final void Function()? function;
  final String text;

  const ButtonReuse({super.key, this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2088FF), Color(0xff7134FC)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xff7134FC),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width, 40),
            alignment: Alignment.center,
          ),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Color(0xff7134FC), Color(0xff2088FF)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
            ),
          ),
        ),
      ),
    );
  }
}
