import 'package:excelsior_admin/Services/Models/customer_model.dart';
import 'package:excelsior_admin/Services/API/secrets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';

class SalesControllers with ChangeNotifier {
  Future<CustomerModel?> getCustomerDetails(String customerID) async {
    CustomerModel? customer;
    final pb = PocketBase(Secrets.regularConstant);
    await pb.collection('CUSTOMER_VIEW').getOne(customerID).then((value) {
      final List contracts = value.data['Contracts'] as List;
      customer = CustomerModel(
          customerID: value.id,
          name: value.data['Name'],
          email: value.data['email'],
          phone: value.data['Phone'],
          pidNumber: value.data['PID_Number'],
          licenseNumber: value.data['License_Number'],
          address: value.data['Address'],
          contracts: contracts);
    });
    return customer;
  }

  //Utility Methods
  String normalizeDateFromAPI(String sourceDate) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    DateTime dateTime = DateTime.parse(sourceDate);
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  String normalizeTimeFromAPI(String sourceDate) {
    DateFormat timeFormat = DateFormat("HH:mm");
    DateTime dateTime = DateTime.parse(sourceDate);
    String formattedTime = timeFormat.format(dateTime);
    return formattedTime;
  }
}
