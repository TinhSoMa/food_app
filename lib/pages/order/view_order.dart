import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          late List<OrderModel> orderList;
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent? orderController.currentOrderList.reversed.toList():
            orderController.historyOrderList.reversed.toList();
          }
          return Container(
            color: Colors.white,
            width: Dimension.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimension.width5, vertical: Dimension.height5),
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("#order id:     ${orderList[index].id}"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(Dimension.height5),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(Dimension.height5),
                                ),
                                  child: Text("${orderList[index].orderStatus}", style: const TextStyle(color: Colors.white))
                              ),
                              SizedBox(height: Dimension.height5),
                              InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text("Details", style: TextStyle(color: AppColors.yellowColor),),
                                    ),
                                    SizedBox(height: Dimension.height5),
                                  ],
                                ),

                              ),
                            ],
                          )
                        ],
                      ),

                    ),
                  );
                }
              ),
            )
          );
        } else {
          return const Text("loading...");
        }
      }),
    );
  }
}
