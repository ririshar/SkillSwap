import 'package:flutter/material.dart';
import 'listingscreen.dart';
import 'createlisting.dart';
import 'requestscreen.dart';

// Main screen that controls navigation between the app pages
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stores the currently selected page index
  int selectedIndex = 0;

  // Titles shown in the app bar for each page
  final titles = const [
    'Browse Skills',
    'Create Listing',
    'Requests',
  ];

  // Changes the page when a bottom navigation item is tapped
  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The main pages used by the bottom navigation bar
    final pages = const [
      ListingScreen(),
      CreateListingScreen(),
      RequestScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        // Shows the title for the selected page
        title: Text(titles[selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      // Shows the selected page
      body: pages[selectedIndex],

      // Bottom navigation used to switch between pages
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
