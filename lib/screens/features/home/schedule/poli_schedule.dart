import 'package:flutter/material.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/schedule/poli_model.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/home/poli_name_card.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class PilihPoliScreen extends StatefulWidget {
  const PilihPoliScreen({super.key});

  @override
  State<PilihPoliScreen> createState() => _PilihPoliScreenState();
}

class _PilihPoliScreenState extends State<PilihPoliScreen> {
  final List<PoliModel> poliSchedules = [
    PoliModel(
      imagePath: "assets/icons/ic_poli_umum.png",
      namaPoli: "Poli Umum",
      color: const Color(0xFFFFC720),
    ),
    PoliModel(
      imagePath: "assets/icons/ic_poli_gigi.png",
      namaPoli: "Poli Gigi",
      color: const Color(0xFF2088FF),
    ),
    PoliModel(
      imagePath: "assets/icons/ic_poli_ibu_dan_anak.png",
      namaPoli: "Poli Ibu dan Anak",
      color: const Color(0xFF18B300),
    ),
    PoliModel(
      imagePath: "assets/icons/ic_poli_gizi.png",
      namaPoli: "Poli Gizi",
      color: const Color(0xFFE27C00),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Jadwal Praktek"),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.03,
              ),
              itemCount: poliSchedules.length,
              itemBuilder: (context, index) {
                final poli = poliSchedules[index];
                return PoliCard(
                  poli: poli,
                  color: poli.color,
                  onTap: () {
                    debugPrint("Klik: ${poli.namaPoli}");
                  },
                  height: screenHeight * 0.11, // proporsional dengan layar
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
