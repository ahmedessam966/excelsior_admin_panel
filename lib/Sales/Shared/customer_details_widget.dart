import 'package:excelsior_admin/Sales/Controllers/sales_controllers.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomerDetailsWidget extends StatelessWidget {
  final String customerID;
  const CustomerDetailsWidget({super.key, required this.customerID});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesControllers>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: FutureBuilder(
        future: provider.getCustomerDetails(customerID),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.person_circle_fill,
                    size: 7.dg,
                  ),
                  Text(
                    'Customer: ${snapshot.data?.name}',
                    style: context.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.clear_circled_solid,
                      size: 7.dg,
                    ),
                  )
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.perm_contact_calendar_rounded),
                title: Text(
                  'Customer ID',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.customerID,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy ID',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.abc_outlined),
                title: Text(
                  'Customer Name',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.name,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy Name',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.contact_emergency_rounded),
                title: Text(
                  'License Number',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.licenseNumber,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy License #',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.contact_phone_rounded),
                title: Text(
                  'Contact Number',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.phone,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy Phone',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail_rounded),
                title: Text(
                  'Contact Email',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.email,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy Email',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.home_work_rounded),
                title: Text(
                  'Address',
                  style: context.displayMedium,
                ),
                subtitle: Text(
                  snapshot.data!.address,
                  style: context.displaySmall,
                ),
                trailing: IconButton(
                  tooltip: 'Copy Address',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                ),
              ),
              Divider(
                indent: 5.w,
              ),
              ListTile(
                leading: const Icon(Icons.newspaper_rounded),
                title: Text(
                  'Contract History',
                  style: context.displayMedium,
                ),
                trailing: IconButton(
                  tooltip: 'Go to contracts',
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.chevron_forward),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
