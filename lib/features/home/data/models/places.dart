import 'package:cloud_firestore/cloud_firestore.dart';

class Places{
  String placeName;
  List<String> placeType;
  String placeWorkingTime;
  String placeAddress;
  String placeDescription;
  String placeImageUrl;
  GeoPoint placeGeoPoint;

  Places({required this.placeName,
              required this.placeType,
              required this.placeWorkingTime,
              required this.placeAddress,
              required this.placeDescription,
              required this.placeImageUrl,
              required this.placeGeoPoint
  });

  static Places fromJson(Map<String, dynamic> json) =>
      Places(
        placeName: json['name'],
        placeType: List.from(json['type']),
        placeWorkingTime: json['working_time'],
        placeAddress: json['address'],
        placeDescription: json['description'],
        placeImageUrl: json['url'],
        placeGeoPoint: json['geopoint'],
      );

  toJson(){
    return {
      'address': placeAddress,
      'description': placeDescription,
      'geopoint': placeGeoPoint,
      'name': placeName,
      'type': placeType,
      'url': placeImageUrl,
      'working_time': placeWorkingTime
    };
  }

}
