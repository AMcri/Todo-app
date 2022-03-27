import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_2/providers.dart';
import 'package:todo_app_2/todo.dart';

class AddTodo extends ConsumerWidget {
  AddTodo({ Key? key }) : super(key: key);
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New To Do'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Your To Do Header"
            ),
            controller:_headerController,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Your To Do Descritptions"
            ),
            controller:_descriptionController,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                
                    ref.read(todoItemListController.notifier).addTodo(_headerController.text, _descriptionController.text);
                    Navigator.pop(context);
                
              }, 
                child: const Text('Add To Do'),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: const Text('Cancel')
              )]
            )
        ],
      ),
    );
  }
}