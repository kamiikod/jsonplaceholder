import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}