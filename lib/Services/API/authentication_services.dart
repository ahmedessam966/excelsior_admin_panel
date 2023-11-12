import 'package:excelsior_admin/Services/Models/staff_model.dart';
import 'package:excelsior_admin/Services/API/secrets.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices with ChangeNotifier {
  StaffModel? _staffModel;
  StaffModel? get staffModel => _staffModel;

  String _userDepartment = '';
  String get userDepartment => _userDepartment;

  int _privilegeLevel = 0;
  int get privilegeLevel => _privilegeLevel;

  Future<int> staffAuth(String email, String password) async {
    final pb = PocketBase(Secrets.regularConstant);
    try {
      await pb
          .collection('StaffAuth')
          .authWithPassword(email.toLowerCase().trim(), password)
          .then((value) async {
        final record = value.record;

        final Uri imageURL = pb.files.getUrl(record!, record.data['Image']);

        _staffModel = StaffModel(
            staffID: record.id,
            name: record.data['Name'],
            email: record.data['email'],
            department: record.data['Department'],
            phone: record.data['Phone'],
            gender: record.data['Gender'],
            dob: record.data['Date_Of_Birth'],
            position: record.data['Department'],
            salary: record.data['Salary'],
            pidNumber: record.data['PID_Number'],
            privilegeLevel: record.data['Privilege_Level'],
            profileImage: imageURL.path);

        _userDepartment = record.data['Department'];
        _privilegeLevel = record.data['Privilege_Level'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('secret', password);
        prefs.setString('userType', record.data['Department']);
        prefs.setInt('privilege', record.data['Privilege_Level']);
        notifyListeners();
      });
      return 200;
    } on ClientException catch (e) {
      return e.statusCode;
    }
  }

  void setUserType(String type) {
    _userDepartment = type;
    notifyListeners();
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final pb = PocketBase(Secrets.regularConstant);
    pb.authStore.clear();
  }
}
