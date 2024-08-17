import 'package:flutter/material.dart';

// 登入頁面
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/todolist"); // 點擊跳轉至待辦清單頁面
          },
          child: Text(
            "TODO_LIST 登入",
            style: TextStyle(fontSize: 24), // 設置字體大小
          ),
        ),
      ),
    );
  }
}
