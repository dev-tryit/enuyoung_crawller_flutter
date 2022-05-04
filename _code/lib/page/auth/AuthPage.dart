import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:enuyoung_crawller_flutter/MySetting.dart';
import 'package:enuyoung_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:enuyoung_crawller_flutter/_common/util/LogUtil.dart';
import 'package:enuyoung_crawller_flutter/_common/widget/EasyFade.dart';
import 'package:enuyoung_crawller_flutter/state/auth/AuthState.dart';
import 'package:enuyoung_crawller_flutter/util/MyComponents.dart';
import 'package:enuyoung_crawller_flutter/util/MyFonts.dart';
import 'package:enuyoung_crawller_flutter/util/MyTheme.dart';

class AuthPage extends StatefulWidget {
  static const String staticClassName = "AuthPage";
  final String className = staticClassName;
  final Widget nextPage;

  const AuthPage({Key? key, required this.nextPage}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends KDHState<AuthPage> {
  late AuthPageService s;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool emailTextFieldEnabled = true;
  String? emailValidationText = "인증 요청";
  String? nextButtonText;
  Color emailValidationColor = Colors.black;

  List<Widget> elementList = [];

  static const InputDecoration inputBoxDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyTheme.mainColor),
    ),
    errorStyle: TextStyle(color: MyTheme.mainColor),
  );

  @override
  Future<void> mustRebuild() async {
    s = AuthPageService(this);
    toBuild = () {
      final authState = s.authStateManager.authState;
      setUIByAuthState(authState);

      return MyComponents.scaffold(
        bottomSheet: nextButtonText != null
            ? AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 1500),
                child: Container(
                  height: 82,
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                  child: SizedBox.expand(
                    child: ElevatedButton(
                      child: Text(nextButtonText!),
                      style:
                          ElevatedButton.styleFrom(primary: MyTheme.mainColor),
                      onPressed: s.loginOrRegister,
                    ),
                  ),
                ),
              )
            : null,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 36),
                Text(
                  MySetting.appName,
                  style: MyFonts.coiny(
                    fontSize: 27,
                    color: MyTheme.mainColor,
                  ),
                ),
                const SizedBox(height: 69),
                MyComponents.inputBox(
                  label: "이메일",
                  trailing: emailValidationText,
                  trailingColor: emailValidationColor,
                  onTrailingTap: s.sendEmailVerification,
                  controller: emailController,
                  textFieldEnabled: emailTextFieldEnabled,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return "이메일 형식이 아닙니다.";
                    }
                    return null;
                  },
                  onChanged: (value) => _formKey.currentState?.validate(),
                  decoration: inputBoxDecoration,
                ),
                ...elementList
              ],
            ),
          ),
        ),
      );
    };
    rebuild();
  }

  void setUIByAuthState(AuthState authState) {
    // 상태별 위젯 상태 변경.
    if (authState is AuthStateNeedVerification) {
      emailValidationText = "인증 확인";
      emailTextFieldEnabled = false;
      emailValidationColor = Colors.black;
      nextButtonText = null;
    } else if (authState is AuthStateSendEmail) {
      emailValidationText = "인증 요청";
      emailTextFieldEnabled = true;
      emailValidationColor = Colors.black;
      nextButtonText = null;
    } else if (authState is AuthStateLogin) {
      emailValidationText = null;
      emailTextFieldEnabled = false;
      emailValidationColor = Colors.black;
      nextButtonText = "로그인";
    } else if (authState is AuthStateRegistration) {
      emailValidationText = null;
      emailTextFieldEnabled = false;
      emailValidationColor = Colors.black;
      nextButtonText = "회원가입";
    }

    // 상태별 위젯 배치.
    elementList.clear();
    if (authState is AuthStateLogin) {
      elementList.addAll([
        const SizedBox(height: 30),
        EasyFade(
          afterAFewMilliseconds: 500,
          child: MyComponents.inputBox(
            label: "비밀번호",
            controller: passwordController,
            onChanged: (value) => _formKey.currentState?.validate(),
            obscureText: true,
            decoration: inputBoxDecoration,
          ),
        ),
      ]);
    } else if (authState is AuthStateRegistration) {
      elementList.addAll([
        const SizedBox(height: 30),
        EasyFade(
          afterAFewMilliseconds: 500,
          child: MyComponents.inputBox(
            label: "비밀번호",
            controller: passwordController,
            onChanged: (value) => _formKey.currentState?.validate(),
            obscureText: true,
            decoration: inputBoxDecoration,
          ),
        ),
        const SizedBox(height: 30),
        EasyFade(
          afterAFewMilliseconds: 1000,
          child: MyComponents.inputBox(
            label: "비밀번호 확인",
            controller: passwordConfirmController,
            onChanged: (value) => _formKey.currentState?.validate(),
            obscureText: true,
            decoration: inputBoxDecoration,
          ),
        ),
      ]);
    }
  }
}

class AuthPageService {
  AuthStateManager authStateManager;
  _AuthPageState state;

  BuildContext get context => state.context;

  void rebuild() => state.setState(() {});

  AuthPageService(this.state) : authStateManager = AuthStateManager(state);

  void sendEmailVerification() async {
    LogUtil.debug(
        "sendEmailVerification authStateManager.authState:${authStateManager.authState.runtimeType}");

    String email = state.emailController.text.trim();

    await MyComponents.showLoadingDialog(context);
    if (authStateManager.authState is AuthStateSendEmail) {
      await authStateManager.handle({'email': email, 'context': context});
    } else if (authStateManager.authState is AuthStateNeedVerification) {
      await authStateManager.handle({'email': email, 'context': context});
    }
    await MyComponents.dismissLoadingDialog();
    rebuild();
  }

  void loginOrRegister() async {
    LogUtil.debug(
        "loginOrRegister authStateManager.authState:${authStateManager.authState.runtimeType}");

    String email = state.emailController.text.trim();
    String password = state.passwordController.text.trim();

    var nextPage = state.widget.nextPage;

    if (authStateManager.authState is AuthStateLogin) {
      await authStateManager.authState.handle({
        'email': email,
        'password': password,
        'nextPage': nextPage,
        'context': context,
      });
    } else if (authStateManager.authState is AuthStateRegistration) {
      String passwordConfirm = state.passwordConfirmController.text.trim();
      await authStateManager.handle({
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'nextPage': nextPage,
        'context': context,
      });
    } else {
      MyComponents.toastError(
        context,
        "loginOrRegister에 에러가 있습니다. 회원가입, 로그인 상태가 아닙니다.",
      );
    }
  }
}
