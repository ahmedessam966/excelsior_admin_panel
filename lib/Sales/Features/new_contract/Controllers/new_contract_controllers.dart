import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../Services/API/secrets.dart';
import '../../../../Services/Models/car_model.dart';
import '../../../../Services/Models/customer_model.dart';

class NewContractControllers with ChangeNotifier {
  int _contractStep = 0;
  int get contractStep => _contractStep;

  final List<CustomerModel> _customerSearchResults = [];
  List<CustomerModel> get customerSearchResults => _customerSearchResults;
  final List _duplicateCustomers = [];

  final List<CarModel> _carSearchResults = [];
  List<CarModel> get carSearchResults => _carSearchResults;
  final List _duplicateCars = [];

  final TextEditingController _resultController = TextEditingController();
  TextEditingController get resultController => _resultController;

  final TextEditingController _carResultController = TextEditingController();
  TextEditingController get carResultController => _carResultController;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;

  final TextEditingController _pidController = TextEditingController();
  TextEditingController get pidController => _pidController;

  final TextEditingController _customerID = TextEditingController();
  TextEditingController get customerID => _customerID;

  final TextEditingController _addressController = TextEditingController();
  TextEditingController get addressController => _addressController;

  void changeContractStep(int newValue) {
    _contractStep = newValue;
    notifyListeners();
  }

  void setResultController(String value) {
    _resultController.text = value;
    notifyListeners();
  }

  void setCarResultController(String value) {
    _carResultController.text = value;
    notifyListeners();
  }

  void setResults(String name, String phone, String address, String pid, String id) {
    _nameController.text = name;
    _phoneController.text = phone;
    _addressController.text = address;
    _pidController.text = pid;
    _customerID.text = id;
    notifyListeners();
  }

  Future searchForCustomer(String searchText) async {
    _customerSearchResults.clear();
    _duplicateCustomers.clear();
    final pb = PocketBase(Secrets.regularConstant);
    await pb.collection('CUSTOMER_VIEW').getList(filter: 'email ~ "$searchText"').then((value) {
      for (final child in value.items) {
        if (_duplicateCustomers.contains(child.id)) {
          return;
        } else {
          _duplicateCustomers.add(child.id);
          final result = CustomerModel(
              customerID: child.id,
              name: child.data['Name'],
              email: child.data['email'],
              phone: child.data['Phone'],
              pidNumber: child.data['PID_Number'],
              licenseNumber: child.data['License_Number'],
              address: child.data['Address'],
              contracts: child.data['Contracts'] as List);
          _customerSearchResults.add(result);
        }
      }
    });
  }

  Future searchForCar(String searchText) async {
    final pb = PocketBase(Secrets.regularConstant);
    await pb
        .collection('CARS_VIEW')
        .getList(filter: 'isRented = false && (Make ~ "$searchText" || Model ~ "$searchText")')
        .then((value) {
      for (final child in value.items) {
        if (_duplicateCars.contains(child.id)) {
          return;
        } else {
          _duplicateCars.add(child.id);
          final car = CarModel(
              carID: child.id,
              plates: child.data['License_Plate'],
              make: child.data['Make'],
              model: child.data['Model'],
              color: child.data['Color'],
              tier: child.data['Tier'],
              year: child.data['Year'],
              rating: child.data['Rating'],
              bestSeller: child.data['Best_Seller'],
              pricePerDay: child.data['Price_Per_Day']);
          _carSearchResults.add(car);
        }
      }
    });
  }

  void resetInfoControllers() {
    _resultController.clear();
    _nameController.clear();
    _addressController.clear();
    _pidController.clear();
    _phoneController.clear();
    _customerID.clear();
    notifyListeners();
  }
}
