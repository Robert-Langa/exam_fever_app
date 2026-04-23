import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewMap extends StatefulWidget {
  final VoidCallback? onMarkerTap;

  const ViewMap({super.key, this.onMarkerTap});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  GoogleMapController? mapController;

  final LatLng currentLocation =
      const LatLng(43.4516, -80.4925); // Kitchener fixed

  final List<Map<String, dynamic>> students = [
    {
      "name": "John Smith",
      "lat": 43.4516,
      "lng": -80.4925,
    },
    {
      "name": "Sarah Johnson",
      "lat": 43.4500,
      "lng": -80.5000,
    },
    {
      "name": "Michael Brown",
      "lat": 43.4550,
      "lng": -80.4800,
    },
  ];

  Set<Marker> _buildMarkers() {
    return students.map((student) {
      return Marker(
        markerId: MarkerId(student['name']),
        position: LatLng(student['lat'], student['lng']),
        infoWindow: InfoWindow(title: student['name']),
        onTap: () {
          if (widget.onMarkerTap != null) {
            widget.onMarkerTap!();
          }
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 13,
      ),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: _buildMarkers(),
      onMapCreated: (controller) {
        mapController = controller;
      },
    );
  }
}
