import 'package:counter_app/card.dart';
import 'package:counter_app/providers.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CompleteTodo extends StatelessWidget {
  const CompleteTodo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your completed To do '),
      ),
      body: Consumer(
          builder: (context, ref, child){
            List<TodoItem> completeList = ref.watch(completeTodoListController);
            if(completeList.isEmpty){
                  return const Center(
                    child: Text('Finish your todos'),
                  );
            }else{
              return ListView.builder(
                itemCount: completeList.length,
                itemBuilder: (context, index){
                  return Slidable(
                    startActionPane: ActionPane(
                      motion:const DrawerMotion(),
                      extentRatio: 0.75,
                      children: [
                        SlidableAction(
                    label: 'Un-finish',
                    backgroundColor: Colors.yellow,
                    icon: Icons.check,
                    onPressed: (context) {
                      ref.read(completeTodoListController.notifier).uncompleteTodo(index);
                    },
                  ),
                  SlidableAction(
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (context) {
                      ref.read(completeTodoListController.notifier).deleteTodo(index);
                    },
                  ),
                      ],
                    ) ,
                    child: buildListTitle(completeList[index]),
                  );
                });
            }
          },
        ) 
    );
  }
}