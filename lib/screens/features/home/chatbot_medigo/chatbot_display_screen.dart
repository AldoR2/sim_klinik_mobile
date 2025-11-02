import 'package:flutter/material.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class DisplayChatMedigoScreen extends StatelessWidget {
  DisplayChatMedigoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Tanya MediGo"),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
