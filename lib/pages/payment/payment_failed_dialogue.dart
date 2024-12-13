
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_button.dart';
import '../../controllers/order_controller.dart';
import '../../routes/route_helper.dart';
import 'package:get/get.dart';
class PaymentFailedDialog extends StatelessWidget {
  final String orderID;
  PaymentFailedDialog({required this.orderID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.radius15)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: EdgeInsets.all(Dimension.width10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: EdgeInsets.all(Dimension.width30),
            child: Image.asset("assets/image/warning.png", width: 70, height: 70),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimension.width30),
            child: Text(
              'are_you_agree_with_this_order_fail', textAlign: TextAlign.center,
              // style: robotoMedium.copyWith(fontSize: Dimension.font_size26, color: Colors.red),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Dimension.width30),
            child: Text(
              'if_you_do_not_pay',
              // style: robotoMedium.copyWith(fontSize: Dimension.font_size26),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Dimension.width30),

          GetBuilder<OrderController>(builder: (orderController) {
            return !orderController.isLoading ? Column(children: [
              CustomButton(
                buttonText: 'switch_to_cash_on_delivery',
                //onPressed: () => orderController.switchToCOD(orderID),
                radius: Dimension.radius15, height: 40,
              ),
              SizedBox(width: Dimension.width30),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(RouteHelper.getInitial());
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimension.screenWidth, 40), padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimension.radius15)),
                ),
                child: Text('continue_with_order_fail', textAlign: TextAlign.center,
                    // style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color)
                ),
              ),
            ]) : Center(child: CircularProgressIndicator());
          }),

        ]),
      )),
    );
  }
}
