import 'package:try_rest_api_flutter/models/todo.dart';
import 'package:try_rest_api_flutter/repository/repository.dart';
import 'package:http/http.dart' as http;
// to convert json
import 'dart:convert';

class TodoRepository implements Repository {
  // use http
  String dataURL = "https://jsonplaceholder.typicode.com";
  @override
  Future<String> deletedTodo(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    var result = 'false';

    await http.delete(url).then((response) {
      print(response.body);
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    // Future -> async
    List<Todo> todoList = [];
    var url = Uri.parse('$dataURL/todos');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    // parse
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

// patch -> modify passed variable only
  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';

    await http.patch(url, body: {
      'completed': (!todo.completed!).toString(),
    }, headers: {
      'Authorization': 'your_token'
    }).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['completed'];
      // make call
    });
    return resData;
  }

// Modify passed variable only and treat other variable Null or default
  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataURL/todos/${todo.id}');
    String resData = '';

    await http.put(url, body: {
      'completed': (!todo.completed!).toString(),
    }, headers: {
      'Authorization': 'your_token'
    }).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
      // make call
    });
    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataURL/todos/');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    // Fake server => get return type != post type
    // change to Json method in model
    print(response.statusCode);
    print(response.body);
    return 'true';
  }
}
