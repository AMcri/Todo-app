import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String header;
  final String description;
  const EditPage({ Key? key, required this.header, required this.description}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _headerController;
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _headerController = TextEditingController(text: widget.header);
    _descriptionController = TextEditingController(text: widget.description);
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
                child: const Text('Save Changes'),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context, TodoItem(
                    header: widget.header, 
                    description: widget.description
                  ));
                }, 
                child: const Text('Cancel')
              ),
              
            ],
          )
        ],
      ),
    );
  }
}