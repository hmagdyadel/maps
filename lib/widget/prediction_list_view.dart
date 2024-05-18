import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/place_auto_complete_model/place_auto_complete_model.dart';

class PredictionListView extends StatelessWidget {
  const PredictionListView({
    super.key,
    required this.places,
  });

  final List<PlaceAutoCompleteModel> places;

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
                onPressed: () {},
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
