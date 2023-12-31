import 'package:excelsior_admin/Sales/Features/new_contract/Widgets/insufficient_privilege_flush.dart';
import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class InfoTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const InfoTextFieldWidget({super.key, required this.controller, required this.title});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthenticationServices>(context, listen: false);
    return TextFormField(
      onTap: () {
        provider.privilegeLevel > 4
            ? PrivilegeExceptionWidgets.insufficientPrivilege(
                context, 'Insufficient Privilege', 'Higher privilege level required to edit this information')
            : null;
      },
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        suffix: Text(title),
        filled: true,
        hintText: title,
        hintStyle: context.displaySmall?.copyWith(color: Colors.grey),
        fillColor: Colors.grey.shade300,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
