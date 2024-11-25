import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  bool get loading => _loading;
  late Position _position;
  Position get position => _position;
  late Position _pickedPosition;
  Position get pickedPosition => _pickedPosition;
  Placemark _placeMark = Placemark();
  Placemark get placeMark => _placeMark;
  Placemark _pickedPlaceMark = Placemark();
  Placemark get pickedPlaceMark => _pickedPlaceMark;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypeList = ["Home", "Work", "Other"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;


  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if(fromAddress) {
          _position = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speed: 1, speedAccuracy: 1
          );
        } else {
          _pickedPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1, accuracy: 1, altitude: 1, speed: 1, speedAccuracy: 1
          );
        }

        if (_changeAddress) {
          getAddressFromLatLng(
              LatLng(
                  position.target.latitude,
                  position.target.longitude));

          // fromAddress? _placeMark = Placemark(name: _address, ) : _pickedPlaceMark = Placemark(name: _address);
          fromAddress? _placeMark = placeMark : _pickedPlaceMark = placeMark;
          // print("_placeMark.name"+ _placeMark.name.toString());
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);
    _placeMark = placemarks[0];
    _getAddress = {
      "address": _placeMark.name,
      "city": _placeMark.locality,
      "state": _placeMark.administrativeArea,
      "country": _placeMark.country,
      // "postalCode": _placeMark.postalCode,
      "latitude": latLng.latitude,
      "longitude": latLng.longitude
    };
    _loading = false;
    update();
    print(_getAddress);
    return _placeMark.name!;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress()!);
    try {
      _addressModel = AddressModel.fromJson(_getAddress);
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addUserAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body['message'];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("khong the luu dia chi "+response.body);
      responseModel = ResponseModel(false, response.body['message']);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
     _addressList = [];
     _allAddressList = [];
     response.body.forEach((address) {
       AddressModel addressModel = AddressModel.fromJson(address);
       _addressList.add(addressModel);
       _allAddressList.add(addressModel);
     });
    } else {
      _addressList = [];
      _allAddressList = [];
      print("khong the lay dia chi");
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    return await locationRepo.saveAddress(jsonEncode(addressModel.toJson()));
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

}