class UserModel {
  int? id;
  String firstName;
  String lastName;
  String email;
  String password;
  String role;
  bool isLoggedIn;
  String errorMessage;

  UserModel({
    this.id,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.role = 'student',
    this.isLoggedIn = false,
    this.errorMessage = '',
  });
}