import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTxtFieldStl extends StatelessWidget {
  final String hint;
  final TextEditingController? controllerr;
  final Widget? suffix;
  final bool? obscureText;

  ReusableTxtFieldStl({
    super.key,
    required this.hint,
    this.controllerr,
    this.suffix,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerr,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        fillColor: Colors.black.withValues(alpha: 0.06),
        filled: true,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withValues(alpha: 12),
            strokeAlign: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
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
