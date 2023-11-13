import 'package:excelsior_admin/Services/API/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageViewer extends StatelessWidget {
  final String imagePath;
  const ProfileImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 400.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: FadeInImage.assetNetwork(
        placeholder: 'Profile',
        fit: BoxFit.contain,
        image: '${Secrets.regularConstant}$imagePath',
        fadeInDuration: const Duration(seconds: 2),
        fadeOutDuration: const Duration(seconds: 2),
      ),
    );
  }
}
