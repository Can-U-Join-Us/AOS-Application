import 'dart:io';

import 'package:canyoujoinus/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var _isLoading = false;

  Future<void> _submit() async {
    if (formKey.currentState!.validate() == false) {
      return;
    } else {
      formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await Provider.of<AuthProvider>(context, listen: false).login();
      setState(() {
        _isLoading = false;
      });
      if (Provider.of<AuthProvider>(context, listen: false).isAuth) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("로그인에 성공하였습니다."),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "로그인",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("images/initial_4.png"),
                ),
                Container(
                  padding: const EdgeInsets.only(top : 10, bottom: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "계정 이메일을 입력해주세요.",
                        ),
                        validator: (value) {
                          if (value!.length < 10) {
                            return "이메일 형식에 맞게 입력해주세요!";
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "비밀번호를 입력해주세요.",
                          ),
                          validator: (value) {
                            if (value!.length < 10) {
                              return "비밀번호는 10자 이상입니다.";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: CircularProgressIndicator(),
                      )
                    : FlatButton(
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: Text("로그인",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        onPressed: () {
                          _submit();
                        },
                      ),
                FlatButton(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "이메일 또는 비밀번호를 잊으셨나요?",
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
