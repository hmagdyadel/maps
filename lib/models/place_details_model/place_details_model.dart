import 'address_component.dart';
import 'geometry.dart';

class PlaceDetailsModel {
  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? icon;
  String? internationalPhoneNumber;
  String? name;
  String? placeId;
  double? rating;
  List<dynamic>? types;
  String? url;
  String? website;

  PlaceDetailsModel({
    this.addressComponents,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.internationalPhoneNumber,
    this.name,
    this.placeId,
    this.rating,
    this.types,
    this.url,
    this.website,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      addressComponents: (json['address_components'] as List<dynamic>?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      formattedAddress: json['formatted_address'] as String?,
      formattedPhoneNumber: json['formatted_phone_number'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      icon: json['icon'] as String?,
      internationalPhoneNumber: json['international_phone_number'] as String?,
      name: json['name'] as String?,
      placeId: json['place_id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      types: json['types'] as List<dynamic>?,
      url: json['url'] as String?,
      website: json['website'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'address_components':
            addressComponents?.map((e) => e.toJson()).toList(),
        'formatted_address': formattedAddress,
        'formatted_phone_number': formattedPhoneNumber,
        'geometry': geometry?.toJson(),
        'icon': icon,
        'international_phone_number': internationalPhoneNumber,
        'name': name,
        'place_id': placeId,
        'rating': rating,
        'types': types,
        'url': url,
        'website': website,
      };
}
