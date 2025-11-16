import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';

class ImageAdjustScreen extends StatefulWidget {
  const ImageAdjustScreen({super.key});

  @override
  State<ImageAdjustScreen> createState() => _ImageAdjustScreenState();
}

class _ImageAdjustScreenState extends State<ImageAdjustScreen> {
  late File imageFile;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is File) {
      imageFile = arg;
    } else if (arg is String) {
      imageFile = File(arg);
    } else {
      throw Exception('ImageAdjustScreen expects a File or file path.');
    }
  }

  Future<void> _showCropAlert() async {
    // Tampilkan alert sebelum mulai crop
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Perhatikan Sebelum Crop",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF7134FC),
          ),
        ),
        content: const Text(
          "Harap sesuaikan bingkai hanya pada area kulit yang terdampak penyakit jamur.",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7134FC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Lanjutkan",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
              _cropImage(); // lanjut ke crop setelah user klik "Lanjutkan"
            },
          ),
        ],
      ),
    );
  }

  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Gambar',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
          activeControlsWidgetColor: const Color(0xFF7134FC),
        ),
        IOSUiSettings(title: 'Crop Gambar'),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Sesuaikan Gambar"),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 3,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildAction(Icons.crop, "Crop", _showCropAlert)],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF7134FC),
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text(
          "Gunakan Gambar",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Get.back(result: imageFile);
        },
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onTap,
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
