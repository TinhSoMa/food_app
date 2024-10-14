import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

import '../../utils/dimension.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainState();
}

class _MainState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // kiem tra ty le man hinh
    print("height: "+ MediaQuery.of(context).size.height.toString());
    print("width: "+ MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          // hiển thị header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimension.height45, bottom: Dimension.height15),
              padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "I lấp u", color: AppColors.mainColor),
                      Row(
                          children: [
                            SmallText(text: "Công Tính", color: Colors.black45,),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimension.height45,
                      height: Dimension.height45,
                      child: Icon(Icons.search, color: Colors.white, size: Dimension.icon24,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimension.radius15),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // hiển thị body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      )
    );
  }
}
