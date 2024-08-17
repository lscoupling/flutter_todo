// Todo類別，用於描述每個待辦事項的屬性和行為
class Todo {
  bool isComplete; // 判斷待辦事項是否完成
  String content; // 待辦事項的內容
  DateTime creationTime; // 待辦事項的創建時間
  DateTime? finishTime; // 待辦事項的完成時間，允許為null

  // Todo類別的建構子
  Todo({
    required this.isComplete,
    required this.content,
    required this.creationTime,
    this.finishTime,
  });

  // 從JSON格式創建Todo物件
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      isComplete: json["isComplete"],
      content: json["content"],
      creationTime: DateTime.parse(json["creationTime"]),
      finishTime: json["finishTime"] != null
          ? DateTime.parse(json['finishTime'])
          : null,
    );
  }

  // 將Todo物件轉換為JSON格式
  Map<String, dynamic> toJson() {
    return {
      'isComplete': isComplete,
      'content': content,
      'creationTime': creationTime.toIso8601String(),
      'finishTime': finishTime?.toIso8601String(),
    };
  }
}
