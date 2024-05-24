import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/place_auto_complete_model/place_auto_complete_model.dart';
import '../utils/google_maps_places_service.dart';
import '../utils/location_service.dart';
import 'custom_text_field.dart';
import 'prediction_list_view.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;
  Set<Marker> markers = {};
  late LocationService locationService;
  bool isFirstCall = true;
  late GoogleMapsPlacesService googleMapsPlacesService;
  List<PlaceAutoCompleteModel> places = [];
  String? sessionToken;

  late Uuid uuid;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0),
    );
    locationService = LocationService();
    googleMapsPlacesService = GoogleMapsPlacesService();
    textEditingController = TextEditingController();
    fetchPredictions();
    uuid = const Uuid();
    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(() async {
      sessionToken ??= uuid.v4();
      if (textEditingController.text.isNotEmpty) {
        var result = await googleMapsPlacesService.getPredictions(
          input: textEditingController.text,
          sessionToken: sessionToken!,
        );
        places.clear();
        places.addAll(result);
        setState(() {});
      } else {
        places.clear();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            updateCurrentLocation();
          },
        ),
        Positioned(
          top: 5,
          right: 16,
          left: 16,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              const SizedBox(height: 10),
              PredictionListView(
                places: places,
                googleMapsPlacesService: googleMapsPlacesService,
                onPlaceSelect: (placeDetailsModel) {
                  textEditingController.clear();
                  sessionToken = null;
                  places.clear();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
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
      //   // TO DO
      // } on LocationPermissionException catch (e) {
      //   // TO DO
    } catch (e) {
      // TO DO
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

// text field
// listen the entry of the text field
// search place
// display results
// create route between my location and the place
