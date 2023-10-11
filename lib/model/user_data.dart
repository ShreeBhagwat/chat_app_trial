import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  final String? name;
  final String? email;
  final String? password;
  final String? uid;
  final String? timeStamp;
  final String? profilePictureUrl;
  final String? phoneNumber;
  final bool? isOnline;
  final String? bio;

  UserData(
      {required this.name,
      required this.email,
      required this.password,
      required this.uid,
      required this.timeStamp,
      required this.profilePictureUrl,
      required this.phoneNumber,
      required this.isOnline,
      required this.bio});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
