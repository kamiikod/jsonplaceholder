import 'package:flutter/material.dart';

class AsyncDataView<T> extends StatefulWidget {
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String title;

  const AsyncDataView({
    super.key,
    required this.onFetch,
    required this.itemBuilder,
    required this.title,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  late Future<List<T>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = widget.onFetch();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Memuat ${widget.title} ...'),
              ],
            ),
          );
        }
        // 2. Error state
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Icon(Icons.error, size: 48, color: Colors.red),
                SizedBox(height: 12),
                Text('Terjadi kesalahan saat memuat ${widget.title}'),
                SizedBox(height: 12),
                Text('${snapshot.error}'),
                ElevatedButton(
                  onPressed: _handleRefresh,
                  child: Text('Refresh Halaman'),
                ),
              ],
            ),
          );
        }
        // 3. Empty state
        final items = snapshot.data ?? [];
        if (items.isEmpty){
          return Center(
            child: Text('Tidak ada data ${widget.title}'),
          );
        }
        // 4. Success state with pull refresh
        return RefreshIndicator(onRefresh: _handleRefresh, child: Column(
          children: [
            Container(),
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                return widget.itemBuilder(context, items[index], index);
              },
              itemCount: items.length,
            ))
          ],
        )); 
      },
    );
  }
}
