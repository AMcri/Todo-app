import 'package:counter_app/todo.dart';
import 'package:flutter/material.dart';

Widget buildListTitle(TodoItem item){
  return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
              child: ListTile(
                title: Text(item.header),
                subtitle: Text(item.description),
              ),
            );
}