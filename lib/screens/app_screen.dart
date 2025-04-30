import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import '/screens/notes_screen.dart';
import '/widgets/app_drawer.dart';
import 'text_to_speech_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});
  static const routeName = '/app-screen';

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _screens = [
    {'title': 'All Notes', 'page': NotesScreen()},
    {'title': 'Favourite Notes', 'page': NotesScreen(isFavouriteScreen: true)},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.grid_view_rounded, size: 30, color: Colors.black),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Text(
          _screens[_currentIndex]['title'] as String,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 2,
      ),
      drawer: AppDrawer(),
      body: _screens[_currentIndex]['page'] as Widget,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0, FeatherIcons.fileText, "Notes"),
                _buildNavItem(1, Icons.favorite, "Favorites"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(
                TextToSpeechScreen.routeName,
              ),
              backgroundColor: Colors.black,
              child: const Icon(Icons.mic, color: Colors.white),
              tooltip: 'Speech to Text',
            )
          : null,
    );
  }

  Widget _buildNavItem(int index, IconData icon, String tooltip) {
    final bool isSelected = _currentIndex == index;
    return IconButton(
      tooltip: tooltip,
      onPressed: () => setState(() => _currentIndex = index),
      icon: Icon(icon,
          size: 28, color: isSelected ? Colors.black : Colors.grey[500]),
    );
  }
}
