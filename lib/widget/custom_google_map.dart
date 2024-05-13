import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(27.496421512039905, 30.794674329709746),
      zoom: 12,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
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

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');
    googleMapController.setMapStyle(nightMapStyle);
  }
}
// zoom range
// world view     0 - 3
// country view   4 - 6
// city view      10 - 12
// street view    13 - 17
// building view  18 - 20
