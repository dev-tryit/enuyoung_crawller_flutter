import 'package:card_swiper/card_swiper.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:enuyoung_crawller_flutter/_common/extension/RandomExtension.dart';
import 'package:enuyoung_crawller_flutter/_common/util/PageUtil.dart';
import 'package:enuyoung_crawller_flutter/page/NavigationPage.dart';
import 'package:enuyoung_crawller_flutter/repository/PostUrlRepository.dart';
import 'package:enuyoung_crawller_flutter/service/PostUrlService.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:enuyoung_crawller_flutter/util/MyFonts.dart';
import 'package:enuyoung_crawller_flutter/util/MyImage.dart';
import 'package:enuyoung_crawller_flutter/util/MyTheme.dart';

class MainPage extends StatefulWidget {
  static const String staticClassName = "MainPage";
  final String className = staticClassName;

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends KDHState<MainPage> {
  List<PostUrl> postUrlList = [];

  @override
  Future<void> mustRebuild() async {
    postUrlList = await PostUrlService.read(context).getPostUrlList();

    toBuild = () {
      return MyComponents.scaffold(
        body: Container(
          color: MyTheme.mainColor,
          alignment: Alignment.center,
          child: Column(
            children: [
              appBar(),
              Expanded(child: scrollView()),
            ],
          ),
        ),
      );
    };
    rebuild();
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Insta Manager",
                style: MyFonts.coiny(
                  fontSize: 28,
                  height: 1.0,
                  color: MyTheme.subColor,
                ),
              ),
              Spacer(),
              InkWell(
                child: Image(
                  width: 16,
                  height: 20,
                  image: MyImage.notesIcon,
                  fit: BoxFit.contain,
                ),
                onTap: moveNavigationPage,
              ),
              SizedBox(width: 26),
            ],
          ),
          Divider(thickness: 1.3, color: MyTheme.subColor),
        ],
      ),
    );
  }

  Widget scrollView() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top:34),
        child: Column(
          children: postUrlList.map((postUrl) => instaCardGroup(postUrl)).toList(),
        ),
      ),
    );
  }

  Widget instaCardGroup(PostUrl postUrl) {
    List mediaUrlList = (postUrl.mediaUrlList ?? []);
    String emojiChar = Emoji.byGroup(EmojiGroup.smileysEmotion).toList().getRandomElement().char;
    print("instaCardGroup mediaUrlList:$mediaUrlList");

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18, right: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Text(emojiChar),
                  SizedBox(width: 5),
                  Text(postUrl.instaUserId??""),
                  SizedBox(width: 5),
                  InkWell(
                    child: Image(
                      width: 18,
                      height: 18,
                      image: MyImage.downloadsIcon,
                      fit: BoxFit.fill,
                    ),
                    onTap: (){
                      print("downloadsIcon click");
                    },
                  )
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 215,
                child: Swiper(
                  itemCount: mediaUrlList.length,
                  itemBuilder: (BuildContext context, int i) {
                    String mediaUrl = mediaUrlList[i];
                    return Image.network(
                      mediaUrl,
                      fit: BoxFit.fill,
                    );
                  },
                  itemWidth: 300.0,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ],
          ),
        ),
        Divider(endIndent: 94),
      ],
    );
  }

  void moveNavigationPage() {
    PageUtil.go(context, NavigationPage());
  }
}
