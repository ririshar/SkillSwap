import 'package:flutter/material.dart';
import 'listingscreen.dart';
import 'createlisting.dart';
import 'requestscreen.dart';

// The HomeScreen is the main screen of the app that contains a bottom navigation bar to switch between the three main sections:
// Browse Skills, Create Listing, and Requests. 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final titles = const [
    'Browse Skills',
    'Create Listing',
    'Requests',
  ];

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = const [
      ListingScreen(),
      CreateListingScreen(),
      RequestScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Listings'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Requests'),
        ],
      ),
    );
  }
}