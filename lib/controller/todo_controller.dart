import 'package:try_rest_api_flutter/models/todo.dart';
import 'package:try_rest_api_flutter/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);
  // get
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) async {
    return _repository.deletedTodo(todo);
  }

  Future<String> postTodo(Todo todo) async {
    return _repository.postTodo(todo);
  }
}
