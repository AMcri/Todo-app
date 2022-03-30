import 'package:flutter/material.dart';
import 'package:counter_app/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget buildListTitle(TodoItem item){
  return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
              child: ListTile(
                title: Text(item.header),
                subtitle: Text(item.description),
              ),
            );
}
