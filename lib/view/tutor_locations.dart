import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/drawer_scaffold.dart';
import '../core/app_colors.dart';

class TutorLocationsScreen extends StatefulWidget {
  const TutorLocationsScreen({super.key});

  @override
  TutorLocationsScreenState createState() => TutorLocationsScreenState();
}

class TutorLocationsScreenState extends State<TutorLocationsScreen> {
  double initialLatitude = 0.0;
  double initialLongitude = 0.0;
  
  // List of predefined tutor locations (static for demo)
  final List<Map<String, dynamic>> tutorLocations = [
    {
      "name": "Math Tutor - Downtown",
      "latitude": 43.4516,
      "longitude": -80.4925,
      "address": "85 Queen St N, Kitchener, ON",
      "subject": "Mathematics",
      "rating": 4.8,
    },
    {
      "name": "Physics Tutor - Doon",
      "latitude": 43.390808,
      "longitude": -80.410042,
      "address": "299 Doon Valley Dr, Kitchener, ON",
      "subject": "Physics",
      "rating": 4.9,
    },
    {
      "name": "Programming Tutor - Uptown",
      "latitude": 43.4483,
      "longitude": -80.4925,
      "address": "23 King St W, Kitchener, ON",
      "subject": "Computer Science",
      "rating": 4.7,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      setState(() {
        initialLatitude = args['latitude'] ?? 0.0;
        initialLongitude = args['longitude'] ?? 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      title: "Nearby Tutors",
      role: "Tutor",
      body: Column(
        children: [
          // User's location card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.my_location, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Lat: $initialLatitude, Lng: $initialLongitude",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tutor locations list
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tutors Near You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: tutorLocations.length,
              itemBuilder: (context, index) {
                final tutor = tutorLocations[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school, color: AppColors.primary),
                    ),
                    title: Text(
                      tutor['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Subject: ${tutor['subject']}"),
                        Text("⭐ ${tutor['rating']} • ${tutor['address']}"),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward, color: AppColors.primary),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/tutorDetail",
                        arguments: tutor,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}