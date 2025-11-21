import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // biar status bar icon putih
      child: ListView(
        padding: EdgeInsets.zero, // 🔥 penting agar tidak ada jarak ke atas
        children: [
          // HEADER menyatu dengan status bar
          Container(
            padding: EdgeInsets.fromLTRB(
              w * 0.05,
              h * 0.05,
              w * 0.05,
              h * 0.025,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C8EF9), Color(0xFF7755E1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LOGO + ICON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: h * 0.05,
                        width: w * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: h * 0.02,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          SizedBox(width: w * 0.03),
                          CircleAvatar(
                            radius: h * 0.02,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),

                  // TEKS HELLO
                  Container(
                    width: w * 0.40,
                    height: h * 0.025,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: h * 0.010),
                  Container(
                    width: w * 0.55,
                    height: h * 0.02,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: h * 0.020),

                  // BOX TANYA MEDIGO
                  Container(
                    width: double.infinity,
                    height: h * 0.11,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.025),

          // MENU FITUR
          SizedBox(
            height: h * 0.13,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, __) {
                    return Container(
                      width: w * 0.23,
                      margin: EdgeInsets.only(right: w * 0.04),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: w * 0.085,
                            backgroundColor: Colors.grey.shade300,
                          ),
                          SizedBox(height: w * 0.015),
                          Container(
                            width: w * 0.18,
                            height: h * 0.015,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: w * 0.010),
                          Container(
                            width: w * 0.15,
                            height: h * 0.015,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          // KALENDER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: w * 0.045,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      Spacer(),
                      Container(
                        width: w * 0.40,
                        height: h * 0.020,
                        color: Colors.grey.shade300,
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: w * 0.045,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),

                  SizedBox(
                    height: h * 0.12,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (_, __) {
                        return Container(
                          width: w * 0.20,
                          margin: EdgeInsets.symmetric(horizontal: w * 0.017),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(18),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.03),

          // TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Row(
                children: [
                  Container(
                    width: w * 0.45,
                    height: h * 0.02,
                    color: Colors.grey.shade300,
                  ),
                  Spacer(),
                  Container(
                    width: w * 0.30,
                    height: h * 0.015,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          // LIST DOKTER
          Column(
            children: List.generate(
              4,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: h * 0.12,
                    margin: EdgeInsets.symmetric(horizontal: w * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
