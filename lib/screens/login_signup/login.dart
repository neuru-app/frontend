import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparcs_2024_frontend/screens/login_signup/signup.dart';
import '../../service/api.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  String userId = "";

  final TextEditingController userPwController = TextEditingController();
  String userPw = "";

  @override
  void initState() {
    super.initState();

    // TextEditingController에 리스너를 추가하여 입력 값 변경 시 userId 변수 업데이트.
    userIdController.addListener(() {
      setState(() {
        userId = userIdController.text;
      });
    });
    userPwController.addListener(() {
      setState(() {
        userPw = userPwController.text;
      });
    });
  }

  @override
  void dispose() {
    // 사용이 끝나면 TextEditingController를 dispose.
    userIdController.dispose();
    userPwController.dispose();
    super.dispose();
  }

  // 로그인 버튼 클릭 시 호출될 함수
  Future<void> _login() async {
    // API URL을 정의합니다.
    const String url = '/api/user/login';

    // 요청에 포함할 데이터를 정의합니다.
    Map<String, dynamic> data = {
      'userid': userId,
      'password': userPw,
    };

    // httpPOST 함수를 호출하여 데이터를 전송합니다.
    final response = await httpPost(path: url, data: data);

    if (response == 200) {
      // 로그인 성공 시 처리
      Get.to(() => MainPage());
    } else {
      // 로그인 실패 시 처리
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // 2초 후에 다이얼로그 닫기
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text('로그인 실패'),
              content: Text('아이디 및 비밀번호 오류'),
            );
          },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
                'lib/assets/images/back_img.png',
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*(6/7),
                height: MediaQuery.of(context).size.height*(6/7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'lib/assets/images/logo_black.png',
                          width: (MediaQuery.of(context).size.width) * (3 / 4),
                          height: (MediaQuery.of(context).size.width) * (1 / 4),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          key: const ValueKey(3),
                          controller: userIdController, // TextFormField에 controller를 설정.
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: "아이디 입력",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'NanumSquareNeo',
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          key: const ValueKey(4),
                          controller: userPwController, // TextFormField에 controller를 설정.
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: "비밀번호 입력",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontFamily: 'NanumSquareNeo',
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  _login(); // 로그인 함수 호출
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color.fromRGBO(139, 117, 181, 1.0),
                                    padding: EdgeInsets.symmetric(vertical: 15), // 버튼 높이 조정
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45), // 모서리를 둥글게 설정
                                    )),
                                child: const Text(
                                  '로그인',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'NanumSquareNeo',
                                  ),
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(SignupPage());
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                        color: Color.fromRGBO(139, 117, 181, 1.0)),
                                    padding: EdgeInsets.symmetric(vertical: 15), // 버튼 높이 조정
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45), // 모서리를 둥글게 설정
                                    )),
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'NanumSquareNeo',
                                  ),
                                ),
                              )),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
