import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sim_klinik_mobile/controllers/base/dashboard_controller.dart';
import 'package:sim_klinik_mobile/screens/features/home/dashboard/dashboard_content.dart';
import 'package:sim_klinik_mobile/screens/features/widgets/shimmer/dashboard_shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F0FB),
      body: Obx(() {
        return _controller.isLoading.value
            ? const DashboardShimmer()
            : DashboardContent(data: _controller.data);
      }),
    );
  }
}
