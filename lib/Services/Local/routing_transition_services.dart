// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class RoutingTransitionServices {
  static Route Transition(page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        const curve = Curves.fastOutSlowIn;

        // final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      },
    );
  }
}
