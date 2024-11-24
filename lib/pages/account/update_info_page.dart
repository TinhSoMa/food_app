import 'package:flutter/material.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/controllers/user_controller.dart';

class UpdateInfoPage extends StatefulWidget {
  const UpdateInfoPage({super.key});

  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late UserController userController;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    // Load current user data
    _nameController.text = userController.userModel?.name ?? '';
    _emailController.text = userController.userModel?.email ?? '';
    _phoneController.text = userController.userModel?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Cập nhật thông tin", color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return Padding(
            padding: EdgeInsets.all(Dimension.height20),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Tên",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Dimension.height20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Vui lòng nhập email hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Dimension.height20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Dimension.height20),
                userController.isLoading 
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimension.width20 * 2,
                        vertical: Dimension.height20,
                      ),
                    ),
                    onPressed: () async {
                      if (_nameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty) {
                        Get.snackbar(
                          "Lỗi",
                          "Vui lòng điền đầy đủ thông tin",
                          backgroundColor: Colors.redAccent,
                        );
                        return;
                      }

                      // Thu thập dữ liệu từ các controller
                      final Map<String, dynamic> updateData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "phone": _phoneController.text,
                      };

                      // Gọi hàm cập nhật thông tin
                      ResponseModel response =
                          await userController.updateUserInfo(updateData);

                      if (response.isSuccess) {
                        Get.snackbar(
                          "Thành công",
                          "Cập nhật thông tin thành công",
                          backgroundColor: Colors.greenAccent,
                        );
                      } else {
                        Get.snackbar(
                          "Lỗi",
                          "Cập nhật thông tin thất bại: ${response.message}",
                          backgroundColor: Colors.redAccent,
                        );
                      }
                    },
                    child: BigText(
                      text: "Cập nhật",
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
