import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/place_auto_complete_model/place_auto_complete_model.dart';
import '../models/place_details_model/place_details_model.dart';

class GoogleMapsPlacesService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyAwXg784QDgFZv6hyzRi9pboIocW_4Pbdo';

  Future<List<PlaceAutoCompleteModel>> getPredictions(
      {required String input}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/autocomplete/json?input=$input&key=$apiKey'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['predictions'];
      List<PlaceAutoCompleteModel> places = [];
      for (var item in data) {
        places.add(PlaceAutoCompleteModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception();
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
    var response = await http
        .get(Uri.parse('$baseUrl/details/json?place_id=$placeId&key=$apiKey'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];

      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
