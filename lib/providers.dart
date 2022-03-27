import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_2/todo.dart';

final todoItemListController = StateNotifierProvider<TodoListNotifier, List<TodoItem>>(
  (ref)=> TodoListNotifier()
);

class TodoListNotifier extends StateNotifier<List<TodoItem>>{
  TodoListNotifier() : super([]);

  void deleteTodo(int index){
    state.removeAt(index);
  }

  void addTodo(String header, String description){
    print(state.length);
    state.add(TodoItem(header: header, description: description));
  }

  

}