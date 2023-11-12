import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../../../../Services/API/authentication_services.dart';
import '../../../../Services/API/secrets.dart';
import '../../../../Services/Models/contract_model.dart';

class SalesTransactionsController with ChangeNotifier {
  final List<ContractModel> _agentContracts = [];
  List<ContractModel> get agentContracts => _agentContracts;
  final List _duplicates = [];

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
