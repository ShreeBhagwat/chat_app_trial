// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      messageBody: json['messageBody'] as String?,
      senderUid: json['senderUid'] as String?,
      senderEmail: json['senderEmail'] as String?,
      timeStamp: json['timeStamp'] as String?,
      receiverUid: json['receiverUid'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageBody': instance.messageBody,
      'senderUid': instance.senderUid,
      'senderEmail': instance.senderEmail,
      'timeStamp': instance.timeStamp,
      'receiverUid': instance.receiverUid,
    };
