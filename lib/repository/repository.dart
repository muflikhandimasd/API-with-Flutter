import 'package:try_rest_api_flutter/models/todo.dart';

abstract class Repository {
  // get
  Future<List<Todo>> getTodoList();
  // patch
  Future<String> patchCompleted(Todo todo);
  // put
  Future<String> putCompleted(Todo todo);
  // delete
  Future<String> deletedTodo(Todo todo);
  // post
  Future<String> postTodo(Todo todo);
}

// first make model