import 'package:permission_handler/permission_handler.dart';

/// description:权限管理
///
/// user: yuzhou
/// date: 2021/6/13
///需要的权限
const _permission = [
  Permission.camera,
  Permission.location,
//  Permission.locationAlways,
  Permission.locationWhenInUse,
  Permission.mediaLibrary, //如果不在info.plist中声明，会直接崩溃
  Permission.microphone,
  Permission.photos,
  Permission.storage,
  Permission.notification,
];

/// 用来第一次安装app时获取全部权限
Future<int> requestAllPermission() async {
  int i = 0;
  Map<Permission, PermissionStatus> permissions =
      await PermissionListActions(_permission).request();

  permissions.forEach((key, value) {
    if (value != PermissionStatus.granted) {
      i++;
    }
  });
  return i;
}
