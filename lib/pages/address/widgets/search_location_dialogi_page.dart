import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController googleMapController;


  const LocationDialogue({super.key, required this.googleMapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.radius15),
        ),
        child: SizedBox(
          width: Dimension.screenWidth,
          child: Container(
            child: Text("search location"),
          ),
        ),
      ),
    );
  }
}
