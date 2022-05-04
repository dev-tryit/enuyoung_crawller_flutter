import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:enuyoung_crawller_flutter/util/MyFonts.dart';
import 'package:enuyoung_crawller_flutter/util/MyTheme.dart';

class InstaAccountSettingPage extends StatelessWidget {
  static const String staticClassName = "InstaAccountSettingPage";
  final String className = staticClassName;

  const InstaAccountSettingPage({Key? key}) : super(key: key);

  static const TextStyle textStyle = TextStyle(color: MyTheme.mainColor);
  static const InputDecoration inputBoxDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    errorStyle: TextStyle(color: MyTheme.mainColor),
  );

  @override
  Widget build(BuildContext context) {
    bool isKeyboardUp = MediaQuery.of(context).viewInsets.bottom>0;

    return MyComponents.scaffold(
      appBar: AppBar(
        title: Text("Set My Insta Account", style: MyFonts.coiny()),
        backgroundColor: MyTheme.subColor,
        foregroundColor: MyTheme.mainColor,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            MyComponents.inputBox(
              label: "Insta ID",
              textStyle: textStyle,
              decoration: inputBoxDecoration,
            ),
            const SizedBox(height: 25),
            MyComponents.inputBox(
              label: "Insta PW",
              textStyle: textStyle,
              obscureText: true,
              decoration: inputBoxDecoration,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(bottom: isKeyboardUp?45:0), //TODO: 음... 어떻게 키보드 위에 위젯을 위치시키는지 방법 찾아야함.
        child: ElevatedButton(
          child: const Text("저장"),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            primary: MyTheme.mainColor,
            onPrimary: MyTheme.subColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
