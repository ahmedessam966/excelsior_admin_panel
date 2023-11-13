import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:excelsior_admin/Services/API/secrets.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

class SalesDashboardControllers with ChangeNotifier {
  final List<PaymentStatusModel> _pendingPayments = [];
  List<PaymentStatusModel> get pendingPayment => _pendingPayments;
  final List _duplicatePayment = [];

  Future listenToPendingPayment(BuildContext context) async {
    _pendingPayments.clear();
    _duplicatePayment.clear();
    final String authID = Provider.of<AuthenticationServices>(context, listen: false).staffModel!.staffID;
    final pb = PocketBase(Secrets.regularConstant);
    pb.collection('PAYMENTS').getList(filter: 'Processed_By = "$authID"').then((value) {
      for (final child in value.items) {
        if (_duplicatePayment.contains(child.id)) {
        } else {
          _duplicatePayment.add(child.id);
          final slip = PaymentStatusModel(slipID: child.id, status: child.data['Status']);
          _pendingPayments.add(slip);
        }
      }
    });
  }
}

class PaymentStatusModel {
  final String slipID;
  final bool status;

  PaymentStatusModel({required this.slipID, required this.status});
}
