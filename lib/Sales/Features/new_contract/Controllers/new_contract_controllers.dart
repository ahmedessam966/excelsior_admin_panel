import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../../../../Services/API/secrets.dart';
import '../../../../Services/Models/car_model.dart';
import '../../../../Services/Models/customer_model.dart';

class NewContractControllers with ChangeNotifier {
  int _contractStep = 0;
  int get contractStep => _contractStep;

  double _leaseDays = 1;
  double get leaseDays => _leaseDays;

  bool _paymentStatus = false;
  bool get paymentStatus => _paymentStatus;

  final List<CustomerModel> _customerSearchResults = [];
  List<CustomerModel> get customerSearchResults => _customerSearchResults;
  final List _duplicateCustomers = [];

  final List<CarModel> _carSearchResults = [];
  List<CarModel> get carSearchResults => _carSearchResults;
  final List _duplicateCars = [];

  final TextEditingController _resultController = TextEditingController();
  TextEditingController get resultController => _resultController;
  String _selectedCustomerID = '';

  final TextEditingController _carResultController = TextEditingController();
  TextEditingController get carResultController => _carResultController;
  String _selectedCarID = '';

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

  final TextEditingController _vehicleIDController = TextEditingController();
  TextEditingController get vehicleIDController => _vehicleIDController;

  final TextEditingController _licensePlateController = TextEditingController();
  TextEditingController get licensePlateController => _licensePlateController;

  final TextEditingController _vehicleMakeController = TextEditingController();
  TextEditingController get vehicleMakeController => _vehicleMakeController;

  final TextEditingController _vehicleModelController = TextEditingController();
  TextEditingController get vehicelModelController => _vehicleModelController;

  final TextEditingController _vehicleYearController = TextEditingController();
  TextEditingController get vehicleYearController => _vehicleYearController;

  final TextEditingController _vehicleColorController = TextEditingController();
  TextEditingController get vehicleColorController => _vehicleColorController;

  final TextEditingController _vehiclePriceController = TextEditingController();
  TextEditingController get vehiclePriceController => _vehiclePriceController;

  final TextEditingController _odometerController = TextEditingController();
  TextEditingController get odometerController => _odometerController;

  final TextEditingController _vehicleExtraKMController = TextEditingController();
  TextEditingController get vehicleExtraKMController => _vehicleExtraKMController;

  final TextEditingController _vehicleTierController = TextEditingController();
  TextEditingController get vehicleTierController => _vehicleTierController;

  final TextEditingController _paymentReferenceController = TextEditingController();
  TextEditingController get paymentReferenceController => _paymentReferenceController;

  void changeContractStep(int newValue) {
    _contractStep = newValue;
    notifyListeners();
  }

  void setResultController(String customerEmail, String customerID) {
    _resultController.text = customerEmail;
    _selectedCustomerID = customerID;
    notifyListeners();
  }

  void setCarResultController(String car, String carID) {
    _carResultController.text = car;
    _selectedCarID = carID;
    notifyListeners();
  }

  void setPaymentRefController(String value) {
    _paymentReferenceController.text = value;
    notifyListeners();
  }

  void setResults(
    String name,
    String phone,
    String address,
    String pid,
    String id,
  ) {
    _nameController.text = name;
    _phoneController.text = phone;
    _addressController.text = address;
    _pidController.text = pid;
    _customerID.text = id;

    notifyListeners();
  }

  void setCarResultsControllers(String id, String make, String model, String plates, num price, num year,
      num? odometer, num? extraKM, String tier, String color) {
    _vehicleColorController.text = color;
    _vehicleIDController.text = id;
    _vehicleMakeController.text = make;
    _vehicleModelController.text = model;
    _vehiclePriceController.text = '$price SAR';
    _vehicleYearController.text = year.toString();
    _odometerController.text = odometer.toString();
    _vehicleExtraKMController.text = '$extraKM SAR';
    _licensePlateController.text = plates;
    _vehicleTierController.text = tier;
    notifyListeners();
  }

  void setDays(double newValue) {
    _leaseDays = newValue;
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
    _carSearchResults.clear();
    _duplicateCars.clear();
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
            pricePerDay: child.data['Price_Per_Day'],
            pricePerExtraKM: child.data['Price_Per_Extra_Kilometer'],
            latestKM: child.data['Total_Kilometers'],
          );
          _carSearchResults.add(car);
        }
      }
    });
  }

  Future generatePyamentSlip(BuildContext context) async {
    final String authID = Provider.of<AuthenticationServices>(context, listen: false).staffModel!.staffID;
    final pb = PocketBase(Secrets.regularConstant);
    try {
      await pb.collection('PAYMENTS').create(body: {
        'Description': 'Down Payment for lease contract for ${_carResultController.text}',
        'Payment_Category': 'Down Payment',
        'Customer': _selectedCustomerID,
        'Processed_By': authID,
        'Payment_Date': DateTime.now().toUtc().toString(),
        'Payment_Method': 'Cash',
        'Status': false,
        'Vehicle_Data': _selectedCarID
      }).then((value) {
        _paymentReferenceController.text = value.id;
        notifyListeners();
      });
    } on ClientException catch (e) {}
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

  void resetCarControllers() {
    _carResultController.clear();
    _licensePlateController.clear();
    _vehicleColorController.clear();
    _vehicleIDController.clear();
    _vehicleMakeController.clear();
    _vehicleModelController.clear();
    _vehiclePriceController.clear();
    _vehicleYearController.clear();
    notifyListeners();
  }
}
