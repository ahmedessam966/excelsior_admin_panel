import 'package:excelsior_admin/Sales/Features/dashboard/Widgets/dashboard_body_widget.dart';
import 'package:excelsior_admin/Sales/Features/dashboard/Widgets/vertical_navbar.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 8, child: DashboardBodyWidget()),
          Expanded(flex: 2, child: VerticalNavbar()),
        ],
      ),
    );
  }
}
