import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/interface/Type.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PageUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PuppeteerUtil.dart';
import 'package:enuyoung_crawller_flutter/page/PostListViewPage.dart';
import 'package:enuyoung_crawller_flutter/repository/InstaUserRepository.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:provider/provider.dart';

class CrawllerService extends ChangeNotifier {
  final PuppeteerUtil p;
  final Duration delay;
  final Duration timeout;

  BuildContext context;

  CrawllerService(this.context)
      : this.p = PuppeteerUtil(),
        this.delay = const Duration(milliseconds: 25),
        this.timeout = Duration(seconds: 20);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<CrawllerService>(
          create: (context) => CrawllerService(context));

  static Widget consumer(
          {required ConsumerBuilderType<CrawllerService> builder}) =>
      Consumer<CrawllerService>(builder: builder);

  static CrawllerService read(BuildContext context) =>
      context.read<CrawllerService>();

  void saveHumorPost() async {
    // await p.startBrowser(headless: false, width: 1280, height: 1024);
    //
    // await login(idController.text, pwController.text);
    // await turnOffAlarmDialog;
    //
    //
    // String instaUserId = "inssa_unni_";
    // List<String> postUrlList = await getPostUrlList(instaUserId);
    //
    // for (String postUrl in postUrlList) {
    //   if (await PostUrlRepository.me.getOneByUrl(postUrl) != null) continue;
    //
    //   List<String> mediaStrList =
    //   await getMediaStrListOf(postUrl: postUrl);
    //   var postUrlObj = PostUrl(
    //       instaUserId: instaUserId, url: postUrl, mediaUrlList: mediaStrList);
    //   await PostUrlRepository.me.save(postUrl: postUrlObj);
    // }
    //
    //
    // await p.stopBrowser();
  }

  Future<InstaUser?> getInstaUser() async {
    return await InstaUserRepository.me.getOne();
  }

  Future<void> saveInstaUser(String id, String pw) async {
    try {
      await InstaUserRepository.me.save(instaUser: InstaUser(id: id, pw: pw));
      MyComponents.snackBar(context, "저장 성공하였습니다.");
    } catch (e) {
      MyComponents.snackBar(context, "저장 실패하였습니다.");
    }
  }

  void goPostListViewPage() async {
    PageUtil.go(context, PostListViewPage());
  }

  /*

    await login(id, pw);
    await visitAccountAndGetPostLink();
    await saveInfoAboutPost();
   */

  Future<void> login(String? id, String? pw) async {
    await p.startBrowser(headless: false, width: 1280, height: 1024);

    const String idSelector = '#_mem_id';
    const String pwSelector = '#_mem_pw';
    const String loginSelector = '[name="btn_search"]';
    const String loginPageUrl = "https://erp.educo.co.kr/";
    for (int i = 0; i < 5; i++) {
      await p.goto(loginPageUrl);
      if (await _isLoginSuccess()) {
        LogUtil.debug("[$id] 로그인 성공하였습니다.");
        break;
      }

      LogUtil.debug("[$id] 로그인에 실패하였습니다.");
      await p.type(idSelector, id ?? "", delay: delay);
      await p.type(pwSelector, pw ?? "", delay: delay);
      await p.clickAndWaitForNavigation(loginSelector, timeout: timeout);

      // if (await p.existTag('#slfErrorAlert')) {
      //   LogUtil.debug(
      //       "[$id] 로그인에 실패하였습니다. 원인 : ${await p.text(tag: await p.$('#slfErrorAlert'))}");
      //   break;
      // }
    }


    //secuNumStr1의 부모 th.의 text를 보면, 앞자리인지 뒷자리인지 알 수 있음,secuNumStr1로 어떤 번호인지도 알 수 있음
    //secuNumStr3도 같음.

    //secuNum2 넣는곳.
    //secuNum4
    //document.querySelector('#secuNum2').setValue('12')
    // document.querySelector('a.check').click()
    //다이어로그 확인

    await p.stopBrowser();
  }

  Future<bool> _isLoginSuccess() async {
    bool isLoginPage = await p.existTag('[name="loginForm"]');
    return !isLoginPage;
  }

  Future<void> saveInfoAboutPost() async {
    //Post 내용 저장.
  }

  Future<void> turnOffAlarmDialog() async {
    bool existAlarmDialog = await p.existTag(
        'img[src="/static/images/ico/xxhdpi_launcher.png/99cf3909d459.png"]');
    LogUtil.debug("turnOffAlarmDialog existAlarmDialog : $existAlarmDialog");
    if (existAlarmDialog) {
      await p.click('[role="dialog"] button:nth-child(2)');
    }
  }

  Future<List<String>> getPostUrlList(String targetId) async {
    await p.goto("https://www.instagram.com/$targetId");
    if (!await isTargetIdPage(targetId)) return [];

    return (await Future.wait((await p.$$('a[href^="/p"]')).map(
            (elementHandle) => p.getAttr(tag: elementHandle, attr: "href"))))
        .map((e) => "https://www.instagram.com$e")
        .toList();
  }

  Future<bool> isTargetIdPage(String targetId) async {
    const String selector = '[role="tablist"] > a[aria-selected="true"]';

    bool valid = await p.existTag(selector);

    String contents = await p.text(tag: await p.$(selector));
    LogUtil.debug("해당 TargetId($targetId)의 contents : $contents");

    valid = contents.contains("게시물") || contents.contains("Posts");
    LogUtil.debug("해당 TargetId($targetId)로 이동에 ${valid ? "성공" : "실패"}하였습니다.");

    return valid;
  }

  Future<List<String>> getMediaStrListOf({required String postUrl}) async {
    await p.goto("https://sssinstagram.com/ko");
    await p.type('#main_page_text', postUrl, delay: delay);
    await p.click('#submit');

    //응답 올때까지 기다리기
    await p.waitForSelector('#response');
    return await Future.wait(
      (await p.$$(
              '#response > .graph-sidecar-wrapper  div.download-wrapper > a:nth-child(1)'))
          .map(
        (el) => p.getAttr(tag: el, attr: 'href'),
      ),
    );
  }
//
// Future<void> _deleteRequest(ElementHandle tag) async {
//   await p.click('.quote-btn.del', tag: tag);
//   await p.click('.swal2-confirm.btn');
// }
//
// Future<void> _sendRequests(ElementHandle tag) async {
//   //요청보러들어가기
//   await tag.click();
//   await p.waitForNavigation();
//
//   //불러오기
//   await p.click('.quote-tmpl-icon.arrow');
//   await p.click('.item-list .item-short:nth-child(1)');
//   await p.click('.action-btn-wrap');
//   await p.click('.swal2-confirm.btn');
//
//   //견적보내기
//   await p.waitForSelector('.file-wrap .delete');
//   await p.evaluate(
//       "document.querySelector('.btn.btn-primary.btn-block').click();");
// }
//
// Future<void> _deleteAndSendRequests() async {
//   LogUtil.info("_deleteAndSendRequests 시작");
//
//   Future<bool> refreshAndExitIfShould() async {
//     await p.goto('https://soomgo.com/requests/received');
//     await p.reload();
//     await p.autoScroll();
//     bool existSelector =
//         await p.waitForSelector('.request-list > li > .request-item');
//     if (!existSelector) {
//       return true;
//     }
//     return false;
//   }
//
//   Future<List<ElementHandle>> getTagList() async =>
//       await p.$$('.request-list > li > .request-item');
//
//   Map<String, int> keywordMap = {};
//   while (true) {
//     if (await refreshAndExitIfShould()) break;
//     List<ElementHandle> tagList = await getTagList();
//     if (tagList.isEmpty) break;
//
//     var tag = tagList[0];
//     var messageTag = await p.$('.quote > span.message', tag: tag);
//     String message = await p.html(tag: messageTag);
//
//     Future<Map<String, int>> countKeyword(String message) async {
//       Map<String, int> keywordMap = {};
//       for (var eachWord in message.trim().split(",")) {
//         eachWord = eachWord.trim();
//         if (!keywordMap.containsKey(eachWord)) {
//           keywordMap[eachWord] = 0;
//         }
//         keywordMap[eachWord] = keywordMap[eachWord]! + 1;
//       }
//       LogUtil.info("keywordMap: $keywordMap");
//       return keywordMap;
//     }
//
//     keywordMap.addAll(await countKeyword(message));
//
//     await decideMethod(
//       message,
//       () async => await _sendRequests(tag),
//       () async => await _deleteRequest(tag),
//     );
//   }
//
//   Future<void> saveFirestore(Map<String, int> keywordMap) async {
//     for (var entry in keywordMap.entries) {
//       String eachWord = entry.key;
//       int count = entry.value;
//
//       KeywordItem? keywordItem =
//           await KeywordItemRepository().getKeywordItem(keyword: eachWord);
//       if (keywordItem == null) {
//         await KeywordItemRepository().add(
//           keywordItem: KeywordItem(
//             keyword: eachWord,
//             count: count,
//           ),
//         );
//       } else {
//         await KeywordItemRepository().update(
//           keywordItem
//             ..keyword = eachWord
//             ..count = ((keywordItem.count ?? 0) + count),
//         );
//       }
//     }
//   }
//
//   await saveFirestore(keywordMap);
// }
//
// Future<void> decideMethod(String message, Future<void> Function() send,
//     Future<void> Function() delete) async {
//
//   //아래 키워드가 있으면 바로 메시지 보낸다.
//   for (String toIncludeAlways in listToIncludeAlways) {
//     if (message.toLowerCase().contains(toIncludeAlways.toLowerCase())) {
//       await send();
//       return;
//     }
//   }
//
//   //아래 조건이 모두 포함되면 메시지를 보낸다.
//   List<String> listToIncludeForOr =
//       listToInclude.where((element) => element.contains("||")).toList();
//   List<String> listToIncludeForAnd =
//       listToInclude.where((element) => !element.contains("||")).toList();
//
//   //아래 조건에 해당하는게 없다면, 제거 대상.
//   bool isValid = true;
//   for (String toIncludeForAnd in listToIncludeForAnd) {
//     if (!message.toLowerCase().contains(toIncludeForAnd.toLowerCase())) {
//       LogUtil.info(
//           "condition1 message:$message, toIncludeForAnd:$toIncludeForAnd");
//       isValid = false;
//       break;
//     }
//   }
//   //아래 조건에 해당하는게 없다면, 제거 대상.
//   //1개 조건에 대해 A||B||C일 때, 메시지가 A or B or C에 해당하는게 없다면, 제거 대상
//   for (String toIncludeForOr in listToIncludeForOr) {
//     List<String> orStrList = toIncludeForOr.split("||").toList();
//     bool existOr = orStrList
//         .where(
//             (orStr) => message.toLowerCase().contains(orStr.toLowerCase()))
//         .isNotEmpty;
//     if (!existOr) {
//       LogUtil.info("condition2 message:$message, orStrList:$orStrList");
//       isValid = false;
//       break;
//     }
//   }
//   //이 키워드가 있으면, 제거대상
//   for (String toExclude in listToExclude) {
//     if (message.toLowerCase().contains(toExclude.toLowerCase())) {
//       LogUtil.info("condition3 message:$message, toExclude:$toExclude");
//       isValid = false;
//       break;
//     }
//   }
//
//   if (isValid) {
//     LogUtil.info("decideMethod send message:$message");
//     await send();
//   } else {
//     LogUtil.info("decideMethod delete message:$message");
//     await delete();
//   }
// }
}
