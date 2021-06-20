import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secret/components/all/click_item.dart';
import 'package:secret/components/app_bar/app_bar.dart' as MyAppBar;
import 'package:secret/components/charts/charts.dart';
import 'package:secret/components/charts/indicator.dart';
import 'package:secret/core/base_widget.dart';

/// description:应用存储
///
/// user: yuzhou
/// date: 2021/6/20
class StoragePage extends StatefulWidget {
  static const String defaultRoute = '/storage';
  const StoragePage({Key? key}) : super(key: key);

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage>
    with TickerProviderStateMixin, BaseWidget {
  final ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  List<PieCharData> pieCharData = [];
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
        body: Stack(children: [
      FutureBuilder(
          future: getData(),
          builder: (context, a) {
            if (a.hasData) return getMainListViewUI();
            return SizedBox(
              child: Text("计算中。。。"),
            );
          }),
      MyAppBar.AppBar(
        animationController: animationController,
        scrollController: scrollController,
        left: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: locale(context).storage,
      ),
      SizedBox(
        height: MediaQuery.of(context).padding.bottom,
      )
    ]));
  }

  getMainListViewUI() {
    return CustomScrollView(
        physics: const ClampingScrollPhysics(),

        ///夹住模式
        controller: scrollController,
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
                height: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top * 2),
            PieChartCustomer(
              pieCharData: pieCharData,
            ),
            ClickItem(
              title: locale(context).clear1,
              child: TextButton(
                onPressed: _clearCache,
                child: Text(
                  locale(context).clear,
                  style: TextStyle(fontSize: 18, backgroundColor: Colors.red),
                ),
              ),
            ),
          ]))
        ]);
  }

  getData() async {
    /// 临时目录，适用于下载的缓存文件，此目录随时可以清除
    ///此目录为应用程序私有目录，其他应用程序无法访问此目录
    ///Android 上对应getCacheDir；iOS上对应NSCachesDirectory

    //print("${await getLibraryDirectory()}"); /Library
    //print("${await getApplicationSupportDirectory()}");/Library/Application Support  比如数据库之类的
    //print("${await getApplicationDocumentsDirectory()}");/Documents 比如图片，文档
    //print("${await getTemporaryDirectory()}");/Library/Caches
    //getExternalStorageDirectory
    //getExternalStorageDirectories
    //getExternalCacheDirectories

    Directory tempDir = await getTemporaryDirectory();

    var a = await _getTotalSizeOfFilesInDir(tempDir);

    if (Platform.isAndroid) {
      var b = await getExternalCacheDirectories();
      b?.forEach((element) async {
        a += await _getTotalSizeOfFilesInDir(element);
      });
    }
    pieCharData.add(PieCharData(
        0,
        Indicator(
          color: const Color(0xff0293ee),
          text: locale(context).storage1 + ':${_renderSize(a)}',
          isSquare: false,
        ),
        PieChartSectionData(
          color: const Color(0xff0293ee),
          value: a,
          title: locale(context).storage1,
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            //color: const Color(0xff044d7c)
          ),
          titlePositionPercentageOffset: 0.55,
        )));

    ///应用程序可以在其中放置应用程序支持文件的目录的路径
    ///将此文件用于您不想向用户公开的文件。 您的应用不应将此目录用于存放用户数据文件
    ///在iOS上，对应NSApplicationSupportDirectory ，如果此目录不存在，则会自动创建。 在Android上，对应getFilesDir
    ///getLibraryDirectory-缓存
    Directory supportDir = await getLibraryDirectory();

    a = await _getTotalSizeOfFilesInDir(supportDir) - a;
    pieCharData.add(PieCharData(
        2,
        Indicator(
          color: const Color(0xfff8b250),
          text: locale(context).support + ':${_renderSize(a)}',
          isSquare: false,
        ),
        PieChartSectionData(
          color: const Color(0xfff8b250),
          value: a,
          title: locale(context).support,
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            //color: const Color(0xff044d7c)
          ),
          titlePositionPercentageOffset: 0.55,
        )));

    ///应用程序可能在其中放置用户生成的数据或应用程序无法重新创建的数据的目录路径
    ///在iOS上，对应NSDocumentDirectory API。 如果数据不是用户生成的，考虑使用[getApplicationSupportDirectory]
    ///在Android上，对应getDataDirectory API。 如果要让用户看到数据，请考虑改用[getExternalStorageDirectory]
    ///到时候存储方式为用户名-images
    ///                  -video
    ///                  -chat
    ///                  -system message
    Directory dataDir = await getApplicationDocumentsDirectory();
    a = await _getTotalSizeOfFilesInDir(dataDir);
    if (Platform.isAndroid) {
      var b = await getExternalStorageDirectories();

      ///可以存储应用程序特定数据的目录的路径。
      b?.forEach((element) async {
        a += await _getTotalSizeOfFilesInDir(element);
      });
    }
    pieCharData.add(PieCharData(
        2,
        Indicator(
          color: const Color(0xff845bef),
          text: locale(context).files + ':${_renderSize(a)}',
          isSquare: false,
        ),
        PieChartSectionData(
          color: const Color(0xff845bef),
          value: a,
          title: locale(context).files,
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            //color: const Color(0xff044d7c)
          ),
          titlePositionPercentageOffset: 0.55,
        )));
    return true;
  }

  // 循环计算文件的大小（递归）
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (!file.existsSync()) return 0;
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();

      double total = 0;

      if (children.isNotEmpty)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  // 递归方式删除目录
  Future<Null> _delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delDir(child);
      }
    }
    await file.delete();
  }

  /// 清理缓存
  ///
  void _clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await _delDir(tempDir);
    //Fluttertoast.showToast(msg: '清除缓存成功');
    setState(() {});
  }

  // 计算大小
  _renderSize(double value) {
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    if (size == '0.00') {
      return '0M';
    }
    return size + unitArr[index];
  }
}
