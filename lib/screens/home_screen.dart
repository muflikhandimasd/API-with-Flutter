import 'package:flutter/material.dart';
import 'package:try_rest_api_flutter/controller/todo_controller.dart';
import 'package:try_rest_api_flutter/models/todo.dart';
import 'package:try_rest_api_flutter/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());
    // test
    todoController.fetchTodoList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Flutter REST API'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }

          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // make post call
          // temp data
          Todo todo = Todo(userId: 3, title: 'sample post', completed: false);
          todoController.postTodo(todo).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 1000),
                content: Text('Post Data $value')));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) {
          var todo = snapshot.data?[index];
          return Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 2, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              // make controller method
                              // make snackbar
                              todoController
                                  .updatePatchCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        content: Text('Patch Data $value')));
                              });
                            },
                            child: buildCallContainer(
                                title: "Patch", color: const Color(0xFF3518D6)),
                          ),
                          // make put call
                          InkWell(
                            onTap: () {
                              todoController
                                  .updatePutCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        content: Text('Put Data $value')));
                              });
                            },
                            child: buildCallContainer(
                                title: "Put", color: const Color(0xFFFFD900)),
                          ),
                          // make delete call
                          InkWell(
                            onTap: () {
                              todoController.deleteTodo(todo!).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        content: Text('Delete Data $value')));
                              });
                            },
                            child: buildCallContainer(
                                title: "Del", color: Colors.red),
                          ),
                        ],
                      )),
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
            height: 0.5,
          );
        },
        itemCount: snapshot.data?.length ?? 0,
      ),
    );
  }

  Container buildCallContainer({String title = '', Color? color}) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Center(
          child: Text(
        '$title',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      )),
    );
  }
}
