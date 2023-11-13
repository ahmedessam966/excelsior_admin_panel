import 'package:excelsior_admin/Sales/Features/new_contract/Widgets/insufficient_privilege_flush.dart';
import 'package:flutter/material.dart';
import 'package:excelsior_admin/Sales/Features/new_contract/Controllers/new_contract_controllers.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../Services/API/authentication_services.dart';
import '../../../../Services/Local/styles.dart';

class PaymentInfoTab extends StatelessWidget {
  const PaymentInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewContractControllers>(context, listen: true);
    final auth = Provider.of<AuthenticationServices>(context, listen: false);
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          height: 3.h,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Text(
              'Lease For',
              style: context.displaySmall,
            )),
            Expanded(
              flex: 6,
              child: Slider.adaptive(
                  thumbColor: LightColorPalette.darkest.withOpacity(1),
                  activeColor: LightColorPalette.thirdShade,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  divisions: auth.privilegeLevel > 4 ? 29 : 59,
                  min: 1,
                  max: auth.privilegeLevel > 4 ? 30 : 60,
                  value: provider.leaseDays,
                  onChanged: (newValue) {
                    provider.setDays(newValue);
                  }),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: TextField(
                textAlign: TextAlign.center,
                onTap: () {
                  if (auth.privilegeLevel > 4) {
                    PrivilegeExceptionWidgets.insufficientPrivilege(context, 'Privilege Permission Required',
                        'Current privilege level limits the max. period to 30 days.');
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                    hintText:
                        '${provider.leaseDays.toInt().toString()} ${provider.leaseDays.toInt() == 1 ? 'Day' : 'Days'}',
                    hintStyle: context.titleSmall
                        ?.copyWith(color: LightColorPalette.darkest, fontWeight: FontWeight.w700),
                    enabledBorder: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder()),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Lease',
              style: context.displayMedium,
            ),
            Text(
              '${double.parse(provider.vehiclePriceController.text.split('SAR')[0])} SAR',
              style: context.labelSmall,
            )
          ],
        ),
        const Divider(),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: context.displayMedium,
            ),
            Text(
              '${num.parse(provider.vehiclePriceController.text.split('SAR')[0]) * provider.leaseDays} SAR',
              style: context.labelSmall,
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount (VAT Inclusive)',
              style: context.displayMedium,
            ),
            Text(
              '${num.parse(provider.vehiclePriceController.text.split('SAR')[0]) * provider.leaseDays * 0.15 + (num.parse(provider.vehiclePriceController.text.split('SAR')[0]) * provider.leaseDays)} SAR',
              style: context.labelSmall,
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum Deposit (10%)',
              style: context.displayMedium,
            ),
            Builder(
              builder: (context) {
                final double price = double.parse(provider.vehiclePriceController.text.split('SAR')[0]);
                final double total = price * provider.leaseDays;
                final double vatPrice = (total * 0.15) + total;
                final double minDeposit = vatPrice * 0.1;
                return Text(
                  '${minDeposit.ceilToDouble()} SAR',
                  style: context.labelSmall,
                );
              },
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remaining Amount Due',
              style: context.displayMedium,
            ),
            Builder(builder: (context) {
              final double price = double.parse(provider.vehiclePriceController.text.split('SAR')[0]);
              final double total = price * provider.leaseDays;
              final double vatPrice = (total * 0.15) + total;
              final double minDeposit = vatPrice * 0.1;
              final double due = vatPrice - minDeposit;
              return Text(
                '${due.ceilToDouble()} SAR',
                style: context.labelSmall,
              );
            }),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
                side: const BorderSide(color: LightColorPalette.darkest),
              ),
            ),
            onPressed: () {
              provider.generatePyamentSlip(context);
            },
            child: Text(
              'Generate Payment Slip',
              style: context.displaySmall,
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        TextField(
          controller: provider.paymentReferenceController,
          decoration: InputDecoration(
            suffix: const Text('Payment Reference Number'),
            filled: true,
            hintText: 'Payment Refernce Number',
            hintStyle: context.displaySmall?.copyWith(color: Colors.grey),
            fillColor: Colors.grey.shade200,
          ),
          onChanged: (value) {
            provider.setPaymentRefController(value);
          },
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
