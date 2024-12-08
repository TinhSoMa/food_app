import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_customer_snack_bar.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecked {
  static void checkApi (Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomerSnackBar(response.statusText!);
    }
  }
}