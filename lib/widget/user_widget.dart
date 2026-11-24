import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jsonplaceholder/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  final VoidCallback? onTap;

  // Bookmark
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  // Badge di header (data ini ga ada di API, jadi diatur manual)
  final bool isOnline;
  final bool isVerified;

  // Aksi tile (opsional). Salin email sudah bawaan.
  final VoidCallback? onCall;
  final VoidCallback? onOpenWebsite;
  final VoidCallback? onOpenMap;

  const UserWidget({
    super.key,
    required this.user,
    this.onTap,
    this.onBookmark,
    this.isBookmarked = false,
    this.isOnline = false,
    this.isVerified = false,
    this.onCall,
    this.onOpenWebsite,
    this.onOpenMap,
  });

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Tersalin ke clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final tag = user.company.bs.split(' ').last;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header =====
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: colorScheme.primary,
                        child: Text(
                          user.name.isNotEmpty
                              ? user.name
                                    .split(' ')
                                    .where((w) => w.isNotEmpty)
                                    .take(2)
                                    .map((w) => w[0].toUpperCase())
                                    .join()
                              : '#',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.surfaceContainerHighest,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            if (isVerified) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified,
                                size: 18,
                                color: colorScheme.primary,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              '@${user.username}',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'ID: #${user.id.toString().padLeft(3, '0')}',
                                style: textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (onBookmark != null)
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: onBookmark,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // ===== Perusahaan =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.company.name.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tag,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '"${user.company.catchPhrase}"',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // ===== Info tiles =====
              _InfoTile(
                icon: Icons.mail_outline,
                label: 'SUREL PERUSAHAAN',
                lines: [user.email],
                trailing: Icons.copy,
                onTap: () => _copy(context, user.email),
              ),
              _InfoTile(
                icon: Icons.phone_outlined,
                label: 'TELEPON KERJA',
                lines: [user.phone],
                trailing: Icons.chevron_right,
                onTap: onCall,
              ),
              _InfoTile(
                icon: Icons.language,
                label: 'SITUS WEB',
                lines: [user.website],
                trailing: Icons.open_in_new,
                onTap: onOpenWebsite,
              ),
              _InfoTile(
                icon: Icons.location_on_outlined,
                label: 'ALAMAT KANTOR',
                lines: [
                  '${user.address.suite}, ${user.address.street}, ${user.address.city}',
                  'Kode Pos: ${user.address.zipcode}',
                ],
                chip: 'Geo: ${user.address.geo.lat}, ${user.address.geo.lng}',
              ),
              const SizedBox(height: 2),

              // ===== Placeholder peta =====
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: onOpenMap,
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorScheme.primaryContainer,
                          colorScheme.secondaryContainer,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 32,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            color: Colors.black54,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${user.address.city} District',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Buka Peta',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.north_east,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tile info dengan ikon di kiri, label kecil, nilai, dan ikon aksi di kanan.
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> lines;
  final IconData? trailing;
  final String? chip;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.lines,
    this.trailing,
    this.chip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: textTheme.labelSmall?.copyWith(
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      for (var i = 0; i < lines.length; i++)
                        Text(
                          lines[i],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              (i == 0
                                      ? textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        )
                                      : textTheme.bodySmall)
                                  ?.copyWith(
                                    color: i == 0
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurfaceVariant,
                                  ),
                        ),
                      if (chip != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            chip!,
                            style: textTheme.labelSmall?.copyWith(
                              fontFamily: 'monospace',
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  Icon(trailing, size: 18, color: colorScheme.onSurfaceVariant),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
