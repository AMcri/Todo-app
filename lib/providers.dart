import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:counter_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final todoItemListController = 
  StateNotifierProvider<TodoListNotifier, List<TodoItem>>((ref)=> TodoListNotifier(ref.read));

final completeTodoListController =
  StateNotifierProvider<CompleteListNotifier, List<TodoItem>>((ref)=> CompleteListNotifier(ref.read));



class TodoListNotifier extends StateNotifier<List<TodoItem>>{
  TodoListNotifier(this.read, [List<TodoItem>? state]) : super([]){
    getTodoList();
  }

  
  final Reader read;
  
  void saveTodoList() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> data = state.map((e) => jsonEncode(e.toJson())).toList();
    _prefs.setStringList('todo', data);
  }



  void getTodoList() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String>? data = _prefs.getStringList('todo');
    if(data == null){
      state = [];
    }else{
      state = data.map((e) => TodoItem.fromMap(jsonDecode(e))).toList();
    }
  }


  void deleteTodo(int index){
    final todolist = state.toList();
    todolist.removeAt(index);
    state = todolist;
    saveTodoList();
  }

  void addTodo(TodoItem todo){
    state = [... state,TodoItem(todo.header,todo.description)];
    saveTodoList();
  }

  void completeTodo(int index){
    final newList = state.toList();
    read(completeTodoListController.notifier).addTodo(
      TodoItem(
        newList[index].header,
        newList[index].description
      )
    );
    newList.removeAt(index);
    state = newList;
    saveTodoList();
  }
}

class CompleteListNotifier extends StateNotifier<List<TodoItem>>{
  CompleteListNotifier(this.read, [List<TodoItem>? state]) : super([]){
    getCompleteList();
  }
  final Reader read;

  void saveCompleteList() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> data = state.map((e) => jsonEncode(e.toJson())).toList();
    _prefs.setStringList('complete', data);
  }

  void getCompleteList() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String>? data = _prefs.getStringList('complete');
    if(data == null){
      state = [];
    }else{
      state = data.map((e) => TodoItem.fromMap(jsonDecode(e))).toList();
    }
  }

  void addTodo(TodoItem todo){
    state = [... state,TodoItem(todo.header,todo.description)];
    saveCompleteList();
  }

  void uncompleteTodo(int index){
    final completeTodo = state.toList();
    read(todoItemListController.notifier).addTodo(
      TodoItem(
        completeTodo[index].header,
        completeTodo[index].description
      )
    );
    completeTodo.removeAt(index);
    state = completeTodo;
    saveCompleteList();
  }

  void deleteTodo(int index){
    final todolist = state.toList();
    todolist.removeAt(index);
    state = todolist;
    saveCompleteList();
  } 
}