// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'message.freezed.dart';
part 'message.g.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

@freezed
class Message with _$Message {
    const factory Message({
        String? fromId,
        String? msg,
        String? read,
        String? sent,
        String? toId,
        String? type,
    }) = _Message;

    factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
