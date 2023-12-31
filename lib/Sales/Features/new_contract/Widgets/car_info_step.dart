import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:excelsior_admin/Sales/Features/new_contract/Controllers/new_contract_controllers.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../Shared/info_textfield_widget.dart';

class CarInfoStep extends StatelessWidget {
  const CarInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewContractControllers>(context, listen: true);
    return Flex(
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
                provider.resetCarControllers();
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
              var filteredList =
                  results.where((item) => item.toLowerCase().startsWith(pattern.toLowerCase())).toList();
              return filteredList;
            }
          }),
          onSuggestionSelected: (suggestion) {
            for (var child in provider.carSearchResults) {
              if (child.model == suggestion || child.make == suggestion) {
                provider.setCarResultController(suggestion, child.carID);
                provider.setCarResultsControllers(
                    child.carID,
                    child.make,
                    child.model,
                    '${child.plates}',
                    child.pricePerDay,
                    child.year,
                    child.latestKM,
                    child.pricePerExtraKM,
                    child.tier,
                    child.color);
              }
            }
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
              animate: true,
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
                          InfoTextFieldWidget(controller: provider.vehicleIDController, title: 'Vehicle ID')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.licensePlateController, title: 'License Plates')),
                ],
              ),
            );
          }
        }),
        SizedBox(
          height: 10.h,
        ),
        Builder(builder: (context) {
          if (provider.carResultController.text.isEmpty) {
            return FadeOut(
              animate: true,
              duration: const Duration(seconds: 1),
              child: const SizedBox.shrink(),
            );
          } else {
            return FadeIn(
              delay: const Duration(microseconds: 500),
              animate: true,
              duration: const Duration(seconds: 1),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(controller: provider.vehicleMakeController, title: 'Make')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child:
                          InfoTextFieldWidget(controller: provider.vehicelModelController, title: 'Model')),
                ],
              ),
            );
          }
        }),
        SizedBox(
          height: 10.h,
        ),
        Builder(builder: (context) {
          if (provider.carResultController.text.isEmpty) {
            return FadeOut(
              animate: true,
              duration: const Duration(seconds: 1),
              child: const SizedBox.shrink(),
            );
          } else {
            return FadeIn(
              delay: const Duration(microseconds: 800),
              animate: true,
              duration: const Duration(seconds: 1),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.vehicleColorController, title: 'Vehicle Color')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.vehicleTierController, title: 'Class/Tier')),
                ],
              ),
            );
          }
        }),
        SizedBox(
          height: 10.h,
        ),
        Builder(builder: (context) {
          if (provider.carResultController.text.isEmpty) {
            return FadeOut(
              animate: true,
              duration: const Duration(seconds: 1),
              child: const SizedBox.shrink(),
            );
          } else {
            return FadeIn(
              delay: const Duration(microseconds: 500),
              animate: true,
              duration: const Duration(seconds: 1),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.vehiclePriceController, title: 'Price/Day')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.vehicleExtraKMController, title: 'Price/Extra KM')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(
                          controller: provider.odometerController, title: 'Current Odometer')),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: InfoTextFieldWidget(controller: provider.vehicleYearController, title: 'Year')),
                ],
              ),
            );
          }
        }),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
