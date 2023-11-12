// ignore_for_file: non_constant_identifier_names

class InputValidationServices {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateAPI({required String? API}) {
    if (API == null) {
      return null;
    }

    if (API.isEmpty) {
      return 'API username can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return 'Password can\'t be empty';
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'At least 8 characters required';
    }

    return null;
  }

  static String? validateNum({required String? Number}) {
    if (Number == null) {
      return null;
    }
    if (Number.toString().isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  static String? validateGender({required int? GenderValue}) {
    if (GenderValue == null) {
      return null;
    }
    if (GenderValue == 0) {
      return null;
    }
    if (GenderValue != 1 || GenderValue != 2) {
      return 'Required Field';
    }
    return null;
  }
}
