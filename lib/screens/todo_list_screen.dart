import 'package:flutter/material.dart';
import 'package:flutter_todo_hw/daos/todo_dao_local_file.dart';
import 'package:flutter_todo_hw/daos/user_dao_local_file.dart';
import 'package:flutter_todo_hw/models/todo.dart';
import 'package:flutter_todo_hw/models/user.dart';
import '../service/work_note_service.dart';
import 'package:intl/intl.dart';

// 待辦清單頁面，使用StatefulWidget以便畫面能夠更新
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile(); // 本地文件數據訪問對象
  final UserDaoLocalFile _userDao = UserDaoLocalFile(); // 本地文件數據訪問對象
  final WorkNoteService _workNoteService = WorkNoteService(); // 處理待辦事項的服務

  final TextEditingController _controller = TextEditingController(); // 文字輸入框控制器

  List<Todo> _todos = []; // 待辦清單
  User _user = User(totalTodos: 0, completeTodos: 0); // 使用者資料

  @override
  void initState() {
    super.initState();
    _loadData(); // 初始化時載入本地數據
  }

  Future<void> _loadData() async {
    final todos = await _todoDao.readTodos(); // 讀取本地待辦清單
    final user = await _userDao.readUser(); // 讀取本地使用者數據
    setState(() {
      _todos = todos;
      _user = user;
    });
  }

  // 新增待辦事項
  void _addTodo() async {
    final description = _controller.text;
    if (description.isNotEmpty) {
      final newTodo = Todo(
        isComplete: false,
        content: description,
        creationTime: DateTime.now(),
      );
      setState(() {
        _todos.add(newTodo);
        _user.totalTodos++;
      });
      _workNoteService.addTodo(newTodo); // 新增待辦事項到本地文件
      _controller.clear(); // 清空輸入框
    }
  }

  // 刪除待辦事項
  void _deleteTodo(int index) async {
    if (_todos[index].isComplete) {
      _user.completeTodos--;
    }
    setState(() {
      _todos.removeAt(index);
      _user.totalTodos--;
    });
    _workNoteService.deleteTodoAtIndex(index); // 從本地文件中刪除待辦事項
  }

  // 切換待辦事項的完成狀態
  void _toggleTodoStatus(int index) async {
    final todo = _todos[index];
    setState(() {
      if (todo.isComplete) {
        todo.isComplete = false;
        todo.finishTime = null;
        _user.completeTodos--;
      } else {
        todo.isComplete = true;
        todo.finishTime = DateTime.now();
        _user.completeTodos++;
      }
    });
    await _todoDao.writeTodos(_todos); // 更新待辦清單到本地文件
    await _userDao.writeUser(_user); // 更新使用者數據到本地文件
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('待辦清單'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '輸入待辦項目',
                      ),
                      onSubmitted: (value) => _addTodo(), // 按下Enter鍵新增待辦項目
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: Text('新增項目'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  final creationTimeFormatted = DateFormat('yyyy-MM-dd – kk:mm:ss')
                      .format(todo.creationTime);
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.content,
                          style: TextStyle(
                            decoration: todo.isComplete
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Text(
                          '新增時間: $creationTimeFormatted',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: todo.isComplete,
                      onChanged: (_) => _toggleTodoStatus(index), // 切換完成狀態
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTodo(index), // 刪除待辦事項
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Text(
                  '項目總數: ${_user.totalTodos}, 已完成: ${_user.completeTodos}項'),
            ),
          ],
        ),
      ),
    );
  }
}
