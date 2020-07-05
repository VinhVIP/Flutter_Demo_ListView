import 'package:flutter/material.dart';

import 'add_user.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Flutter Demo"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListViewHandleItem(),
    );
  }
}

class ListViewHandleItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListViewHandleItemState();
  }
}

class ListViewHandleItemState extends State<ListViewHandleItem> {
  List<User> items = [User("Vinh", 20), User("Long", 20)];
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Thông tin người dùng',
                style: TextStyle(
                  color: Colors.amber,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Expanded(
//            height: 650,
            child: AnimatedList(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(5),
              initialItemCount: items.length,
              key: _listKey,
              itemBuilder: (context, index, animation) {
                return _rowItem(items[index], animation);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _moveToInputScreen(context);
          });
        },
      ),
    );
  }

  _moveToInputScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InputScreen()),
    );
    if (result != null) {
      print('Add user');
      _insertLastItem(result);
//      Scaffold.of(context)
//        ..removeCurrentSnackBar()
//        ..showSnackBar(SnackBar(
//          content: Text('$result'),
//        ));
    }
  }

  Widget _rowItem(User user, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text(user.userName),
          subtitle: Text(user.userAge.toString()),
          onTap: () {
            setState(() {
              print(user.userName);
            });
          },
          onLongPress: () {
            setState(() {
              _removeItem(user);
            });
          },
        ),
      ),
    );
  }

  void _insertLastItem(User user) {
    items.add(user);
    _listKey.currentState.insertItem(items.length - 1);
  }

  void _removeItem(User user) {
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _rowItem(user, animation);
    };
    final int index = items.indexOf(user);
    _listKey.currentState.removeItem(index, builder);
    items.remove(user);
  }
}
