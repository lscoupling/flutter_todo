import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';

// TodoDaoLocalFile類別，用於處理本地檔案的讀寫操作
class TodoDaoLocalFile {
  // 取得本地文件路徑
  Future<String> GetLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 取得本地文件
  Future<File> GetLocalFile() async {
    final path = await GetLocalPath();
    return File('$path/todo.json');
  }

  // 讀取本地的待辦事項清單
  Future<List<Todo>> readTodos() async {
    try {
      final file = await GetLocalFile();
      final contents = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((json) => Todo.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  // 將待辦事項清單寫入到本地文件
  Future<File> writeTodos(List<Todo> todos) async {
    final file = await GetLocalFile();
    return file.writeAsString(
        jsonEncode(todos.map((todo) => todo.toJson()).toList()));
  }
}
