//
// import 'dart:async';
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:enuyoung_crawller_flutter/util/CrawllerService.dart';
//
// void main() {
// /*
// https://pub.dev/packages/test
// test
// 테스트에 대한 설명과 실제 테스트 코드를 적습니다.
// 시간 제한(timeout) 이나 테스트 환경 (브라우저, OS) 등도 적어줄 수 있습니다.
//
// expect
// expect(실제값, 기대값)
// 테스트의 기대값과 실제값을 비교합니다.
// 다른 언어의 assert 와 동일하다고 보시면 됩니다.
//
// setup
// 테스트를 시작하기 전에 설정을 해줍니다.
// 테스트 단위 하나마다 실행됩니다. ( test() 함수 하나가 테스트 단위 하나에요. 한 파일에 여러 test() 가 있으면 여러번 실행됩니다. )
//
// setupAll
// 테스트 시작하기 전에 설정을 해줍니다.
// 파일 하나에 한번만 실행됩니다. (데이터 베이스 설정할 때 쓰기 좋겠죠)
//
// teardown
// 테스트를 마치고 할 작업을 정해줍니다.
// 테스트 단위 하나마다 실행됩니다 ( setup() 함수랑 동일합니다 )
//
// teardownAll()
// 테스트를 마치고 할 작업을 정해줍니다.
// 파일 하나에 한번만 실행됩니다. ( setupAll() 함수랑 동일합니다 )
// */
//
//   final List<String> listToIncludeAlways = ["플루터", "Flutter"];
//   final List<String> listToInclude =  ["앱 개발", "관련 지식 없음", "취미/자기개발", "이른 오전 (9시 이전)||오전 (9~12시)||늦은 저녁 (9시 이후)", "개인 레슨||온라인/화상 레슨||무관"];
//   final List<String> listToExclude =["미취학 아동", "초등학생", "중학생", "고등학생", "swift", "kotlin", "스위프트", "코틀린", "자바", "java"];
//   var function = MyCrawller(listToIncludeAlways: listToIncludeAlways,listToExclude: listToExclude, listToInclude: listToInclude).decideMethod;
//
//   group('MyCrawller 테스트', () {
//     test('always 1개(true)', () {
//       const String message="flutter";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//     test('always 1개, include 1개(true)', () {
//       const String message="flutter, 오전 (9~12시) ";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//     test('always 1개, exclude 1개(true)', () {
//       const String message="flutter, 자바 스크립트 ";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 1개(false)', () {
//       const String message="취미/자기개발 ";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//     test('include 1개, exclude 1개(false)', () {
//       const String message="관련 지식 없음 , 자바 스크립트 ";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 모두 포함하지 않음 (false)', () { //시간이 빠졌는데 통과함...
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발 ";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 모두 포함하지 않음 (false)', () {
//       String message="취미/자기개발, 관련 지식 없음, 앱 개발, 이른 오전 (9시 이전)";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//     test('include 모두 포함안함 (false)', () {
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발, 무관";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 모두 포함 (true)', () {
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발, 늦은 저녁 (9시 이후), 무관";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 모두 포함 (true)', () {
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발, 이른 오전 (9시 이전), 개인 레슨";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('include 모두 포함, exclude 1개 (false)', () {
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발, 이른 오전 (9시 이전), 개인 레슨, 자바";
//
//       bool isSent = false;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('always 1개, include 모두 포함, exclude 1개 (true)', () {
//       const String message="취미/자기개발, 관련 지식 없음, 앱 개발, 이른 오전 (9시 이전), 개인 레슨, 자바, 플루터";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     test('always 1개, include 1개, exclude 1개(true)', () {
//       const String message="플루터, Flutter, 앱 개발합니다, 고등학생";
//
//       bool isSent = true;
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//
//
//     test('include 1개, exclude 1개(false)', () {
//       const String message="앱 개발합니다, 고등학생";
//       bool isSent = false;
//
//       var testFuture = Future(() {
//         var completer = Completer();
//         function(message, () async {
//           completer.complete(true);
//         },() async {
//           completer.complete(false);
//         });
//
//         return completer.future;
//
//       });
//       expect(testFuture, completion(isSent));
//     });
//
//     // test('value should be incremented', () {
//     //   final counter = Counter();
//     //
//     //   counter.increment();
//     //
//     //   expect(counter.value, 1);
//     // });
//     //
//     // test('value should be decremented', () {
//     //   final counter = Counter();
//     //
//     //   counter.decrement();
//     //
//     //   expect(counter.value, -1);
//     // });
//   });
// }
// /*
//
//       expect(FieldValidator.validateEmail(email2), true , reason: '# is a not valid character');
//  */
// /*
// //Future의 값은 아래처럼 completion을 써야 비교 가능하다.
// void main() {
//   test('new Future.value() returns the value with completion', () {
//     var value = Future.value(10);
//     expect(value, completion(10));
//   });
// }
//  */