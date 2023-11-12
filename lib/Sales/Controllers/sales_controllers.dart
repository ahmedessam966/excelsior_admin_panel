import 'package:excelsior_admin/Services/Models/contract_model.dart';
import 'package:excelsior_admin/Services/Models/customer_model.dart';
import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:excelsior_admin/Services/API/secrets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../../Services/Models/car_model.dart';

class SalesControllers with ChangeNotifier {
  int _contractStep = 0;
  int get contractStep => _contractStep;

  final List<ContractModel> _agentContracts = [];
  List<ContractModel> get agentContracts => _agentContracts;
  final List _duplicates = [];

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

  Future getAgentSales(BuildContext context) async {
    _agentContracts.clear();
    _duplicates.clear();

    final pb = PocketBase(Secrets.regularConstant);
    final userRecord = Provider.of<AuthenticationServices>(context, listen: false).staffModel;

    final value = await pb.collection('CONTRACTS').getList(filter: 'Created_By = "${userRecord?.staffID}"');

    for (final child in value.items) {
      if (_duplicates.contains(child.id)) {
        return;
      } else {
        _duplicates.add(child.id);
        String customerName = await pb
            .collection('CUSTOMER_VIEW')
            .getOne(child.data['Customer'])
            .then((value) => value.data['Name']);

        final carValue = await pb.collection('CARS_VIEW').getOne(child.data['Car']);
        String carPlates = carValue.data['License_Plate'];
        String car = '${carValue.data['Make']} ${carValue.data['Model']}';
        String contractDate = normalizeDateFromAPI(child.created);

        final contract = ContractModel(
          contractID: child.id,
          contractDate: contractDate,
          customerID: child.data['Customer'],
          customerName: customerName,
          duration: child.data['Duration'],
          carID: carPlates,
          downPayment: child.data['Down_Payment'],
          status: child.data['Status'],
          carName: car,
        );
        _agentContracts.add(contract);
      }
    }
  }

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
