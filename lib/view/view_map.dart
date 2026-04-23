import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../core/app_colors.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  GoogleMapController? mapController;
  LatLng? currentPosition;
  String locationStatus = "Getting location...";
  bool isLoading = true;

  // Student locations with coordinates
  final List<Map<String, dynamic>> studentLocations = [
    {
      "name": "John Smith",
      "latitude": 43.4516,
      "longitude": -80.4925,
      "subject": "Mathematics",
      "question": "Need help with calculus",
      "distance": "0.5 km",
    },
    {
      "name": "Sarah Johnson",
      "latitude": 43.390808,
      "longitude": -80.410042,
      "subject": "Physics",
      "question": "Struggling with quantum mechanics",
      "distance": "1.2 km",
    },
    {
      "name": "Michael Brown",
      "latitude": 43.4483,
      "longitude": -80.4925,
      "subject": "Programming",
      "question": "Dart and Flutter help needed",
      "distance": "0.8 km",
    },
    {
      "name": "Emily Davis",
      "latitude": 43.4650,
      "longitude": -80.5200,
      "subject": "Chemistry",
      "question": "Organic chemistry doubts",
      "distance": "2.0 km",
    },
  ];

  // Set of markers to display on map
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get tutor's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationStatus = "Location services are disabled.";
        isLoading = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationStatus = "Location permissions are denied.";
          isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationStatus = "Location permissions are permanently denied.";
        isLoading = false;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      locationStatus = "Found ${studentLocations.length} students near you!";
      isLoading = false;
      _buildMarkers();
    });
  }

  // Build markers for all student locations
  void _buildMarkers() {
    Set<Marker> markers = {};

    // Add student markers
    for (int i = 0; i < studentLocations.length; i++) {
      final student = studentLocations[i];
      markers.add(
        Marker(
          markerId: MarkerId('student_$i'),
          position: LatLng(student['latitude'], student['longitude']),
          infoWindow: InfoWindow(
            title: student['name'],
            snippet: "${student['subject']} - ${student['question']}",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          onTap: () {
            _showStudentDetails(student);
          },
        ),
      );
    }

    // Add tutor's current location marker
    if (currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('tutor_location'),
          position: currentPosition!,
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'You are here',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  // Show student details in bottom sheet when marker tapped
  void _showStudentDetails(Map<String, dynamic> student) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.person, size: 35, color: AppColors.primary),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        student['subject'],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.help_outline, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Question: ${student['question']}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Text("Distance: ${student['distance']} away"),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Request sent to ${student['name']}")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Help This Student",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Animate camera to show all markers
  void _showAllMarkers() {
    if (studentLocations.isEmpty || currentPosition == null) return;

    double minLat = currentPosition!.latitude;
    double maxLat = currentPosition!.latitude;
    double minLng = currentPosition!.longitude;
    double maxLng = currentPosition!.longitude;

    for (var student in studentLocations) {
      minLat = minLat < student['latitude'] ? minLat : student['latitude'];
      maxLat = maxLat > student['latitude'] ? maxLat : student['latitude'];
      minLng = minLng < student['longitude'] ? minLng : student['longitude'];
      maxLng = maxLng > student['longitude'] ? maxLng : student['longitude'];
    }

    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat - 0.05, minLng - 0.05),
          northeast: LatLng(maxLat + 0.05, maxLng + 0.05),
        ),
        50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (currentPosition == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              locationStatus,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Location status bar
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  locationStatus,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.my_location, color: AppColors.primary),
                onPressed: _getCurrentLocation,
              ),
              IconButton(
                icon: const Icon(Icons.zoom_out_map, color: AppColors.primary),
                onPressed: _showAllMarkers,
              ),
            ],
          ),
        ),

        // Google Map
        Expanded(
          child: GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 12.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),
        ),
      ],
    );
  }
}