import 'package:dio/dio.dart';
import 'package:task_manager/utils/constants.dart';

import '../models/todo.dart';

class TodoService {
  final Dio _dio = Dio();

  final String baseUrl = '${Constants.baseUrl}/todos';

  Future<List<Todo>> fetchTodos(int id) async {
    try {
      final response = await _dio.get('$baseUrl/user/$id');
      if (response.statusCode == 200) {
        final List jsonList = response.data['todos'];
        final todos = jsonList.map((map) => Todo.fromMap(map)).toList();
        return todos;
      } else {
        return []; // Handle error case
      }
    } catch (e) {
      return []; // Handle Dio exceptions
    }
  }

  Future<Todo?> createTodo(String todo, int userId) async {
    try {
      final response = await _dio.post(
        '$baseUrl/todos',
        data: {'todo': todo, 'completed': false, 'userId': userId},
      );
      if (response.statusCode == 201) {
        final json = response.data;
        return Todo(
          id: json['id'],
          todo: json['todo'],
          completed: json['completed'],
          userId: json['userId'],
        );
      } else {
        return null; // Handle error case
      }
    } catch (e) {
      return null; // Handle Dio exceptions
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      final response = await _dio.put(
        '$baseUrl/todos/${todo.id}',
        data: {
          'todo': todo.todo,
          'completed': todo.completed,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      return false; // Handle Dio exceptions
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    try {
      final response = await _dio.delete('$baseUrl/todos/$todoId');
      return response.statusCode == 200;
    } catch (e) {
      return false; // Handle Dio exceptions
    }
  }
}
