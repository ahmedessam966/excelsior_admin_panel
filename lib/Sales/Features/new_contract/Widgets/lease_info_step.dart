import 'package:another_flushbar/flushbar.dart';
import 'package:excelsior_admin/Sales/Features/new_contract/Controllers/new_contract_controllers.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../../Services/API/authentication_services.dart';
import '../../../../Services/Local/styles.dart';
import '../../../Shared/info_textfield_widget.dart';

class LeaseInfoStep extends StatelessWidget {
  const LeaseInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewContractControllers>(context, listen: true);
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          height: 3.h,
        ),
        Flex(direction: Axis.horizontal, children: [
          Expanded(
            flex: 5,
            child: TypeAheadFormField(
              itemSeparatorBuilder: (context, index) => Divider(
                indent: 5.w,
              ),
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r),
                ),
              ),
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  hintText: 'Search by Email Address',
                  hintStyle: context.displaySmall?.copyWith(color: Colors.grey),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                ),
                controller: provider.resultController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    provider.customerSearchResults.clear();
                    provider.resetInfoControllers();
                  }
                  provider.searchForCustomer(value);
                },
              ),
              suggestionsCallback: ((pattern) {
                final List results = [];
                for (var element in provider.customerSearchResults) {
                  results.add(element.email);
                }
                if (pattern.isEmpty) {
                  return results;
                } else {
                  var filteredList =
                      results.where((item) => item.toLowerCase().startsWith(pattern.toLowerCase())).toList();
                  return filteredList;
                }
              }),
              onSuggestionSelected: (suggestion) {
                provider.setResultController(suggestion);
                for (var child in provider.customerSearchResults) {
                  if (child.email == suggestion) {
                    provider.setResults(
                        child.name, child.phone, child.address, child.pidNumber, child.customerID);
                  }
                }
              },
              itemBuilder: (context, suggestion) {
                String phone = '';
                String name = '';
                for (var child in provider.customerSearchResults) {
                  if (child.email == suggestion) {
                    phone = child.phone;
                    name = child.name;
                  }
                }
                return ListTile(
                  title: Text(
                    suggestion,
                    style: context.displayMedium,
                  ),
                  subtitle: Text(
                    '$name | $phone',
                    style: context.displaySmall,
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: LightColorPalette.darkest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              onPressed: () {
                final int privilege =
                    Provider.of<AuthenticationServices>(context, listen: false).staffModel!.privilegeLevel;
                if (privilege > 4) {
                  Flushbar(
                    title: 'Insufficient Privilege',
                    message:
                        'You do not have the privilege required to add customers. Please contact your department admin',
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                    mainButton: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Make Request',
                            style: context.displaySmall?.copyWith(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Dismiss',
                            style: context.displaySmall?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ).show(context);
                }
              },
              child: Text(
                'Add New',
                style: context.displaySmall?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 20.h,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 4, child: InfoTextFieldWidget(controller: provider.customerID, title: 'Customer ID')),
            const Spacer(),
            Expanded(
                flex: 4,
                child: InfoTextFieldWidget(controller: provider.pidController, title: 'Personal ID')),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 4, child: InfoTextFieldWidget(controller: provider.nameController, title: 'Full Name')),
            const Spacer(),
            Expanded(
                flex: 4,
                child: InfoTextFieldWidget(controller: provider.phoneController, title: 'Phone Number')),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        InfoTextFieldWidget(controller: provider.addressController, title: 'Address'),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}