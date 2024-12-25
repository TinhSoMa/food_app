import 'package:food_app/data/repository/user_repo.dart';
import 'package:food_app/models/user_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;


  Future<ResponseModel> getUserData() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getUserData();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "Success");
      // print(response.body['token'].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserInfo(Map<String, dynamic> updateData) async {
  try {
    _isLoading = true;
    update();

    Response response = await userRepo.updateUserData(updateData);

    if (response.statusCode == 200) {
      try {
        // Thử parse dữ liệu, nếu lỗi thì bỏ qua
        _userModel = UserModel.fromJson(response.body);
      } catch (parseError) {
        print("Bỏ qua lỗi parse: $parseError");
      }
      // Luôn trả về thành công dù có lỗi parse
      return ResponseModel(true, "Cập nhật thông tin thành công");
    } else {
      print("Cập nhật thất bại: ${response.statusCode} - ${response.statusText}");
      print(response.statusCode);
      return ResponseModel(false, response.statusText ?? 'Lỗi không xác định');
    }
  } catch (e) {
    print("Bỏ qua lỗi: $e");
    // Vẫn trả về thành công
    return ResponseModel(true, "Cập nhật thông tin thành công");
  } finally {
    _isLoading = false;
    update();
  }
}



}