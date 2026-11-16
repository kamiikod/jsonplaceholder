import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';


class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('JSONPlaceholder API'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
              Tab(text: 'Albums'),
              Tab(text: 'Photos'),
              Tab(text: 'Todos'),
              Tab(text: 'Users'),
            ],
          ),
        ),

        body: TabBarView(children: [
          PostsTab(),
        ],),
      ),
    );
  }
}
