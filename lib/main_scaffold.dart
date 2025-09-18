// lib/main_scaffold.dart
import 'package:flutter/material.dart';
import 'home_page.dart';
// TODO: import marketplace_screen.dart, community_screen.dart, profile_screen.dart

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // screens for nav items
  final List<Widget> _screens = [
  const HomePage(),          // Home
  const Placeholder(),       // Marketplace (create later)
  const SizedBox(),          // Plus button handled separately
  const Placeholder(),       // Community (create later)
  const Placeholder(),       // Profile (create later)
];

 void _onItemTapped(int index) {
  if (index == 2) {
    // Plus button → open form later
    _openSellForm();
  } else {
    setState(() {
      _selectedIndex = index;
    });
  }
}

  void _openSellForm() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Sell Your Farm Produce"),
      content: const Text("Form will be designed later."),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"))
      ],
    ),
  );
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 32,
          ),
          const SizedBox(width: 8),
          const Text(
            "FarmZ Farmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    body: _screens[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Market"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 36, color: Colors.green),
            label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ),
  );
}

}
