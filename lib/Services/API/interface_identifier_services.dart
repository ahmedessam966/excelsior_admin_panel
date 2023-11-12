import 'package:excelsior_admin/Sales/core/sales_core.dart';
import 'package:excelsior_admin/screen_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_services.dart';

class InterfaceIdentifierServices with ChangeNotifier {
  Future<Widget> getNativeCredentials(BuildContext context) async {
    final authProvider = Provider.of<AuthenticationServices>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') == null) {
      authProvider.setUserType('');
      return Future.value(const LoginScreen());
    } else {
      final String email = prefs.getString('email') as String;
      final String secret = prefs.getString('secret') as String;
      switch (prefs.getString('userType')) {
        case 'Sales':
          await authProvider.staffAuth(email, secret);
          return Future.value(const SalesCore());
        case 'IT':
          await authProvider.staffAuth(email, secret);
          return Future.value(const InformationTechnologyScreen());
        case 'Marketing':
          await authProvider.staffAuth(email, secret);
          return Future.value(const MarketingScreen());
        case 'Procurement':
          await authProvider.staffAuth(email, secret);
          return Future.value(const ProcurementsScreen());
        case 'Facilities':
          await authProvider.staffAuth(email, secret);
          return Future.value(const FacilitiesScreen());
        case 'Accounting':
          await authProvider.staffAuth(email, secret);
          return Future.value(const AccountingScreen());
        case 'Public Relations':
          await authProvider.staffAuth(email, secret);
          return Future.value(const PublicRelationsScreen());
        case 'Legal':
          await authProvider.staffAuth(email, secret);
          return Future.value(const LegalScreen());
        default:
          return Future.value(const LoginScreen());
      }
    }
  }
}
