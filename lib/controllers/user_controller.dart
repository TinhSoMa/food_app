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
  late UserModel _userModel;

  bool get isLoading => _isLoading;
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
  _isLoading = true;
  update(); // Cập nhật trạng thái UI khi bắt đầu tải

  try {
    Response response = await userRepo.updateUserData(updateData);
    late ResponseModel responseModel;

    // Kiểm tra mã trạng thái và nội dung phản hồi
    if (response.statusCode == 200) {
      // Cập nhật thành công, cập nhật thông tin người dùng trong app
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "Cập nhật thông tin thành công");
    } else {
      // Log chi tiết về lỗi từ phản hồi API
      print("Cập nhật thất bại: ${response.statusCode} - ${response.statusText}");
      print("Chi tiết lỗi: ${response.body}");
      
      // Xử lý phản hồi không thành công
      responseModel = ResponseModel(false, response.statusText ?? 'Lỗi không xác định');
    }

    _isLoading = false;
    update(); // Cập nhật trạng thái UI khi kết thúc
    return responseModel;
  } catch (e) {
    // Log lỗi nếu có lỗi trong quá trình gửi yêu cầu
    print("Lỗi kết nối: $e");
    
    _isLoading = false;
    update();
    return ResponseModel(false, 'Lỗi kết nối: ${e.toString()}');
  }
}



}