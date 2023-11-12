import 'package:excelsior_admin/Sales/Shared/customer_details_widget.dart';
import 'package:excelsior_admin/Services/Models/contract_model.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverviewItemWidget extends StatelessWidget {
  final ContractModel contract;
  const OverviewItemWidget({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r), side: const BorderSide()),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r), side: const BorderSide()),
      title: Text(
        '${contract.carName} (${contract.carID})',
        style: context.displayMedium,
      ),
      subtitle: Text(
        'Created ${contract.contractDate}',
        style: context.displaySmall,
      ),
      children: [
        ListTile(
          leading: const Icon(CupertinoIcons.doc_text_fill),
          title: Text('Contract ID', style: context.displaySmall),
          subtitle: Text(contract.contractID, style: context.displaySmall),
        ),
        Divider(
          indent: 10.w,
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.doc_on_clipboard_fill),
          title: Text('Vehicle ID', style: context.displaySmall),
          subtitle: Text(contract.carID, style: context.displaySmall),
        ),
        Divider(
          indent: 10.w,
        ),
        ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: const Icon(CupertinoIcons.person_alt_circle_fill),
          title: Text('Customer', style: context.displaySmall),
          subtitle: Text(contract.customerName, style: context.displaySmall),
          trailing: TextButton(
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                barrierColor: Colors.transparent.withOpacity(0.8),
                constraints: BoxConstraints.expand(height: 600.h),
                isScrollControlled: true,
                builder: (context) {
                  return CustomerDetailsWidget(customerID: contract.customerID);
                },
              );
            },
            child: Text(
              'View',
              style: context.displaySmall,
            ),
          ),
        ),
        Divider(
          indent: 10.w,
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.timer_fill),
          title: Text('Contract Duration', style: context.displaySmall),
          subtitle: Text(contract.duration, style: context.displaySmall),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              'Extend',
              style: context.displaySmall,
            ),
          ),
        ),
        Divider(
          indent: 10.w,
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.money_dollar_circle_fill),
          title: Text('Down Payment', style: context.displaySmall),
          subtitle: Text('${contract.downPayment} SAR', style: context.displaySmall),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              'Adjust',
              style: context.displaySmall,
            ),
          ),
        ),
        Divider(
          indent: 10.w,
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.checkmark_seal_fill),
          title: Text('Contract Status', style: context.displaySmall),
          subtitle: Text(contract.status ? 'Active' : 'Closed', style: context.displaySmall),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              'Terminate',
              style: context.displaySmall?.copyWith(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
