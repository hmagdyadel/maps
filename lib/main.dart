import 'package:flutter/material.dart';
import 'package:maps/widget/custom_google_map.dart';

void main() {
  runApp(const RouteTrackerApp());
}

class RouteTrackerApp extends StatelessWidget {
  const RouteTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: GoogleMapView());
  }
}
