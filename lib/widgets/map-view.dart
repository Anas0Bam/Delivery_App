import 'package:deliver_app/Model/location-model.dart';
import 'package:deliver_app/Service/google-apis.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapView extends StatelessWidget {
  final MapController controller;
  final LocationModel model;

  MapView({required this.controller, required this.model});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: model.initialCameraPosition,
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              onTap: controller.onMapTap,
              markers: model.selectedLocation != null
                  ? {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: model.selectedLocation,
                ),
              }
                  : {},
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
