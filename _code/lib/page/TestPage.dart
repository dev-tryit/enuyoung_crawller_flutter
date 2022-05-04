import 'package:enuyoung_crawller_flutter/_local/local.dart';
import 'package:enuyoung_crawller_flutter/service/CrawllerService.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrawllerService.consumer(
      builder: (BuildContext context, CrawllerService service, Widget? child) =>
          Scaffold(
        body: Column(
          children: [
            ElevatedButton(onPressed: () {
              service.login(localData["id"],localData["pw"]);
            }, child: Text("에듀코 로그인")),
          ],
        ),
      ),
    );
  }
}
