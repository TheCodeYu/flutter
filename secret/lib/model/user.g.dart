// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..createBy = json['createBy'] as String?
    ..createTime = json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String)
    ..updateBy = json['updateBy'] as String?
    ..updateTime = json['updateTime'] == null
        ? null
        : DateTime.parse(json['updateTime'] as String)
    ..remark = json['remark'] as String?
    ..userId = json['userId'] as int?
    ..deptId = json['deptId'] as int?
    ..userName = json['userName'] as String?
    ..nickName = json['nickName'] as String?
    ..email = json['email'] as String?
    ..phonenumber = json['phonenumber'] as String?
    ..sex = json['sex'] as String?
    ..avatar = json['avatar'] as String?
    ..salt = json['salt'] as String?
    ..status = json['status'] as String?
    ..delFlag = json['delFlag'] as String?
    ..loginIp = json['loginIp'] as String?
    ..loginDate = json['loginDate'] == null
        ? null
        : DateTime.parse(json['loginDate'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createBy': instance.createBy,
      'createTime': instance.createTime?.toIso8601String(),
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime?.toIso8601String(),
      'remark': instance.remark,
      'userId': instance.userId,
      'deptId': instance.deptId,
      'userName': instance.userName,
      'nickName': instance.nickName,
      'email': instance.email,
      'phonenumber': instance.phonenumber,
      'sex': instance.sex,
      'avatar': instance.avatar,
      'salt': instance.salt,
      'status': instance.status,
      'delFlag': instance.delFlag,
      'loginIp': instance.loginIp,
      'loginDate': instance.loginDate?.toIso8601String(),
    };
