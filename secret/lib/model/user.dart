import 'package:json_annotation/json_annotation.dart';
import 'package:secret/model/base_entity.dart';

/// description:用户信息
///
/// user: yuzhou
/// date: 2021/6/20
part 'user.g.dart';

@JsonSerializable()
class User extends BaseEntity {
  int? userId;

  int? deptId;

  String? userName;

  String? nickName;

  String? email;

  String? phonenumber;

  String? sex;

  String? avatar;

  String? salt;

  String? status;

  String? delFlag;

  String? loginIp;

  DateTime? loginDate;

  User();

  @override
  String toString() {
    return super.toString() +
        'User{userId: $userId, deptId: $deptId, userName: $userName, nickName: $nickName, email: $email, phonenumber: $phonenumber, sex: $sex, avatar: $avatar, salt: $salt, status: $status, delFlag: $delFlag, loginIp: $loginIp, loginDate: $loginDate}';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
