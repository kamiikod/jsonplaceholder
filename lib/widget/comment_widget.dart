import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  child: Text(
                    comment.name.isNotEmpty
                        ? comment.name[0].toUpperCase()
                        : '#',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment.name, style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[850],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                        Text(comment.email, style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Post #${comment.postId}',
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            Text(
              comment.body,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.grey[850],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
