import 'package:flutter/material.dart';
import 'package:flutter_todo_hw/controller/screen_controller.dart';
import 'package:flutter_todo_hw/screens/login_screen.dart';
import 'package:flutter_todo_hw/screens/todo_list_screen.dart';

// 應用程式入口
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ScreenController screenController = ScreenController(); // 屏幕控制器

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": (BuildContext context) => LoginScreen(), // 登入頁面路由
        "/todolist": (BuildContext context) => TodoListScreen() // 待辦清單頁面路由
      },
      initialRoute: screenController.ExchangeScreen(), // 根據登入狀態設置初始頁面
    );
  }
}
