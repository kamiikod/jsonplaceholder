import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/model/photos.dart';
import 'package:jsonplaceholder/service/api_service.dart';

class AlbumWidget extends StatelessWidget {
  final Albums album;
  final Future<List<Photos>> Function(int albumId)? photoLoader;

  const AlbumWidget({super.key, required this.album, this.photoLoader});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.album, size: 100, color: Colors.grey[700]),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.title,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: Colors.grey[850],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Album #${album.id}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey[600],
                            fontSize: 14,
                          )),
                          Text('User ID: ${album.userId}', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey[600],
                            fontSize: 14,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
