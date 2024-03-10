// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_detail.freezed.dart';
part 'user_detail.g.dart';

List<UserDetail> userDetailFromJson(String str) => List<UserDetail>.from(json.decode(str).map((x) => UserDetail.fromJson(x)));

String userDetailToJson(List<UserDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@freezed
class UserDetail with _$UserDetail {
    const factory UserDetail({
        String? image,
        String? name,
        String? about,
        String? created_at,
        bool? isOnline,
        String? id,
        String? last_active,
        String? push_token,
        String? email,
    }) = _UserDetail;

    factory UserDetail.fromJson(Map<String, dynamic> json) => _$UserDetailFromJson(json);
}
