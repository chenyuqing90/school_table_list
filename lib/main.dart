import 'package:flutter/material.dart';


class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.grade, color: Colors.white,),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
      subtitle: Text('123'),
      trailing: Icon(Icons.edit),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

    // Initial Selected Value
  String dropdownvalue = '請選擇';  
 
  // List of items in our dropdown menu
  var items = [  
    '請選擇',
    '行動APP課程',
    '企業倫理',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('課程記事本'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          onPressed: () => _displayDialog(),
          tooltip: '新增記事',
          child: Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新增記事'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: '輸入內容'),
               ),
              TextField(
               controller: _textFieldController,
               decoration: const InputDecoration(hintText: '備註'),
              ),
              DropdownButton(
                // Initial Value
              value: dropdownvalue,
               
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),   
               
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
              ),
            ],
          ),
          
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('確認'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
            
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '課程記事本',
      home: new TodoList(),
    );
  }
}

void main() => runApp(new TodoApp());
