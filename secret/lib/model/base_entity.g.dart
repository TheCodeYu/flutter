// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEntity _$BaseEntityFromJson(Map<String, dynamic> json) {
  return BaseEntity()
    ..createBy = json['createBy'] as String?
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..updateBy = json['updateBy'] as String?
    ..updateTime = json['updateTime'] == null
        ? null
        : DateTime.parse(json['updateTime'] as String)
    ..remark = json['remark'] as String?;
}

Map<String, dynamic> _$BaseEntityToJson(BaseEntity instance) =>
    <String, dynamic>{
      'createBy': instance.createBy,
      'createTime': instance.createTime?.toIso8601String(),
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime?.toIso8601String(),
      'remark': instance.remark,
    };
