import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTxtFieldStl extends StatelessWidget {
  final String hint;
  final TextEditingController? controllerr;

  ReusableTxtFieldStl({super.key,
  required this.hint,
  this.controllerr
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerr,
      decoration: InputDecoration(
        fillColor: Colors.black.withValues(alpha: 0.06),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        hintStyle: GoogleFonts.rubik(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black.withValues(alpha: 0.12),
        ),
      ),
    );
  }
}
