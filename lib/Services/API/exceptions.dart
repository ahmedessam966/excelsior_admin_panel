import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class AuthExceptions {
  static Future exceptionController(BuildContext context, int statusCode) {
    switch (statusCode) {
      case 400:
        return Flushbar(
          title: 'Invalid email or password',
          titleColor: Colors.red,
          message: 'Please check the email or password entered (Error 400)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);
      case 404:
        return Flushbar(
          title: 'Error',
          titleColor: Colors.red,
          message: 'The repository could not be found (Error 404)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);

      case 403:
        return Flushbar(
          title: 'Insufficient Privilege',
          titleColor: Colors.red,
          message: 'You do not have an access permission for this operation (Error 403)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);

      case 408:
        return Flushbar(
          title: 'Connection Error',
          titleColor: Colors.red,
          message: 'Request time out. Please check your connection and try again (Error 408)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);

      case 0:
        return Flushbar(
          title: 'Connection Error',
          titleColor: Colors.red,
          message: 'Could not establish connection to server (Error 0)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);

      default:
        return Flushbar(
          title: 'Unknown Error',
          titleColor: Colors.red,
          message: 'Unexcpected error (Error 500)',
          duration: const Duration(seconds: 7),
          mainButton: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: context.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
        ).show(context);
    }
  }
}
