import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/albums_tab.dart';
import 'package:jsonplaceholder/pages/tabs/comments_tab.dart';
import 'package:jsonplaceholder/pages/tabs/photos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';
import 'package:jsonplaceholder/pages/tabs/todos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/users_tab.dart';

class _TabItem {
  final String label;
  final IconData icon;
  final Widget page;
  const _TabItem(this.label, this.icon, this.page);
}

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  // Satu daftar buat tab dan isinya, jadi ga perlu nyocokin urutan manual.
  static const List<_TabItem> _tabs = [
    _TabItem('Posts', Icons.article_outlined, PostsTab()),
    _TabItem('Comments', Icons.chat_bubble_outline, CommentsTab()),
    _TabItem('Albums', Icons.photo_album_outlined, AlbumsTab()),
    _TabItem('Photos', Icons.photo_outlined, PhotosTab()),
    _TabItem('Todos', Icons.check_circle_outline, TodosTab()),
    _TabItem('Users', Icons.person_outline, UsersTab()),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.api,
                  size: 20,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JSONPlaceholder',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Belajar REST API',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight + 1),
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    for (final t in _tabs)
                      Tab(
                        height: kTextTabBarHeight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(t.icon, size: 18),
                            const SizedBox(width: 6),
                            Text(t.label),
                          ],
                        ),
                      ),
                  ],
                ),
                Divider(height: 1, color: colorScheme.outlineVariant),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [for (final t in _tabs) t.page]),
      ),
    );
  }
}
