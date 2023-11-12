import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Services/Local/styles.dart';
import '../../my_transactions/Views/transactions_tab.dart';
import '../../new_contract/Views/new_contract_tab.dart';

class DashboardBodyWidget extends StatelessWidget {
  const DashboardBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.dg),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
      ),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: CupertinoSwitch(
                    activeColor: Colors.white,
                    trackColor: Colors.grey.shade400,
                    thumbColor: LightColorPalette.darkest.withOpacity(1),
                    value: false,
                    onChanged: (newValue) {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Dark Mode',
                    style: context.displaySmall,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Sales Dashboard',
                    style: context.displayLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    'assets/images/excelsior-color-transparent.png',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: DefaultTabController(
              length: 3,
              child: Flex(direction: Axis.vertical, children: [
                Expanded(
                  flex: 1,
                  child: TabBar(
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      indicatorColor: LightColorPalette.darkest,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: LightColorPalette.darkest,
                      labelStyle: context.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                      unselectedLabelStyle: context.displaySmall,
                      tabs: const [
                        Tab(
                          icon: Icon(CupertinoIcons.arrow_right_arrow_left_square),
                          child: Text(
                            'My Transactions',
                          ),
                        ),
                        Tab(
                          icon: Icon(CupertinoIcons.car_detailed),
                          child: Text(
                            'Garage',
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            CupertinoIcons.rectangle_stack_badge_plus,
                          ),
                          child: Text(
                            'New Contract',
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  flex: 5,
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(3.dg),
                      child: const TabBarView(children: [
                        TransactionsTab(),
                        Icon(CupertinoIcons.car_detailed),
                        NewContractTab(),
                      ]),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
