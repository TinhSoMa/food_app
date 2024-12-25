import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/pages/order/view_order.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn = false;
  late bool loadData = false;

  @override
  void initState()  {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userIsLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Get.find<OrderController>().getOrderList();
        print("OrderPage: initState " + Get.find<OrderController>().currentOrderList.length.toString());
        setState(() {
          if (Get.find<OrderController>().currentOrderList.length.toString() != '0') {
            loadData = true;
          } else {
            loadData = false;
          }
        });

      });



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: 'Order', color: Colors.white, size: Dimension.font_size26,),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: loadData? Column(
        children: [
          SizedBox(
            width: Dimension.screenWidth,
            child: TabBar(controller: _tabController, labelColor: AppColors.mainColor, unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.mainColor,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Current Order'),
                Tab(text: 'Order History'),
              ],),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          )
        ],
      ): Container(
        child: Text("No data found"),
      ),
    );
  }
}
