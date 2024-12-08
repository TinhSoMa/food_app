import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController googleMapController;


  const LocationDialogue({super.key, required this.googleMapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      padding: EdgeInsets.all(Dimension.width10),
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.radius15),
        ),
        child: SizedBox(
          width: Dimension.screenWidth,
          child: SingleChildScrollView(  // Thêm SingleChildScrollView ở đây
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "Search location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimension.radius15),
                    borderSide: const BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimension.font_size20,
                  ),
                  contentPadding: EdgeInsets.all(Dimension.width10),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await Get.find<LocationController>().searchLocation(context, pattern);
              },
              itemBuilder: (BuildContext context, Prediction suggestion) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: Dimension.height10, horizontal: Dimension.width10),
                  child: Row(

                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                        size: Dimension.radius20,
                      ),
                      SizedBox(width: Dimension.width10),
                      Expanded(
                        child: Text(
                          suggestion.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                            fontSize: Dimension.font_size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onSuggestionSelected: (suggestion) async {
                 await Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description, googleMapController);
                 Get.back();
              },
            ),
          ),
        ),
      ),

    );
  }
}
