import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPopup extends StatefulWidget {
  const LoadingPopup({super.key});

  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Color(0xFF7134FC), Color(0xFF3E8DF4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn, // menjaga bentuk animasi
          child: SpinKitCubeGrid(
            color: Colors.white, // tetap gunakan warna solid
            size: 50.0,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
