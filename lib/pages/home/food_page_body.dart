import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/column_detail.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

import 'dimension.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor= 0.8;
  double _height = Dimension.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print("In" + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // frame chinh
    return Column(
      children: [
        // slider
        Container(
          // color: Colors.red,
          height: Dimension.pageView,

          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        // dots
        new DotsIndicator(
        dotsCount: 5,
        position: _currPageValue,
        decorator: DotsDecorator(
        activeColor: AppColors.mainColor,
        spacing: const EdgeInsets.all(10.0),
        ),
        ),
        // popular
        SizedBox(height: Dimension.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimension.height30, right: Dimension.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(width: Dimension.height10,),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimension.height10,),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        // list food
        Container(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20, bottom: Dimension.height10),
                  child: Row(
                    children: [
                      // image food
                      Container(
                        width: Dimension.listViewImageSize120,
                        height: Dimension.listViewImageSize120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimension.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                "assets/image/food0.png"
                            ))
                        ),
                      ),
                      // text food
                      Expanded(child: Container(
                          height: Dimension.listViewText100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimension.radius20),
                                bottomRight: Radius.circular(Dimension.radius20)
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                BigText(text: "Món ăn đén từ Vịt Nem"),
                                SizedBox(height: Dimension.height10,),
                                SmallText(text: "Cục cứt 7 màu"),
                                SizedBox(height: Dimension.height10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndText(iconData: Icons.circle_sharp, text: "Nomarl", iconColor: AppColors.iconColor1),
                                    IconAndText(iconData: Icons.location_on, text: "1.5km", iconColor: AppColors.mainColor),
                                    IconAndText(iconData: Icons.access_time, text: "32min", iconColor: AppColors.iconColor1)
                                  ],
                                )
                              ],
                            ),
                          ),
                      )
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currPageValue.floor()) {

        var currScale = 1-(_currPageValue-index) * (1- _scaleFactor);

        var currTrans = _height*(1-currScale)/ 2;
        // print("currTrans trang hiện tại"+currTrans.toString());
        matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index == _currPageValue.floor()+1) {
        var currScale = _scaleFactor + (_currPageValue - index+1) * (1-_scaleFactor);
        var currTrans = _height*(1-currScale)/ 2;
        matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
        matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index == _currPageValue.floor()-1) {
      var currScale = 1-(_currPageValue-index) * (1- _scaleFactor);
      var currTrans = _height*(1-currScale)/ 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
        var currScale = 0.8;
        matrix4 =Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor), 1);
    }


    return Transform(
        transform: matrix4,
        child: Stack(
        children: [
          // frame item
          Container(
            height: Dimension.pageViewContainer,
            margin: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                color: index.isEven?Colors.black54:Colors.teal,
                image: DecorationImage(
                    image: AssetImage("assets/image/food1.png"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // frame tren frame item
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimension.width30, right: Dimension.width30, bottom: Dimension.width30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Color(0xFFe8e8e8),
                     blurRadius: 5.0,
                     offset: Offset(0, 5)
                   ),
                   BoxShadow(
                     color: Colors.white,
                     offset: Offset(-5, 0),
                   ),
                   BoxShadow(
                     color: Colors.white,
                     offset: Offset(5, 0),
                   )
                 ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimension.height15, left: Dimension.width15, right: Dimension.width15),
                child: ColumnDetail(textName: "Cái nhon nhặc",),
              ),
            ),
          )
        ],
      ),
    );
  }
}
