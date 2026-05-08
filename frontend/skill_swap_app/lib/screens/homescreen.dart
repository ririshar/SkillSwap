import 'package:flutter/material.dart';
import 'listingscreen.dart';
import 'createlisting.dart';
import 'requestscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> sentRequests = [];

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const ListingScreen(),
      const CreateListingScreen(),
      RequestScreen(sentRequests: sentRequests),
    ];
  }

  final titles = const [
    'Browse Skills',
    'Create Listing',
    'Requests',
  ];

  void changePage(int index) {
    if (index == 2) {
      // Example: Add a new request when navigating to the Requests page
      sentRequests.add({
        'title': 'New Request',
        'description': 'This is a new request.',
      });
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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