import 'package:json_annotation/json_annotation.dart';

/// description: model类的基本类
///
/// user: yuzhou
/// date: 2021/6/21
part 'base_entity.g.dart';

@JsonSerializable()
class BaseEntity {
  BaseEntity();

  ///创建者
  String? createBy;

  ///创建时间
  DateTime? createTime;

  ///更新者
  String? updateBy;

  ///更新时间
  DateTime? updateTime;

  ///备注
  String? remark;

  @override
  String toString() {
    return 'BaseEntity{createBy: $createBy, createTime: $createTime, updateBy: $updateBy, updateTime: $updateTime, remark: $remark}';
  }

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);
}
