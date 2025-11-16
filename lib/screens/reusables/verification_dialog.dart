import 'package:flutter/material.dart';

class VerificationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String gifAssetPath;
  final VoidCallback? onOkPressed;
  final VoidCallback? onDetailPressed;

  const VerificationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gifAssetPath,
    this.onOkPressed,
    this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(gifAssetPath, height: 100),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) onOkPressed!();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Ganti Email', style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onDetailPressed != null) onDetailPressed!();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Color(0xFF7134FC), width: 1.5),
                ),
              ),
              child: Text(
                'Lakukan verifikasi',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showFailedDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String gifAssetPath,
  VoidCallback? onOkPressed,
  VoidCallback? onDetailPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Failed Dialog',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink(); // Diperlukan tetapi tidak digunakan
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scale = Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack));
      return Transform.scale(
        scale: scale.value,
        child: Opacity(
          opacity: animation.value,
          child: VerificationDialog(
            title: title,
            subtitle: subtitle,
            gifAssetPath: gifAssetPath,
            onOkPressed: onOkPressed,
            onDetailPressed: onDetailPressed,
          ),
        ),
      );
    },
  );
}
