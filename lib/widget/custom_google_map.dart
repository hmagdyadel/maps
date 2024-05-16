import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/utils/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  late LocationService locationService;
  bool isFirstCall = true;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(27.496421512039905, 30.794674329709746),
      zoom: 1,
    );
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
          // initMapStyle();
        },
        initialCameraPosition: initialCameraPosition,
      ),
      Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            child: const Text('Change Location'),
            onPressed: () {},
          ))
    ]);
  }

  void getLocationData() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      setMyLocationCamera(position);
      setMyLocationMarker(position!);
    });
  }

  void setMyLocationCamera(Position? position) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position!.latitude, position.longitude), zoom: 17);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(position!.latitude, position.longitude)));
    }
  }

  void setMyLocationMarker(Position position) {
    var myLocationMarker = Marker(
        markerId: const MarkerId('my_location_marker'),
        position: LatLng(position.latitude, position.longitude));
    markers.add(myLocationMarker);
    setState(() {});
  }

  void updateMyLocation() async {
    var hasPermission = await locationService.checkAndRequestLocationService();
    if (hasPermission) {
      getLocationData();
    }
  }
}
