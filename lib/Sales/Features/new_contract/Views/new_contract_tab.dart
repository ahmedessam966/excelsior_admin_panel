import 'package:another_flushbar/flushbar.dart';
import 'package:excelsior_admin/Sales/Controllers/sales_controllers.dart';
import 'package:excelsior_admin/Sales/Shared/info_textfield_widget.dart';
import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:excelsior_admin/Services/Local/styles.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class NewContractTab extends StatelessWidget {
  const NewContractTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesControllers>(builder: (context, provider, _) {
      return Stepper(
        currentStep: provider.contractStep,
        controlsBuilder: (context, details) {
          switch (details.stepIndex) {
            case 0:
              return Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (provider.resultController.text.isNotEmpty) {
                      provider.changeContractStep(details.stepIndex + 1);
                    }
                  },
                  child: Text(
                    'Next',
                    style: context.displayMedium,
                  ),
                ),
              );
            case 1:
              return Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Back',
                        style: context.displayMedium,
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Next',
                        style: context.displayMedium,
                      )),
                ],
              );
            case 2:
              return Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Back',
                        style: context.displayMedium,
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Next',
                        style: context.displayMedium,
                      )),
                ],
              );
            case 3:
              return Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Back',
                        style: context.displayMedium,
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Next',
                        style: context.displayMedium,
                      )),
                ],
              );
            default:
              return const SizedBox.shrink();
          }
        },
        steps: [
          Step(
            title: const Text('Lease Information'),
            content: Flex(
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
                          var filteredList = results
                              .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                              .toList();
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
                        final int privilege = Provider.of<AuthenticationServices>(context, listen: false)
                            .staffModel!
                            .privilegeLevel;
                        if (privilege > 4) {
                          Flushbar(
                            title: 'Insufficient Privilege',
                            message:
                                'You do not have the privilege required to add customers. Please contact your department admin',
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
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
                        flex: 4,
                        child: InfoTextFieldWidget(controller: provider.customerID, title: 'Customer ID')),
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
                        flex: 4,
                        child: InfoTextFieldWidget(controller: provider.nameController, title: 'Full Name')),
                    const Spacer(),
                    Expanded(
                        flex: 4,
                        child:
                            InfoTextFieldWidget(controller: provider.phoneController, title: 'Phone Number')),
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
            ),
          ),
          Step(
            title: const Text('Car Information'),
            content: Flex(
              direction: Axis.vertical,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                TypeAheadFormField(
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
                      hintText: 'Search by Model / Vehicle ID',
                      hintStyle: context.displaySmall?.copyWith(color: Colors.grey),
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      ),
                    ),
                    controller: provider.carResultController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        provider.carSearchResults.clear();
                        // provider.resetInfoControllers();
                      }
                      provider.searchForCar(value);
                    },
                  ),
                  suggestionsCallback: ((pattern) {
                    final List results = [];
                    for (var element in provider.carSearchResults) {
                      results.add(element.model);
                    }
                    if (pattern.isEmpty) {
                      return results;
                    } else {
                      var filteredList = results
                          .where((item) => item.toLowerCase().startsWith(pattern.toLowerCase()))
                          .toList();
                      return filteredList;
                    }
                  }),
                  onSuggestionSelected: (suggestion) {
                    provider.setCarResultController(suggestion);
                    // for (var child in provider.carSearchResults) {
                    //   if (child.model == suggestion) {
                    //     provider.setResults(
                    //         child.name, child.phone, child.address, child.pidNumber, child.customerID);
                    //   }
                    // }
                  },
                  itemBuilder: (context, suggestion) {
                    String make = '';
                    String model = '';
                    String? plate;
                    for (var child in provider.carSearchResults) {
                      if (child.make == suggestion || child.model == suggestion) {
                        make = child.make;
                        model = child.model;
                        plate = child.plates;
                      }
                    }
                    return ListTile(
                      title: Text(
                        suggestion,
                        style: context.displayMedium,
                      ),
                      subtitle: Text(
                        '$make | $model | $plate',
                        style: context.displaySmall,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Builder(builder: (context) {
                  if (provider.carResultController.text.isEmpty) {
                    return FadeOut(
                      duration: const Duration(seconds: 1),
                      child: const SizedBox.shrink(),
                    );
                  } else {
                    return FadeIn(
                      animate: true,
                      duration: const Duration(seconds: 1),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 4,
                              child:
                                  InfoTextFieldWidget(controller: provider.customerID, title: 'Vehicle ID')),
                          const Spacer(),
                          Expanded(
                              flex: 4,
                              child: InfoTextFieldWidget(
                                  controller: provider.pidController, title: 'License Plates')),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
          const Step(title: Text('Payment Information'), content: SizedBox()),
          const Step(title: Text('Confirmation'), content: SizedBox()),
        ],
      );
    });
  }
}
