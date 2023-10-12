import 'package:json_annotation/json_annotation.dart';
part 'message_data.g.dart';

@JsonSerializable()
class Message {
  final String? messageBody;
  final String? senderUid;
  final String? senderEmail;
  final String? timeStamp;
  final String? receiverUid;

  Message(
      {required this.messageBody,
      required this.senderUid,
      required this.senderEmail,
      required this.timeStamp,
      required this.receiverUid});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
