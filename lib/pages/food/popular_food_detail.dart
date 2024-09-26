import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/home/dimension.dart';
import 'package:food_app/widgets/column_detail.dart';
import 'package:food_app/widgets/extend_text.dart';

import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // hinh anh chinh
          Positioned(
            left: 0,
            right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimension.popularViewImage,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage("assets/image/food0.png"))
                ),

          )),
          // hàng icon
          Positioned(
            top: Dimension.height45,
            left: Dimension.width20,
            right: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(iconData: Icons.arrow_back_ios),
                  AppIcon(iconData: Icons.shopping_cart_outlined)
                ],
            ),

          ),
          // thông tin
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimension.popularViewImage-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimension.height20, right: Dimension.height20, top: Dimension.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.height20),
                    topLeft: Radius.circular(Dimension.height20),
                  ),
                  color: Colors.white,

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ColumnDetail(textName: "Nhái nhon nhặc",),
                     SizedBox(height: Dimension.height20,),
                     BigText(text: "Introduce"),
                    SizedBox(height: Dimension.height20,),
                    Expanded(child: SingleChildScrollView(
                      child: ExtendText(text: "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
                    ))
                  ],
                ),
          ))

        ],
      ),
      bottomNavigationBar: Container(
        height: Dimension.height120,
        padding: EdgeInsets.only(top: Dimension.height30, bottom: Dimension.height20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.height20*2),
            topRight: Radius.circular(Dimension.height20*2),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
              margin: EdgeInsets.only(left: Dimension.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.height20),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor,),
                  SizedBox(width: Dimension.width10/2,),
                  BigText(text: "0"),
                  SizedBox(width: Dimension.width10/2,),
                  Icon(Icons.add, color: AppColors.signColor,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
              margin: EdgeInsets.only(right: Dimension.height20),

              child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.mainColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
