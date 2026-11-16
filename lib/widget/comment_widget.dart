import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}