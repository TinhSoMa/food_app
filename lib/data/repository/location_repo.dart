import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  // Future<Response> getAddressFromGeocode(LatLng latLng) async {
  //   return await apiClient.getData(
  //       "${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}");
  // }


  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }
  //addAddress

  Future<Response> addUserAddress(AddressModel addressModel) async {
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveAddress(String address) async {
    print("save address: "+address);
    apiClient.updateHeaders(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  void clearLocation() {
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
  }

  // Future<Response> getZone(String lat, String lng) async {
  //   return await apiClient.getData("${AppConstants.ZONE_URI}?lat=$lat&lng=$lng");
  }

  // Future<Response> searchLocation(String query) async {
  //   return await apiClient.getData("${AppConstants.SEARCH_LOCATION_URI}?search_text=$query");
  // }
