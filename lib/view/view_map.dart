import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../core/app_colors.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  ViewMapState createState() => ViewMapState();
}

class ViewMapState extends State<ViewMap> {
  String locationMessage = "Fetching student locations...";
  Position? currentPosition;

  // List of student locations (simulated data)
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

  @override
  void initState() {
    super.initState();
    _getTutorLocation();
  }

  // Get tutor's current location
  Future<void> _getTutorLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!isServiceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled.";
      });
      return;
    }

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

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
      locationMessage = "Found ${studentLocations.length} students near you!";
    });
  }

  void _viewStudentDetails(Map<String, dynamic> student) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
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
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.person, size: 35, color: AppColors.primary),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name'],
                        style: TextStyle(
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
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.help_outline, color: AppColors.primary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Question: ${student['question']}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  SizedBox(width: 10),
                  Text("Distance: ${student['distance']} away"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Request sent to ${student['name']}")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location status card
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: AppColors.primary.withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      locationMessage,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: AppColors.primary),
                    onPressed: _getTutorLocation,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Student locations list
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Students Near You",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 8),

        Expanded(
          child: ListView.builder(
            itemCount: studentLocations.length,
            itemBuilder: (context, index) {
              final student = studentLocations[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  title: Text(
                    student['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Subject: ${student['subject']}"),
                      Text("📍 ${student['distance']} away • ${student['question']}"),
                    ],
                  ),
                  trailing: Icon(Icons.chat, color: AppColors.secondary),
                  onTap: () => _viewStudentDetails(student),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}