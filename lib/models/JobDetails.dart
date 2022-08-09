import 'package:flutter/foundation.dart';

class JobDetails {
  String id;
  String title;
  String image;
  String price;
  String description;
  String userid;
  String lon;
  String lat;
  String location;
  double? distance;

  JobDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.userid,
    required this.location,
    required this.lon,
    required this.lat,
    this.distance
  });

  factory JobDetails.fromjson(Map response) {
    return JobDetails(
      id: response['id'],
      title: response["title"],
      image: response["image"],
      price: response["price"],
      description: response["description"],
      userid: response["userid"],
      location: response['location'],
      lat: response['lat'],
      lon: response['lon'],
    );
  }
}
