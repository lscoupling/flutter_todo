import '../models/todo.dart';
import '../daos/todo_dao_local_file.dart';
import '../daos/user_dao_local_file.dart';

// WorkNoteService類別，用於處理與待辦事項相關的業務邏輯
class WorkNoteService {
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile(); // 待辦事項數據訪問對象
  final UserDaoLocalFile _userDao = UserDaoLocalFile(); // 使用者數據訪問對象

  // 新增待辦事項
  Future<void> addTodo(Todo todo) async {
    final todos = await _todoDao.readTodos();
    todos.add(todo);
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    user.totalTodos++;
    await _userDao.writeUser(user);
  }

  // 刪除待辦事項
  Future<void> deleteTodoAtIndex(int index) async {
    final todos = await _todoDao.readTodos();
    final todo = todos[index];
    todos.removeAt(index);
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    user.totalTodos--;
    if (todo.isComplete == true) {
      user.completeTodos--;
    }
    await _userDao.writeUser(user);
  }

  // 更新待辦事項的狀態
  Future<void> updateTodoStatus(int index, String status) async {
    final todos = await _todoDao.readTodos();
    final todo = todos[index];
    todo.isComplete;
    if (todo.isComplete == true) {
      todo.creationTime = DateTime.now();
    }
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    if (todo.isComplete == true) {
      user.completeTodos++;
    } else if (todo.isComplete == false) {
      user.completeTodos--;
    }
    await _userDao.writeUser(user);
  }
}
