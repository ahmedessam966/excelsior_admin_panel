import 'package:excelsior_admin/Sales/Features/dashboard/Controllers/dashboard_controllers.dart';
import 'package:excelsior_admin/Sales/Features/dashboard/Widgets/profile_image_viewer.dart';
import 'package:excelsior_admin/Services/API/authentication_services.dart';
import 'package:excelsior_admin/Services/Local/styles.dart';
import 'package:excelsior_admin/Services/Local/text_variants_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Services/API/secrets.dart';

class VerticalNavbar extends StatelessWidget {
  const VerticalNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthenticationServices, SalesDashboardControllers>(
        builder: (context, provider, dashboard, _) {
      return Container(
        padding: EdgeInsets.all(3.dg),
        margin: EdgeInsets.only(right: 3.w, top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 6,
            ),
          ],
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: IconButton(
                    tooltip: 'Mail',
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.mail,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    tooltip: 'Calendar',
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.calendar_today,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    tooltip: 'Notifications',
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.bell,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    tooltip: 'Settings',
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.settings,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: IconButton(
                    tooltip: 'More',
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: LightColorPalette.darkest),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              return ProfileImageViewer(
                                imagePath: '${provider.staffModel?.profileImage}',
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundImage: const AssetImage('assets/images/profile.png'),
                        foregroundImage:
                            NetworkImage('${Secrets.regularConstant}${provider.staffModel?.profileImage}'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.staffModel!.name,
                        style: context.displaySmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text('${provider.userDepartment} - P${provider.privilegeLevel}')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Divider(
              indent: 5.w,
              endIndent: 5.w,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        CupertinoIcons.plus_bubble,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        'New Message',
                        style: context.displaySmall?.copyWith(color: Colors.white, fontSize: 3.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // FutureBuilder(
            //   future: dashboard.listenToPendingPayment(context),
            //   builder: (context, snapshot) {
            //     return Expanded(
            //       child: ListView.separated(
            //           separatorBuilder: (context, index) => Divider(
            //                 indent: 5.w,
            //               ),
            //           itemCount: dashboard.pendingPayment.length,
            //           itemBuilder: (context, index) {
            //             final slip = dashboard.pendingPayment[index];
            //             return ListTile(
            //               title: Text(slip.slipID),
            //               subtitle: Text(slip.status ? 'Confirmed' : 'Pending'),
            //             );
            //           }),
            //     );
            //   },
            // ),
          ],
        ),
      );
    });
  }
}
