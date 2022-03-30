import 'package:counter_app/complete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:counter_app/add.dart';
import 'package:counter_app/card.dart';
import 'package:counter_app/providers.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const CompleteTodo()));
              }, 
              icon: const Icon(Icons.check)
            ),
          ],
      ),
        body: Consumer(
          builder: (context, ref, child){
            List<TodoItem> todoList = ref.watch(todoItemListController);
            if(todoList.isEmpty){
                  return const Center(
                    child: Text('Add New To Do :)))'),
                  );
            }else{
              return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index){
                  return Slidable(
                    startActionPane: ActionPane(
                      motion:const DrawerMotion(),
                      extentRatio: 0.75,
                      children: [
                        SlidableAction(
                    label: 'Complete',
                    backgroundColor: Colors.green,
                    icon: Icons.check,
                    onPressed: (context) {
                      ref.read(todoItemListController.notifier).completeTodo(index);
                    },
                  ),
                  SlidableAction(
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (context) {
                      ref.read(todoItemListController.notifier).deleteTodo(index);
                    },
                  ),
                      ],
                    ) ,
                    child: buildListTitle(todoList[index]),
                  );
                });
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTodo()));
          },
          child:const Icon(Icons.add) ,
        ), 
      ),
    );
  }
}
