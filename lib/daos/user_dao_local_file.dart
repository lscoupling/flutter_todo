import 'dart:convert';
import 'dart:io';
import 'package:flutter_todo_hw/models/user.dart';
import 'package:path_provider/path_provider.dart';

// UserDaoLocalFile類別，用於處理本地檔案的讀寫操作
class UserDaoLocalFile {
  // 取得本地文件路徑
  Future<String> GetLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 取得本地文件
  Future<File> GetLocalFile() async {
    final path = await GetLocalPath();
    return File('$path/user.json');
  }

  // 讀取本地的使用者數據
  Future<User> readUser() async {
    try {
      final file = await GetLocalFile();
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      return User.fromJson(jsonData);
    } catch (e) {
      return User(totalTodos: 0, completeTodos: 0);
    }
  }

  // 將使用者數據寫入到本地文件
  Future<File> writeUser(User user) async {
    final file = await GetLocalFile();
    return file.writeAsString(jsonEncode(user.toJson()));
  }
}
