import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/home/schedule_practice_controller.dart';
import 'package:sim_klinik_mobile/screens/features/models/home/schedule/poli_model.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/home/poli_name_card.dart';
import 'package:sim_klinik_mobile/screens/reusables/custom_header.dart';

class PilihPoliScreen extends StatefulWidget {
  const PilihPoliScreen({super.key});

  @override
  State<PilihPoliScreen> createState() => _PilihPoliScreenState();
}

class _PilihPoliScreenState extends State<PilihPoliScreen> {
  final _controller = Get.find<SchedulePracticeController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Column(
        children: [
          CustomHeader(title: "Jadwal Praktek"),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.03,
                ),
                itemCount: _controller.listPoli.length,
                itemBuilder: (context, index) {
                  final poli = _controller.listPoli[index];
                  return PoliCard(
                    poli: poli,
                    color: poli.color!,
                    onTap: () {
                      debugPrint("Klik: ${poli.nama}");
                    },
                    height: screenHeight * 0.11, // proporsional dengan layar
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
