import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
    this.title,
    this.pageTitle,
    required this.selectedStore,
    this.onMenuPressed,
    this.onNotificationsPressed,
    this.onProfilePressed,
    this.onLanguagePressed,
    this.onStoreChanged,
    this.storeOptions = const [],
  });

  final String? title;
  final String? pageTitle;
  final String selectedStore;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onLanguagePressed;
  final ValueChanged<String?>? onStoreChanged;
  final List<String> storeOptions;

  @override
  Size get preferredSize => Size.fromHeight(64 + (pageTitle != null ? 48 : 0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: AppColors.secondaryMain,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 64,
      leading: IconButton(
        onPressed: onMenuPressed,
        icon: const Icon(Icons.menu),
        color: AppColors.primaryMain,
      ),
      title: Row(
        children: [
          if (storeOptions.isNotEmpty)
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStore,
                onChanged: onStoreChanged,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryMain,
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryMain,
                ),
                items: storeOptions
                    .map(
                      (store) => DropdownMenuItem<String>(
                        value: store,
                        child: Text(
                          store,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryMain,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onLanguagePressed,
          icon: const Icon(Icons.language),
          color: AppColors.primaryMain,
          tooltip: 'Language',
        ),
        IconButton(
          onPressed: onNotificationsPressed,
          icon: const Icon(Icons.notifications_none),
          color: AppColors.primaryMain,
          tooltip: 'Notifications',
        ),
        IconButton(
          onPressed: onProfilePressed,
          icon: const Icon(Icons.person_outline),
          color: AppColors.primaryMain,
          tooltip: 'Profile',
        ),
        const SizedBox(width: 8),
      ],
      bottom: pageTitle == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    pageTitle!,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryMain,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
