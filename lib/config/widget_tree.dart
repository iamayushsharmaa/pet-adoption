import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidgetTree extends StatelessWidget {
  final Widget child;

  const WidgetTree({super.key, required this.child});

  static const _navItems = ['/home', '/favorite', '/history'];

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    final index = _navItems.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((
          Set<MaterialState> states,
        ) {
          final isSelected = states.contains(MaterialState.selected);
          return TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
          );
        }),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        animationDuration: Duration(milliseconds: 300),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline),
            selectedIcon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'History',
          ),
        ],
        onDestinationSelected: (int index) {
          final goRouter = GoRouter.of(context);
          goRouter.go(_navItems[index]);
        },
      ),
    );
  }
}
