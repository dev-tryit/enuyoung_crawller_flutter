import 'dart:async';

import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:enuyoung_crawller_flutter/service/PostUrlService.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';

class PostListViewPage extends StatefulWidget {
  static const String staticClassName = "PostListViewPage";
  final String className = staticClassName;


  @override
  _PostListViewPageState createState() => _PostListViewPageState();
}

class _PostListViewPageState extends KDHState<PostListViewPage> {

  @override
  Future<void> mustRebuild() async {
    List mediaUrlList = await PostUrlService.read(context)
        .getMediaUrlList();
    toBuild = () => MyComponents.scaffold(
            body: ListView(
          children: mediaUrlList
              .map((e) => Image.network(e.toString()))
              .toList(),
        ));
    rebuild();
  }
}
