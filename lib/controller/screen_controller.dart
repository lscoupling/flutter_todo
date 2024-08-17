// ScreenController類別，用於管理應用程式的頁面切換
class ScreenController {
  bool isLoggedIn = false; // 標記用戶是否已經登入

  // 根據登入狀態返回不同的頁面路徑
  String ExchangeScreen() {
    if (isLoggedIn) {
      return "/todolist"; // 已登入，顯示待辦事項頁面
    } else {
      return "/login"; // 未登入，顯示登入頁面
    }
  }
}
