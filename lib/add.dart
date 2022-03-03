import 'package:counter_app/main.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late TextEditingController _headerController;
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _headerController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit To Do Page'),
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
                  Navigator.pop(context, TodoItem(
                    header: _headerController.text, 
                    description: _descriptionController.text
                  ));
                }, 
                child: const Text('Add To Do'),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ToDoApp()));
                }, 
                child: const Text('Cancel')
              )
            ],
          )
        ],
      ),
    );
  }
}