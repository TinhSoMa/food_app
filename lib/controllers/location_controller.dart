import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:food_app/data/api/api_checked.dart';
import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

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



  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _inZone = false;
  bool get inZone => _inZone;
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  //lưu địa chỉ google map gợi ý
  List<Prediction> _predictionsList = [];
  List<Prediction> get predictionsList => _predictionsList;


  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  // void updatePosition(CameraPosition position, bool fromAddress) async {
  //   if (_updateAddressData) {
  //     _loading = true;
  //     update();
  //     try {
  //       if(fromAddress) {
  //         print("updatePosition1");
  //         _position = Position(
  //             latitude: position.target.latitude,
  //             longitude: position.target.longitude,
  //           timestamp: DateTime.now(),
  //           heading: 1, accuracy: 1, altitude: 1, speed: 1, speedAccuracy: 1
  //         );
  //         print("placeMark"+placeMark.toString());
  //
  //       } else {
  //         print("updatePosition2");
  //         _pickedPosition = Position(
  //             latitude: position.target.latitude,
  //             longitude: position.target.longitude,
  //             timestamp: DateTime.now(),
  //             heading: 1, accuracy: 1, altitude: 1, speed: 1, speedAccuracy: 1
  //         );
  //       }
  //
  //       if (_changeAddress) {
  //         print("updatePosition3");
  //
  //         getAddressFromLatLng(
  //             LatLng(
  //                 position.target.latitude,
  //                 position.target.longitude));
  //
  //         // fromAddress? _placeMark = Placemark(name: _address, ) : _pickedPlaceMark = Placemark(name: _address);
  //         fromAddress? _placeMark = placeMark : _pickedPlaceMark = placeMark;
  //         // print("_placeMark.name"+ _placeMark.name.toString());
  //       }
  //     } catch (e) {
  //       print("SOS "+e.toString());
  //     }
  //     _loading = false;
  //     update();
  //   } else {
  //     _updateAddressData = true;
  //   }
  // }
  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        Position newPosition = Position(
          latitude: position.target.latitude,
          longitude: position.target.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speed: 1,
          speedAccuracy: 1,
        );

        if (fromAddress) {
          _position = newPosition;
        } else {
          _pickedPosition = newPosition;
        }

        if (_changeAddress) {
          await getAddressFromLatLng(LatLng(position.target.latitude, position.target.longitude));
          if (fromAddress) {
            _placeMark = placeMark;
          } else {
            _pickedPlaceMark = placeMark;
          }
        } else {
          _changeAddress = true;
        }
      } catch (e) {
        print("Error: $e");
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  // Future<String> getAddressFromLatLng(LatLng latLng) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //       latLng.latitude, latLng.longitude);
  //   _placeMark = placemarks[0];
  //   _getAddress = {
  //     "address": _placeMark.name,
  //     "city": _placeMark.locality,
  //     "state": _placeMark.administrativeArea,
  //     "country": _placeMark.country,
  //     // "postalCode": _placeMark.postalCode,
  //     "latitude": latLng.latitude,
  //     "longitude": latLng.longitude
  //   };
  //   _loading = false;
  //   update();
  //   print("getAddressFromLatLng"+_getAddress.toString());
  //   return _placeMark.name!;
  // }


  Future<Placemark> getAddressFromLatLng(LatLng latLng) async {
    // print("tọa độ: " + latLng.latitude.toString() + " " + latLng.longitude.toString());
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude);
      _placeMark = placemarks[0];
      _getAddress = {
        // "Name": placeMark.name,
        "address": placeMark.street,
        // "ISO Country Code": placeMark.isoCountryCode,
        "country": placeMark.country,
        // "Postal code": placeMark.postalCode,
        "state": placeMark.administrativeArea,
        // "state": placeMark.subAdministrativeArea,
        "city": placeMark.locality,
        "sublocality2": placeMark.subLocality,
        // "Thoroughfare": placeMark.thoroughfare,
        // "Subthoroughfare": placeMark.subThoroughfare,
        "latitude": latLng.latitude,
        "longitude": latLng.longitude
      };
      _loading = false;
      update();
      print("getAddressFromLatLng" + _getAddress.toString());
      return _placeMark;

  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

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

  // void loadAddress() async{
  //   await getAddressList();
  // }
  Future<void> loadAddress() async{
    await getAddressList();
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      print("lay dia chi thanh cong");
     _addressList = [];
     _allAddressList = [];
     response.body.forEach((address) {
       print("address: "+address.toString());
       AddressModel addressModel = AddressModel.fromJson(address);
       _addressList.add(addressModel);
       _allAddressList.add(addressModel);
        print("addressModel: "+addressModel.latitude.toString() + " " + addressModel.longitude.toString());
       print("Raw JSON: ${address.toString()}");

       getAddressFromLatLng(LatLng(double.parse(addressModel.latitude), double.parse(addressModel.longitude)));

     });
    } else {
      _addressList = [];
      _allAddressList = [];
      print("khong the lay dia chi");
    }
    // update();
  }


  Future<bool> saveUserAddress(AddressModel addressModel) async {
    return await locationRepo.saveAddress(jsonEncode(addressModel.toJson()));
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocal() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position=_pickedPosition;
    _placeMark=_pickedPlaceMark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markLoad) async{
    late ResponseModel _responseModel;
    if(markLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }

    update();
    await Future.delayed(const Duration(seconds: 2), () {
      _responseModel = ResponseModel(true, "success");
      if(markLoad) {
        _loading = false;
      } else {
        _isLoading = false;
      }
    });
    update();
    return _responseModel;
  }

  // Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
  //   if(text.isEmpty) {
  //     Response response = await locationRepo.searchLocation(text);
  //     print("status"+response.statusCode.toString());
  //     // if (response.statusCode == 200&&response.body['status'] == "OK") {
  //     if (response.statusCode == 200) {
  //       print("searchLocation: "+response.body.toString());
  //       _predictionsList = [];
  //       response.body['predictions'].forEach((prediction) {
  //         _predictionsList.add(Prediction.fromJson(prediction));
  //       });
  //     } else {
  //       ApiChecked.checkApi(response);
  //       print("khong the lay dia chi");
  //       print(response.statusText);
  //     }
  //   } else {
  //     _addressList = [];
  //   }
  //   return _predictionsList;
  // }

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    List<Prediction> predictions = [];
    if (text.isNotEmpty) {
      print("text: "+text);
      try {
        List<SearchInfo> locations = await addressSuggestion(text);
        predictions = locations.map((location) {
          return Prediction(
            description: location.address?.toString() ?? 'Unknown address',
            placeId: location.point?.toString() ?? 'Unknown placeId',
          );
        }).toList();
        print("predictions: "+predictions.first.description.toString());
        predictions.forEach((element) {
          print("địa chỉ gợi ý "+element.placeId.toString());
        });

      } catch (e) {
        print("Error: $e");
      }
    }
    return predictions;
  }

  setLocation(String placeId, String? description, GoogleMapController googleMapController) async {
    print("setLocation");
    _updateAddressData = false;
    _loading = true;
    _changeAddress = false;

    update();
    try {
      print("setLocation1");
      print("placeId" + placeId);
      // List<String> placeIdList = placeId.split(",");
      // Loại bỏ ký tự không cần thiết và tách lấy tọa độ
      final regex = RegExp(r"GeoPoint\{latitude:\s*([\d\.\-]+)\s*,\s*longitude:\s*([\d\.\-]+)\s*\}");
      final match = regex.firstMatch(placeId);

      if (match == null || match.groupCount < 2) {
        throw FormatException("Invalid GeoPoint format. Expected 'GeoPoint{latitude: value, longitude: value}'.");
      }
      print("tao do: "+match.group(1).toString()+" "+match.group(2).toString());

      double lat = double.parse(match.group(1).toString());
      double lng = double.parse(match.group(2).toString());
      _pickedPosition = Position(
          latitude: lat,
          longitude: lng,
          timestamp: DateTime.now(),
          heading: 1,
          accuracy: 1,
          altitude: 1,
          speed: 1,
          speedAccuracy: 1
      );

      await getAddressFromLatLng(LatLng(lat, lng));
      // if (fromAddress) {
      //   _placeMark = placeMark;
      // } else {
      //   _pickedPlaceMark = placeMark;
      // }
      _pickedPlaceMark = placeMark;
      _mapController = googleMapController;
      _mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
    } catch (e) {
      print("Error: $e");
    }
    // _changeAddress = false;
    _loading = false;
    update();
  }




}