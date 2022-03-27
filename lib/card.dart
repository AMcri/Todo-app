import 'package:flutter/material.dart';
import 'package:todo_app_2/todo.dart';

Widget buildListTitle(TodoItem item){
  return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
              child: ListTile(
                title: Text(item.header),
                subtitle: Text(item.description),
              ),
            );
}