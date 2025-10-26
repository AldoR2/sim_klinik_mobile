import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.only(top: 80),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {},
                  child: Text("Create Account"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
