import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimension.dart';
import '../auth/auth_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: 24, color: Colors.white,),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimension.height20),
        child: Column(
          children: [
            //profile
            AppIcon(iconData: Icons.person, size: Dimension.height50*3, color: Colors.white, iconSize: Dimension.height80, colorBackGroundColor: AppColors.mainColor,),
            SizedBox(height: Dimension.height20,),
            //Name
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //phone
                    AccountWidget(
                        appIcon: AppIcon(iconData: Icons.phone, size: Dimension.height50, color: Colors.white, iconSize: Dimension.height20, colorBackGroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "ssss")),
                    SizedBox(height: Dimension.height20,),
                    //email
                    AccountWidget(
                        appIcon: AppIcon(iconData: Icons.email, size: Dimension.height50, color: Colors.white, iconSize: Dimension.height20, colorBackGroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "ssss")),
                    SizedBox(height: Dimension.height20,),
                    //address
                    AccountWidget(
                        appIcon: AppIcon(iconData: Icons.location_on, size: Dimension.height50, color: Colors.white, iconSize: Dimension.height20, colorBackGroundColor: AppColors.yellowColor,),
                        bigText: BigText(text: "ssss")),
                    SizedBox(height: Dimension.height20,),
                    //mess
                    AccountWidget(
                        appIcon: AppIcon(iconData: Icons.message_outlined, size: Dimension.height50, color: Colors.white, iconSize: Dimension.height20, colorBackGroundColor: Colors.red,),
                        bigText: BigText(text: "ssss")),
                    SizedBox(height: Dimension.height20,),

                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userIsLoggedIn()) {
                            Get.find<AuthController>().clearSharedPref();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());

                        }
                      },
                      child: AccountWidget(
                          appIcon: AppIcon(iconData: Icons.logout, size: Dimension.height50, color: Colors.white, iconSize: Dimension.height20, colorBackGroundColor: Colors.red,),
                          bigText: BigText(text: "Logout")),
                    ),
                    SizedBox(height: Dimension.height20,),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
