class User {
  String _userName;
  int _userAge;

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  User(this._userName, this._userAge);

  int get userAge => _userAge;

  set userAge(int value) {
    _userAge = value;
  }
}