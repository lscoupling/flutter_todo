// User類別，用於描述使用者的屬性
class User {
  int totalTodos; // 待辦事項的總數
  int completeTodos; // 已完成的待辦事項數量

  // User類別的建構子
  User({
    required this.totalTodos,
    required this.completeTodos,
  });

  // 從JSON格式創建User物件
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      totalTodos: json["totalTodos"],
      completeTodos: json["completeTodos"],
    );
  }

  // 將User物件轉換為JSON格式
  Map<String, dynamic> toJson() {
    return {"totalTodos": totalTodos, "completeTodos": completeTodos};
  }
}
