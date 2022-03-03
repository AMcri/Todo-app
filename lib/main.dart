import 'package:counter_app/add.dart';
import 'package:counter_app/card.dart';
import 'package:counter_app/complete.dart';
import 'package:counter_app/edit.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoApp()
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({ Key? key }) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final List<TodoItem> _toDoList = [
    TodoItem(header: "Do Home Work", description: "Do math and English homework")
  ];
  final List<TodoItem> _completeTodo = [];

  void _addToDo() async{
    TodoItem todo = await Navigator.push(context, MaterialPageRoute(builder:(context)=> const AddPage()));
              if(todo.header != '' ){
                setState(() {
                  _toDoList.add(TodoItem(header: todo.header, description: todo.description));
                });
            }
  }

  void _goToCompleteToDo() async{
    List<TodoItem> _uncheckedToDo  = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteToDo(completeToDo:_completeTodo,)));
    setState(() {
      if(_uncheckedToDo != []){
        for(final toDo in _uncheckedToDo){
          _toDoList.add(toDo);
        }
      }
    });
  }

  void _markComplete(int index, TodoItem todo){
    setState(() {
      _completeTodo.add(todo);
      _toDoList.removeAt(index);
    });
  }

  void _editToDo(int index) async{
    TodoItem _editTodo = await 
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPage(header: _toDoList[index].header, description: _toDoList[index].description)));
                  setState(() {
                    _toDoList.removeAt(index);
                    _toDoList.add(_editTodo);
                  });
  }

  void _deleteToDo(index){
    setState(() {
      _toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: (){
              _addToDo();
          },
          icon: const Icon(Icons.add)),
          IconButton(onPressed:(){
            _goToCompleteToDo();
          }, icon:const Icon(Icons.check))
        ],
        title: const Text('To do App'),
      ),
        body: ListView.builder(
          itemCount: _toDoList.length,
          itemBuilder: (BuildContext context, int index){
            return Slidable(
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.75,
                children: [
                  SlidableAction(
                    label: 'Edit',
                    backgroundColor: Colors.yellow,
                    icon: Icons.edit,
                    onPressed: (context) {
                      _editToDo(index);
                    },
                  ),
                  SlidableAction(
                    label: 'Complete',
                    backgroundColor: Colors.green,
                    icon: Icons.check,
                    onPressed: (context) {
                      _markComplete(index, _toDoList[index]);
                    },
                  ),
                  SlidableAction(
                    label: 'Delete',
                    backgroundColor: Colors.blue,
                    icon: Icons.delete,
                    onPressed: (context) {
                      _deleteToDo(index);
                    },
                  ),
                ],
              ),
              child: buildListTitle(
                _toDoList[index], 
              ),
            );
          }
        ),
      ),
    );
  }
}
