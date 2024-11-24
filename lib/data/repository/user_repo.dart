import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserData() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

  // In UserRepo
  Future<Response> updateUserData(Map<String, dynamic> updateData) async {
    return await apiClient.postData(
        AppConstants.USER_INFO_UPDATE_URI, updateData);
  }
}
