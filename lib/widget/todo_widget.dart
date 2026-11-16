import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/todos.dart';

class TodoWidget extends StatelessWidget {
  final Todos todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}