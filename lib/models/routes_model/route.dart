import 'polyline.dart';

class Route {
  int? distanceMetres;
  String? duration;
  Polyline? polyline;

  Route({this.distanceMetres, this.duration, this.polyline});

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        distanceMetres: json['distanceMetres'] as int?,
        duration: json['duration'] as String?,
        polyline: json['polyline'] == null
            ? null
            : Polyline.fromJson(json['polyline'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'distanceMetres': distanceMetres,
        'duration': duration,
        'polyline': polyline?.toJson(),
      };
}
