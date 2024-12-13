
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';

import 'package:get/get.dart';

import '../../base/custom_button.dart';
import '../../routes/route_helper.dart';
class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
  OrderSuccessPage({required this.orderId, required this.status});

  @override
  Widget build(BuildContext context) {
    if(status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(

      body: Center(child: SizedBox(width: Dimension.screenWidth, child:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        Image.asset(status == 1 ? "assets/image/checked.png" :
        "assets/image/warning.png", width: 100, height: 100),
        SizedBox(height: Dimension.screenWidth * 0.1),

        Text(
          status == 1 ? 'You placed the order successfully' : 'Your order failed',
          style: TextStyle(fontSize: Dimension.font_size26),
        ),
        SizedBox(height: Dimension.height20),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimension.width30,
              vertical: Dimension.width10),
          child: Text(
            status == 1 ? 'Successful order' : 'Failed order',
            // style: robotoMedium.copyWith(fontSize: Dimension.font_size16,
            //     color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),

        Padding(
          padding: EdgeInsets.all(Dimension.width10),
          child: CustomButton(buttonText: 'Back to Home'.tr, onPressed:
              () => Get.offAllNamed(RouteHelper.getInitial())),
        ),
      ]))),
    );
  }
}
