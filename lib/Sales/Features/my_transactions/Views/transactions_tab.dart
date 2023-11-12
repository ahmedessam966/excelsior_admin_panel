import 'package:excelsior_admin/Sales/Features/my_transactions/Controllers/sales_transactions_controller.dart';
import 'package:excelsior_admin/Sales/Features/my_transactions/Widgets/overview_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TransactionsTab extends StatelessWidget {
  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesTransactionsController>(builder: (context, provider, _) {
      return FutureBuilder(
        future: provider.getAgentSales(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: provider.agentContracts.length,
                itemBuilder: (context, index) {
                  final contract = provider.agentContracts[index];
                  return OverviewItemWidget(contract: contract);
                });
          }
        },
      );
    });
  }
}
