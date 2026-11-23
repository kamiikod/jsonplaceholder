import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/albums_tab.dart';
import 'package:jsonplaceholder/pages/tabs/comments_tab.dart';
import 'package:jsonplaceholder/pages/tabs/photos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';
import 'package:jsonplaceholder/pages/tabs/todos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/users_tab.dart';


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
              Tab(text: 'Posts', icon: Icon(Icons.article),),
              Tab(text: 'Comments', icon: Icon(Icons.comment),),
              Tab(text: 'Albums', icon: Icon(Icons.photo_album),),
              Tab(text: 'Photos', icon: Icon(Icons.photo),),
              Tab(text: 'Todos', icon: Icon(Icons.check_circle),),
              Tab(text: 'Users', icon: Icon(Icons.person),),
            ],
          ),
        ),

        body: TabBarView(children: [
          PostsTab(),
          CommentsTab(),
          AlbumsTab(),
          PhotosTab(),
          TodosTab(),
          UsersTab(),
        ],),
      ),
    );
  }
}
