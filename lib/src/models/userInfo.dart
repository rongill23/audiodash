// Written by Ronald Gilliard Jr -> https://github.com/rongill23

class AppUser {
  String email = "";
  String userID = "";
  List<dynamic> groups = [];
  String name = "";
  bool status = true;

  AppUser(this.email, this.userID, this.name, this.groups);
}
