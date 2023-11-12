import 'package:another_flushbar/flushbar.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivilegeExceptionWidgets {
  static Future insufficientPrivilege(BuildContext context, String title, String message) {
    return Flushbar(
      title: title,
      message: message,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      mainButton: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Make Request',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ).show(context);
  }
}
