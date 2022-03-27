import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_2/add.dart';
import 'package:todo_app_2/card.dart';
import 'package:todo_app_2/providers.dart';
import 'package:todo_app_2/todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTodo()));
              }, 
              icon: const Icon(Icons.add)
            ),
          ],
      ),
        body: Consumer(
          builder: (context, ref, child){
            List<TodoItem> todoList = ref.watch(todoItemListController);
            if(todoList.isEmpty){
              return const CircularProgressIndicator();
            }else{
              return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index){
                  return buildListTitle(todoList[index]);
                },
              );
            }
          },
        ) 
      ),
    );
  }
}
