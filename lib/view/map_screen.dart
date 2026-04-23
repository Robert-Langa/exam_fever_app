import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/drawer_scaffold.dart';
import '../core/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  String locationMessage = "Location not retrieved yet...";
  Position? currentPosition;

  // Check whether location services are enabled
  Future<void> getLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;
    
    if (!isServiceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get current device location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
      locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  void viewTutorLocations() {
    if (currentPosition != null) {
      Navigator.pushNamed(context, "/tutorLocations", arguments: {
        "latitude": currentPosition!.latitude,
        "longitude": currentPosition!.longitude,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please get your location first!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      title: "Tutor Locations",
      role: "Tutor",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Find Tutors Near You",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text(
                locationMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: getLocation,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Get Location", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: viewTutorLocations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("View Tutors", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}