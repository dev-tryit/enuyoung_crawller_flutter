import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enuyoung_crawller_flutter/_common/interface/Type.dart';
import 'package:enuyoung_crawller_flutter/repository/PostUrlRepository.dart';
import 'package:provider/provider.dart';

class PostUrlService extends ChangeNotifier {
  BuildContext context;
  PostUrlService(this.context);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<PostUrlService>(
          create: (context) => PostUrlService(context));
  static Widget consumer({required ConsumerBuilderType<PostUrlService> builder}) => Consumer<PostUrlService>(builder: builder);
  static PostUrlService read(BuildContext context) => context.read<PostUrlService>();

  Future<List<PostUrl>> getPostUrlList() async {
    return await PostUrlRepository.me.getList();
  }
  Future<List> getMediaUrlList() async {
    List mediaUrlList = [];
    List<PostUrl> postUrlList = await getPostUrlList();
    for (var element in postUrlList) {
      mediaUrlList.addAll(element.mediaUrlList ?? []);
    }

    return mediaUrlList;
  }
}
