import 'package:counter_app/card.dart';
import 'package:counter_app/edit.dart';
import 'package:counter_app/main.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CompleteToDo extends StatefulWidget {
  final List<TodoItem> completeToDo;
  const CompleteToDo({ Key? key, required this.completeToDo}) : super(key: key);

  @override
  State<CompleteToDo> createState() => _CompleteToDoState();
}

class _CompleteToDoState extends State<CompleteToDo> {
  final List<TodoItem> uncheckedToDo = [];

  void _removeToDo(int index) {
    setState(() {
                        uncheckedToDo.add(widget.completeToDo[index]);
                        widget.completeToDo.removeAt(index);
                      });
  }
  void _deleteToDo(index){
    setState(() {
      widget.completeToDo.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed To Do'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context, uncheckedToDo);
          }, icon:const Icon(Icons.home))
        ],
      ),
      body: ListView.builder(
        itemCount: widget.completeToDo.length,
        itemBuilder:(BuildContext context, int index){
          return Slidable(
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.5,
                children: [
                  SlidableAction(
                    label: 'Complete',
                    backgroundColor: Colors.red,
                    icon: Icons.close,
                    onPressed: (context) {
                      _removeToDo(index);
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
                widget.completeToDo[index], 
              ),
            );
        } ,
      ),
    );
  }
}