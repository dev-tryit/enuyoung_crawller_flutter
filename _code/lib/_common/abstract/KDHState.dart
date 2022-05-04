import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';

abstract class KDHState<TargetWidget extends StatefulWidget>
    extends State<TargetWidget> {
  //호출순서 : mustRebuild->rebuild(Function? afterBuild);


  @override
  void initState() {
    // LogUtil.debug("super.initState");
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // LogUtil.debug("super.prepareRebuild");
      if (buildedWidgets.isNotEmpty) {
        _getSizeOfWidgetList();
      }

      await mustRebuild();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool existToBuild = toBuild != null;
    if (existToBuild) {
      return toBuild!();
    }

    return Stack(
      children: [
        ...(buildedWidgets.isNotEmpty
            ? buildedWidgets.values.map((w) => Opacity(
                  opacity: 0,
                  child: w.make(),
                ))
            : []),
        loadingWidget(),
      ],
    );
  }

  //1. UI의 크기를 미리 재기 위해 사용되는 구조
  //widgetsToBuild 재정의하면, buildedWidgets 결과가 도출된다.
  //buildedWidgets 결과
  /*
  [
    WidgetToGetSize("maxContainer", maxContainerToGetSize)
  ];
  */
  List<WidgetToGetSize> widgetsToBuild() => [];
  Map<dynamic, WidgetToGetSize> buildedWidgets = {};
  void _getSizeOfWidgetList() {
    buildedWidgets.clear();
    for (var e in widgetsToBuild()) {
      e.calculateSize();
      buildedWidgets[e.key] = e;
    }
  }

  //2. 유연한 빌드
  //mustRebuild에서 toBuild를 채우고 반드시 rebuild해야 한다.
  //rebuild 할 때 afterBuild를 지정하면, 후 작업을 지정할 수 있다.
  Widget Function()? toBuild;
  Future<void> mustRebuild();
  void rebuild({Function? afterBuild}) {
    if (afterBuild != null) {
      //build 때, afterBuild 불리도록 요청.
      WidgetsBinding.instance?.addPostFrameCallback((_) => afterBuild());
    }

    //Flutter는 중간에 state를 제거해놓기도 한다. 추후에 build로 다시 생성하지만..
    //이 때, setState가 불리면, 에러가 발생한다. 따라서, mounted 여부 체크가 필요하다.
    if (!mounted) return;

    setState(() {});
  }

  //3. 로딩위젯
  Widget loadingWidget() {
    return MyComponents.scaffold(body: Center(child: MyComponents.loadingWidget()));
  }
}
