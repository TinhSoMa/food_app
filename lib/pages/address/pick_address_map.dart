import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_buttom.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({super.key, required this.fromSignUp, required this.fromAddress, this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(16.4637, 107.5909);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      
    } else {
      if(Get.find<LocationController>().addressList.isNotEmpty) {
        var latitude = Get.find<LocationController>().getAddress["latitude"];
        var longitude = Get.find<LocationController>().getAddress["longitude"];

        if (latitude is String) {
          latitude = double.parse(latitude);
        }
        if (longitude is String) {
          longitude = double.parse(longitude);
        }
        // _initialPosition = LatLng(
        //     double.parse(Get.find<LocationController>().getAddress["latitude"]),
        //     double.parse(Get.find<LocationController>().getAddress["longitude"])
        // );
        _initialPosition = LatLng(
            latitude,
            longitude
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
          body: SafeArea(child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom:17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,

                  ),
                  Center(
                    child: !locationController.loading? Image.asset("assets/image/pick_marker.png", width: 50, height: 50,): const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimension.height45,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimension.width20),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 25, color: AppColors.yellowColor,),
                            Expanded(child: Text(
                              '${locationController.pickedPlaceMark.name??""},'
                                  '${locationController.pickedPlaceMark.locality??""},'
                                  '${locationController.pickedPlaceMark.administrativeArea??""},'
                                  '${locationController.pickedPlaceMark.country??""}',
                              style: TextStyle(color: AppColors.yellowColor, fontSize: Dimension.font_size16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),

                      )
                  ),
                  Positioned(
                      bottom: Dimension.height100*2,
                      left: Dimension.width20,
                      right: Dimension.width20,
                      child:  CustomButtom(buttonText: 'Pick Address',
                      onPressed: locationController.loading?null:() {
                        if(locationController.pickedPosition.latitude!=0&&
                        locationController.pickedPlaceMark.name!=null) {
                          if(widget.fromAddress) {
                            if(widget.googleMapController!= null) {
                              print("Đã nhận được giá trị");
                              Timer(const Duration(milliseconds: 1000), () {
                                widget.googleMapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                        locationController.pickedPosition.latitude,
                                        locationController.pickedPosition.longitude))));
                              });
                              // widget.googleMapController!.moveCamera(
                              //     CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                              //         locationController.pickedPosition.latitude,
                              //         locationController.pickedPosition.longitude))));
                              locationController.setAddAddressData();
                            }
                            Get.toNamed(RouteHelper.getAddressPage());
                          }
                        }
                      },),
                  )
                ],
              ),
            ),
          ))
      );
    });
  }
}
