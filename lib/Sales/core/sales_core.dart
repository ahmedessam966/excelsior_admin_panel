import 'package:excelsior_admin/Sales/Features/dashboard/Views/sales_screen.dart';
import 'package:excelsior_admin/Sales/core/providers.dart';
import 'package:excelsior_admin/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesCore extends StatelessWidget {
  const SalesCore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModeServices()),
        ChangeNotifierProvider(create: (_) => SalesControllers()),
        ChangeNotifierProvider(create: (_) => SalesDashboardControllers()),
        ChangeNotifierProvider(create: (_) => NewContractControllers()),
        ChangeNotifierProvider(create: (_) => SalesTransactionsController()),
        ChangeNotifierProvider(create: (_) => Styles()),
      ],
      builder: (context, child) {
        final themeNotifier = context.watch<ThemeModeServices>();
        final themeConstants = context.watch<Styles>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Excelsior | Sales Module',
          themeMode: themeNotifier.selectedTheme,
          theme: themeNotifier.selectedTheme == ThemeMode.light
              ? themeConstants.lightTheme
              : themeConstants.darkTheme,
          home: const SalesScreen(),
        );
      },
    );
  }
}
