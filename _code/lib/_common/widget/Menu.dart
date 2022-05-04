import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/util/MyColors.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';

class MenuColor {
  final Color highlightColor;
  final Color normalColor;
  const MenuColor(this.highlightColor, this.normalColor);
}

abstract class MenuItem {
  final MenuColor menuColor;
  final ValueNotifier isClick;
  final ValueNotifier iconColor;

  void click() {
    isClick.value = true;
    setColor(menuColor.highlightColor);
  }

  void unclick() {
    isClick.value = false;
    setColor(menuColor.normalColor);
  }

  void setColor(Color color) {
    iconColor.value = color;
  }

  MenuItem(this.menuColor)
      : isClick = ValueNotifier(false),
        iconColor = ValueNotifier(menuColor.normalColor);
}

class Menu<T extends MenuItem> extends StatefulWidget {
  final List<T> itemList;
  final Widget Function(T item) itemWidgetBuilder;
  final Widget Function(List<Widget> itemWidgetList) menuWidgetBuilder;
  const Menu({
    Key? key,
    required this.itemList,
    required this.itemWidgetBuilder,
    required this.menuWidgetBuilder,
  }) : super(key: key);

  @override
  _MenuState<T> createState() => _MenuState<T>();
}

class _MenuState<T extends MenuItem> extends State<Menu<T>> {
  List<Widget> itemWidgetList = [];

  @override
  void initState() {
    itemWidgetList.clear();
    for (var item in widget.itemList) {
      itemWidgetList.add(widget.itemWidgetBuilder(item));
      item.isClick.addListener(() {
        if (!item.isClick.value) return;

        for (var element in widget.itemList) {
          if (element != item) {
            element.unclick();
          }
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.menuWidgetBuilder(itemWidgetList);
  }
}
