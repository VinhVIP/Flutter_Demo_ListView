import 'package:flutter/material.dart';
import 'models/user.dart';

class InputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InputScreenState();
  }
}

class InputScreenState extends State<InputScreen> {
  User user = User("", 0);
  bool _isInputAgeValid = true, _isInputNameValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm người dùng'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 40, right: 10),
        child: Column(
          children: <Widget>[
            _usernameTextField(context),
            _userAgeTextField(context),
            _buttonAddUser(context),
          ],
        ),
      ),
    );
  }

  Widget _usernameTextField(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      onChanged: (String text) {
        setState(() {
          user.userName = text;
          if (text == null || text.length == 0)
            _isInputNameValid = false;
          else
            _isInputNameValid = true;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Nhập tên người dùng',
        errorText: _isInputNameValid ? null : 'Bạn chưa nhập tên',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _userAgeTextField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 3,
      onChanged: (String text) {
        setState(() {
          user.userAge = int.tryParse(text);
          if (user.userAge == 0) _isInputAgeValid = false;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Nhập tuổi người dùng',
        errorText: _isInputAgeValid ? null : 'Tuổi phải lớn hơn 0',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buttonAddUser(BuildContext context) {
    return RaisedButton(
      elevation: 5,
      color: Colors.blueAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('THÊM'),
      onPressed: () {
        if (user.userName != null && user.userName.length > 0 && user.userAge > 0) {
          Navigator.pop(context, user);
        }
      },
    );
  }
}
