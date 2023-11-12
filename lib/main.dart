import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Future.delayed(
    const Duration(seconds: 2),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationServices()),
        ChangeNotifierProvider(create: (_) => InterfaceIdentifierServices()),
        ChangeNotifierProvider(create: (_) => ThemeModeServices()),
        ChangeNotifierProvider(create: (_) => SalesControllers()),
        ChangeNotifierProvider(create: (_) => Styles()),
      ],
      builder: (context, _) {
        final themeNotifier = context.watch<ThemeModeServices>();
        final themeConstants = context.watch<Styles>();
        final interface = Provider.of<InterfaceIdentifierServices>(context, listen: false);

        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Excelsior',
              themeMode: themeNotifier.selectedTheme,
              theme: themeNotifier.selectedTheme == ThemeMode.light
                  ? themeConstants.lightTheme
                  : themeConstants.darkTheme,
              home: Builder(
                builder: (context) {
                  return EasySplashScreen(
                      logo: Image.asset('assets/images/excelsior-color-transparent.png'),
                      durationInSeconds: 6,
                      logoWidth: 50.w,
                      futureNavigator: interface.getNativeCredentials(context));
                },
              ),
            );
          },
        );
      },
    );
  }
}
