import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PageUtil.dart';
import 'package:enuyoung_crawller_flutter/page/InstaAccountSettingPage.dart';
import 'package:enuyoung_crawller_flutter/service/CrawllerService.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:enuyoung_crawller_flutter/util/MyFonts.dart';
import 'package:enuyoung_crawller_flutter/util/MyTheme.dart';
import 'package:page_transition/page_transition.dart';

class ButtonState {
  String label;
  void Function() onPressed;

  ButtonState(this.label, this.onPressed);
}

class NavigationPage extends StatefulWidget {
  static const String staticClassName = "NavigationPage";
  final String className = staticClassName;

  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends KDHState<NavigationPage> {
  late CrawllerService s;
  late List<ButtonState> buttonStateList;

  @override
  Future<void> mustRebuild() async {
    s = CrawllerService.read(context);
    List<ButtonState> buttonStateList = [
      ButtonState("Collect Posts", () async {
        // await s.saveHumorPost();
      }),
      ButtonState("Set My Insta Account", () async {
        await PageUtil.back(context);
        await PageUtil.go(
          context,
          InstaAccountSettingPage(),
          pageTransitionBuilder: (nextPage) => PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 130),
            reverseDuration: const Duration(milliseconds: 130),
            child: nextPage,
          ),
        );
      }),
      ButtonState("Set Target Insta Account", () async {
        await PageUtil.back(context);
      }),
      ButtonState("View BookMarked Post", () async {
        await PageUtil.back(context);
      }),
      ButtonState("Move Auto Like & Follow Page", () async {
        await PageUtil.back(context);
      }),
    ];
    toBuild = () => MyComponents.scaffold(
          body: SizedBox.expand(
            child: Container(
                color: MyTheme.mainColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    closeButton(),
                    Spacer(flex: 2),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buttonStateList
                            .map(
                              (buttonState) => InkWell(
                                child: Text(
                                  buttonState.label,
                                  style: MyFonts.coiny(
                                    fontSize: 17,
                                    height: 2.4,
                                    color: MyTheme.subColor,
                                  ),
                                ),
                                onTap: buttonState.onPressed,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Spacer(flex: 1),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Setting",
                        style: MyFonts.coiny(
                            fontSize: 12, color: MyTheme.subColor),
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                )),
          ),
        );
    rebuild();
  }

  Widget closeButton() {
    return InkWell(
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        child: Icon(Icons.close, color: MyTheme.subColor),
      ),
      onTap: () => PageUtil.back(context),
    );
  }
}
