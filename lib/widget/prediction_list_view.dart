import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../models/place_auto_complete_model/place_auto_complete_model.dart';
import '../models/place_details_model/place_details_model.dart';
import '../utils/google_maps_places_service.dart';

class PredictionListView extends StatelessWidget {
  const PredictionListView({
    super.key,
    required this.places,
    required this.googleMapsPlacesService,
    required this.onPlaceSelect,
  });

  final List<PlaceAutoCompleteModel> places;
  final GoogleMapsPlacesService googleMapsPlacesService;
  final Function(PlaceDetailsModel) onPlaceSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(places[index].description!),
              leading: const Icon(
                FontAwesomeIcons.locationDot,
                color: Colors.grey,
              ),
              trailing: IconButton(
                onPressed: () async {
                  var placeDetails =
                      await googleMapsPlacesService.getPlaceDetails(
                          placeId: places[index].placeId.toString());
                  onPlaceSelect(placeDetails);
                },
                icon: const Icon(FontAwesomeIcons.arrowRight),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: places.length),
    );
  }
}
