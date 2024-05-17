import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/utils/location_service.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  late LocationService locationService;
  bool isFirstCall = true;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0),
    );
    locationService = LocationService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initialCameraPosition,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
        updateCurrentLocation();
      },
    );
  }

// stream data
//   void getLocationData() {
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 2,
//     );
//     Geolocator.getPositionStream(locationSettings: locationSettings)
//         .listen((Position? position) {
//       setMyLocationCamera(position);
//       setMyLocationMarker(position!);
//     });
//   }

  // void setMyLocationCamera(Position? position) {
  //   if (isFirstCall) {
  //     CameraPosition cameraPosition = CameraPosition(
  //         target: LatLng(position!.latitude, position.longitude), zoom: 17);
  //     googleMapController
  //         ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //     isFirstCall = false;
  //   } else {
  //     googleMapController.animateCamera(CameraUpdate.newLatLng(
  //         LatLng(position!.latitude, position.longitude)));
  //   }
  // }

  // void updateMyLocation() async {
  //   await locationService.checkAndRequestLocationService();
  //   getLocationData();
  // }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      LatLng currentPosition =
          LatLng(locationData.latitude, locationData.longitude);
      CameraPosition myCurrentCameraPosition =
          CameraPosition(target: currentPosition, zoom: 16);
      Marker currentLocationMarker = Marker(
        markerId: const MarkerId('myLocation'),
        position: currentPosition,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentCameraPosition),
      );
      markers.add(currentLocationMarker);
      setState(() {});
    // } on LocationServiceException catch (e) {
    //   // TODO
    // } on LocationPermissionException catch (e) {
    //   // TODO
    } catch (e) {
      // TODO
    }
  }

  void setMyLocationMarker(Position position) {
    var myLocationMarker = Marker(
        markerId: const MarkerId('my_location_marker'),
        position: LatLng(position.latitude, position.longitude));
    markers.add(myLocationMarker);
    setState(() {});
  }
}



// text field =>   search for place
// listen the entry of the text field
// create route between my location and the place
