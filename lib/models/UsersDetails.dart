import 'package:project2/screens/user_details.dart';

class UserDetails {
  String user_id;
  String user_name;
  String user_bio;
  List<String> user_skills;
  String imagelink;

  UserDetails(
      {required this.user_id,
      required this.user_name,
      required this.user_bio,
      required this.user_skills,
      required this.imagelink});

  factory UserDetails.fromjson(Map response) {
    return UserDetails(
        user_id: response['id'],
        user_name: response["title"],
        user_bio: response["image"],
        user_skills: response["price"],
        imagelink: response['image']);
  }
}
