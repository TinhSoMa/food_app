import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../widgets/big_text.dart';

class ShowData extends StatelessWidget {
  const ShowData({super.key});

  Future<void> _showSharedData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy tất cả các khóa và giá trị từ SharedPreferences
    Map<String, dynamic> allPrefs = {};
    for (String key in prefs.getKeys()) {
      allPrefs[key] = prefs.get(key);
    }

    // Chuyển đổi Map thành một chuỗi để hiển thị
    StringBuffer dataBuffer = StringBuffer();
    allPrefs.forEach((key, value) {
      dataBuffer.writeln('$key: $value');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Shared Data"),
          content: Text(dataBuffer.isNotEmpty ? dataBuffer.toString() : "No data found"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: // Add this inside the Column widget where you want to place the button
        GestureDetector(
          onTap: () {
            // Define the action to be performed on button tap
            _showSharedData(context);
          },
          child: Container(
            width: Dimension.width100 * 3,
            height: Dimension.height20 * 5,
            margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(Dimension.radius20),
            ),
            child: Center(
              child: BigText(
                text: "Xem dữ liệu",
                color: Colors.white,
                size: Dimension.font_size20 + Dimension.font_size20 / 2,
              ),
            ),
          ),
        ),
      )
    );
  }
}
