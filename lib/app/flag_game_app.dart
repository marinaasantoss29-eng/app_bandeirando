import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/search/presentation/flag_search_screen.dart';

class FlagGameApp extends StatelessWidget {
  const FlagGameApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Bandeirando',
    debugShowCheckedModeBanner: false,
    theme: buildAppTheme(),
    home: const _AppShell(),
  );
}

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(
      index: _selectedTab,
      children: const [HomeScreen(), FlagSearchScreen()],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedTab,
      onDestinationSelected: (index) => setState(() => _selectedTab = index),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.sports_esports_outlined), selectedIcon: Icon(Icons.sports_esports_rounded), label: 'Jogar'),
        NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Buscar'),
      ],
    ),
  );
}
