import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/show_customer_snack_bar.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/address/pick_address_map.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/app_icon.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  late CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      16.4637, 107.5909), zoom: 17);
  late LatLng _initialPosition = LatLng(
      16.4637, 107.5909);


  @override
  void initState() {
    super.initState();
    print("Ham tu dong");
    _isLogged = Get.find<AuthController>().userIsLoggedIn();

    if (_isLogged && Get.find<UserController>().userModel == null) {
      print("Load du lieu user tu server");
      Get.find<UserController>().getUserData();
    } else {
      print("User da dang nhap");
    }

    if (Get.find<LocationController>().getUserAddressFromLocal() == ""
    ) {
      // Kiểm tra và tải dữ liệu từ cơ sở dữ liệu
      // Get.find<LocationController>().loadAddress();

      // Lấy danh sách địa chỉ sau khi tải
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        // Lưu địa chỉ cuối cùng từ danh sách
        Get.find<LocationController>().saveUserAddress(
          Get.find<LocationController>().addressList.last,
        );
        print("Đã lưu địa chỉ: ${Get.find<LocationController>().addressList.last.toJson()}");
      } else {
        print("Không tìm thấy địa chỉ nào sau khi tải từ cơ sở dữ liệu.");
      }
    }




    if (Get.find<LocationController>().addressList.isNotEmpty) {

      Get.find<LocationController>().getUserAddress();
      // print("Địa chỉ không trống" + Get.find<LocationController>().getAddress["latitude"]);

      _cameraPosition = CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Address page", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        // print("userController: " + _contactPersonName.text );
        if(userController.userModel != null && _contactPersonName.text.isEmpty) {
          _contactPersonName.text = userController.userModel.name;
          _contactPersonNumber.text = userController.userModel.phone;
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            print("Địa chỉ không trống " + Get.find<LocationController>().getUserAddress().address);

            _addressController.text =  Get.find<LocationController>().getUserAddress().address;
            // _addressController.text = Get.find<LocationController>().addressList[0].address;
            print("_addressController.text: 1 " + _addressController.text);
          }

        }
        return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text = '${locationController.placeMark.street?? ''}'
                '${locationController.placeMark.subAdministrativeArea?? ''}'
                ' ${locationController.placeMark.administrativeArea?? ''}'
                ' ${locationController.placeMark.country??''}';
          print("_addressController: " + _addressController.text);
          // print(locationController.placeMark.toString());
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: Dimension.height100*2,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: Dimension.height5, right: Dimension.height5, top: Dimension.height5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 2, color: AppColors.mainColor
                                )
                            ),
                            child: Stack(
                              children: [
                                RepaintBoundary(
                                  child: GoogleMap(
                                    initialCameraPosition:
                                    CameraPosition(target: _initialPosition, zoom: 17),
                                    onTap: (latLng) {
                                      Get.toNamed(RouteHelper.getPickAddresspage(),
                                      arguments: PickAddressMap(
                                        fromAddress: true,
                                        fromSignUp: false,
                                        googleMapController: locationController.mapController,
                                      ));
                                    },
                                    zoomControlsEnabled: false,
                                    compassEnabled: false,
                                    indoorViewEnabled: true,
                                    mapToolbarEnabled: false,
                                    myLocationButtonEnabled: true,
                                    onCameraIdle: () {
                                      Timer(Duration(seconds: 1), () {
                                        locationController.updatePosition(_cameraPosition, true);
                                      });
                                      // locationController.updatePosition(_cameraPosition, true);
                                    },
                                    onCameraMove: ((position) => _cameraPosition = position),
                                    onMapCreated: (GoogleMapController controller) {
                                      locationController.setMapController(controller);
                                    },
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimension.height20, top: Dimension.height20),
                          child: SizedBox(height: 50, child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationController.setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimension.height20, vertical: Dimension.height20),
                                    margin: EdgeInsets.only(right: Dimension.height20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimension.height20/4),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          // offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          index == 0? Icons.home : index == 1 ? Icons.work : Icons.location_on,
                                          color: locationController.addressTypeIndex == index ? AppColors.mainColor : Theme.of(context).disabledColor,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),),
                        ),
                        SizedBox(height: Dimension.height20,),
                        Padding(
                          padding: EdgeInsets.only(left: Dimension.height20),
                          child: BigText(text: "Delivery Address"),
                        ),
                        AppTextField(textEditingController: _addressController, hintText: "Your address", icon: Icons.map),
                        SizedBox(height: Dimension.height5,),
                        Padding(
                          padding: EdgeInsets.only(left: Dimension.height20),
                          child: BigText(text: "Your Name"),
                        ),
                        AppTextField(textEditingController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                        SizedBox(height: Dimension.height5,),
                        Padding(
                          padding: EdgeInsets.only(left: Dimension.height20),
                          child: BigText(text: "Your Phone"),
                        ),
                        AppTextField(textEditingController: _contactPersonNumber, hintText: "Your phone", icon: Icons.phone),
                        SizedBox(height: Dimension.height5,),
                        GestureDetector(
                          onTap: () {
                            Get.find<LocationController>().addressList.forEach((element) {
                              print("Address: " + element.address);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                            margin: EdgeInsets.only(right: Dimension.height20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimension.radius20),
                                color: AppColors.mainColor
                            ),

                            child: BigText(text: "Load", color: Colors.white, textOverflow: TextOverflow.clip, size: Dimension.font_size16,),

                          ),
                        ),
                      ],
                    ),
                  );
        });
      })

      ,
      bottomNavigationBar: GetBuilder<LocationController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("addressTypeIndex: " + _addressController.text);
                      // print("address type" + controller.addressTypeList[controller.addressTypeIndex]);
                      AddressModel addressModel = AddressModel(
                          addressType: controller.addressTypeList[controller.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: controller.position.latitude.toString(),
                          longitude: controller.position.longitude.toString()

                      );
                      controller.addAddress(addressModel).then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          showCustomerSnackBar("Success", isError: false);
                        } else {
                          showCustomerSnackBar("Fail", isError: true);

                        }
                      });
                    },
                    child: Row(

                      children: [
                        Container(
                          padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                          margin: EdgeInsets.only(right: Dimension.height20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimension.radius20),
                              color: AppColors.mainColor
                          ),

                          child: BigText(text: "Save", color: Colors.white, textOverflow: TextOverflow.clip, size: Dimension.font_size16,),

                        ),

                      ],
                    ),


                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

