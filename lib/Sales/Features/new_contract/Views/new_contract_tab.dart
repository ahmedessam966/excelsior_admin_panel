import 'package:excelsior_admin/Sales/Features/new_contract/Controllers/new_contract_controllers.dart';
import 'package:excelsior_admin/Sales/Features/new_contract/Widgets/car_info_step.dart';
import 'package:excelsior_admin/Sales/Features/new_contract/Widgets/lease_info_step.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewContractTab extends StatelessWidget {
  const NewContractTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewContractControllers>(builder: (context, provider, _) {
      return Stepper(
        currentStep: provider.contractStep,
        controlsBuilder: (context, details) {
          switch (details.stepIndex) {
            case 0:
              return Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: const ButtonStyle(enableFeedback: true),
                  onPressed: provider.resultController.text.isEmpty
                      ? null
                      : () {
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
              state: provider.contractStep == 0
                  ? StepState.indexed
                  : provider.contractStep > 0
                      ? StepState.complete
                      : StepState.indexed,
              isActive: provider.contractStep == 0,
              title: const Text('Lease Information'),
              content: const LeaseInfoStep()),
          Step(
              state: provider.contractStep == 1
                  ? StepState.indexed
                  : provider.contractStep > 1
                      ? StepState.complete
                      : StepState.indexed,
              isActive: provider.contractStep == 1,
              title: const Text('Car Information'),
              content: const CarInfoStep()),
          Step(
              state: provider.contractStep == 2
                  ? StepState.indexed
                  : provider.contractStep > 2
                      ? StepState.complete
                      : StepState.indexed,
              isActive: provider.contractStep == 2,
              title: const Text('Payment Information'),
              content: const SizedBox()),
          Step(
              state: provider.contractStep == 3
                  ? StepState.indexed
                  : provider.contractStep > 3
                      ? StepState.complete
                      : StepState.indexed,
              isActive: provider.contractStep == 3,
              title: const Text('Confirmation'),
              content: const SizedBox()),
        ],
      );
    });
  }
}
