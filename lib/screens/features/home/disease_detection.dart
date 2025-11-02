import 'package:flutter/material.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class DeteksiPenyakitScreen extends StatelessWidget {
  DeteksiPenyakitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Deteksi Penyakit"),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
