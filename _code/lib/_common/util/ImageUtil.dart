import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:unsplash_client/unsplash_client.dart';

// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static ListQueue<Photo> photoQueue = ListQueue();

  static Future<Photo> getRandomImage() async {
    final client = UnsplashClient(
      settings: const ClientSettings(
          credentials: AppCredentials(
        accessKey: 'KTg3ugCcSjMTt9v-JTlCWy4Ut9b6k76z8LC_lwTVIoY',
        secretKey: 'z_DHJAdy86GCAJMEu2G-eoBttgJid4cCjhegpchdz8M',
      )),
    );

    if (photoQueue.isEmpty) {
      photoQueue.addAll(await client.photos.random(count: 10).goAndGet());
    }

    return photoQueue.removeFirst();
  }

  // static Future<List<XFile>> chooseMultipleImage({
  //   double? maxWidth,
  //   double? maxHeight,
  //   int? imageQuality,
  // }) async {
  //   return (await ImagePicker().pickMultiImage(
  //         maxWidth: maxWidth,
  //         maxHeight: maxHeight,
  //         imageQuality: imageQuality,
  //       ) ??
  //       []);
  // }

  // static Future<XFile?> chooseImageByGallery({
  //   double? maxWidth,
  //   double? maxHeight,
  //   int? imageQuality,
  // }) async {
  //   return await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: maxWidth,
  //     maxHeight: maxHeight,
  //     imageQuality: imageQuality,
  //   );
  // }

  // static Future<XFile?> chooseImageByCamera({
  //   double? maxWidth,
  //   double? maxHeight,
  //   int? imageQuality,
  // }) async {
  //   return await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     maxWidth: maxWidth,
  //     maxHeight: maxHeight,
  //     imageQuality: imageQuality,
  //   );
  // }

  // static Future<String> getBase64ImageData(XFile imageToUpload) async {
  //   try {
  //     Uint8List imageBytes = await imageToUpload.readAsBytes();
  //     return base64Encode(imageBytes);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Stream<Uint8List> getImageStreamByXFile(XFile imageToUpload) {
  //   try {
  //     return imageToUpload.readAsBytes().asStream();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Stream<Uint8List> getImageStreamByFile(File imageToUpload) {
  //   try {
  //     return imageToUpload.readAsBytes().asStream();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Future<Uint8List> getImageByte(XFile imageToUpload) async {
  //   try {
  //     return await imageToUpload.readAsBytes();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Future<List<int>> resize(XFile imageFile,
  //     {int? maxWidth, int? maxHeight}) async {
  //   int? width;
  //   int? height;
  //   var image = img.decodeImage(await imageFile.readAsBytes())!;
  //   if (image.width > image.height) {
  //     if (maxWidth != null && image.width > maxWidth) {
  //       width = maxWidth;
  //     }
  //   } else {
  //     if (maxHeight != null && image.height > maxHeight) {
  //       height = maxHeight;
  //     }
  //   }

  //   if (width != null || height != null) {
  //     image = img.copyResize(image, width: width, height: height);
  //   }

  //   return img.encodeNamedImage(image, imageFile.name) ?? [];
  // }

// static Future<void> preload(BuildContext context, String fileName) async {
//   await precacheImage(AssetImage("assets/images/$fileName"), context);
// }

// static Widget get({
//   required String assetFilePath,
//   BoxFit fit,
//   double width,
//   double height,
//   EdgeInsetsGeometry margin,
//   EdgeInsetsGeometry padding,
//   AlignmentGeometry alignment,
//   Decoration decoration,
//   Color color,
// }) {
//   Widget widget;
//   widget = Image.asset(
//     "assets/images/$assetFilePath",
//     fit: fit,
//     width: width,
//     height: height,
//   );
//
//   if (margin != null ||
//       padding != null ||
//       decoration != null ||
//       alignment != null ||
//       color != null) {
//     widget = Container(
//         margin: margin,
//         padding: padding,
//         alignment: alignment,
//         decoration: decoration,
//         color: color,
//         child: widget);
//   }
//
//   return widget;
// }
//
// static Widget getUrl(String url, {
//   BoxFit fit,
//   double width,
//   double height,
//   bool useLoadingCircular = false,
//   EdgeInsetsGeometry margin,
//   EdgeInsetsGeometry padding,
//   AlignmentGeometry alignment,
//   Decoration decoration,
//   Color color,
// }) {
//   Widget widget;
//   widget = CachedNetworkImage(
//     fit: fit,
//     width: width,
//     height: height,
//     imageUrl: url,
//     placeholder: useLoadingCircular
//         ? ((context, url) =>  AppComponents.loadingWidget())
//         : null,
//     errorWidget: (context, url, error) => Icon(Icons.error),
//   );
//
//   if (margin != null ||
//       padding != null ||
//       decoration != null ||
//       alignment != null ||
//       color != null) {
//     widget = Container(
//         margin: margin,
//         padding: padding,
//         alignment: alignment,
//         decoration: decoration,
//         color: color,
//         child: widget);
//   }
//
//   return widget;
// }
}
