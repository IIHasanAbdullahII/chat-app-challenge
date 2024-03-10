// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDetailImpl _$$UserDetailImplFromJson(Map<String, dynamic> json) =>
    _$UserDetailImpl(
      image: json['image'] as String?,
      name: json['name'] as String?,
      about: json['about'] as String?,
      created_at: json['created_at'] as String?,
      isOnline: json['isOnline'] as bool?,
      id: json['id'] as String?,
      last_active: json['last_active'] as String?,
      push_token: json['push_token'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$UserDetailImplToJson(_$UserDetailImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'about': instance.about,
      'created_at': instance.created_at,
      'isOnline': instance.isOnline,
      'id': instance.id,
      'last_active': instance.last_active,
      'push_token': instance.push_token,
      'email': instance.email,
    };
