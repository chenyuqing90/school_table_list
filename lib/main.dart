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
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
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
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
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
      title: 'School Table-ToDo List',
      home: new TodoList(),
    );
  }
}

void main() => runApp(new TodoApp());

/*class Accordion extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Accordion> {

  List<bool> expanded = [false, false];
  //expaned status boolean for ExpansionPanel
  //we have two panels so the bool value
  //set bool to true, if you want to expand accordion by default


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          child: Column(
            children: [
              ExpansionTile(
                title: Text("FAQ QUESTION ONE"),
                children: [
                  Container(
                    color: Colors.black12,
                    padding:EdgeInsets.all(20),
                    width: double.infinity,
                    child:  Text("Answers for Question One"),
                  )
                ],
              ),

              Card(
                  color: Colors.greenAccent[100],
                  child:ExpansionTile(
                    title: Text("FAQ QUESTION TWO"),

                    children: [
                      Container(
                        color: Colors.black12,
                        padding:EdgeInsets.all(20),
                        width: double.infinity,
                        child:  TodoList(),
                      )
                    ],
                  )
              ),

              ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      expanded[panelIndex] = !isExpanded;
                    });
                  },
                  animationDuration: Duration(seconds: 2),
                  //animation duration while expanding/collapsing
                  children:[
                    ExpansionPanel(
                        headerBuilder: (context, isOpen){
                          return Padding(
                              padding: EdgeInsets.all(15),
                              child:Text("FAQ QUESTIOn THREE")
                          );
                        },
                        body: Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.redAccent[100],
                          width: double.infinity,
                          child: Text("hello world"),
                        ),
                        isExpanded: expanded[0]
                    ),

                    ExpansionPanel(
                        headerBuilder: (context, isOpen){
                          return Padding(
                              padding: EdgeInsets.all(15),
                              child:Text("FAQ QUESTIOn FOUR")
                          );
                        },
                        body: Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.blueAccent[100],
                          width: double.infinity,
                          child: Text("hello world"),
                        ),
                        isExpanded: expanded[1]
                    )
                  ]
              )
            ],
          ),
        )
    );
  }
}*/