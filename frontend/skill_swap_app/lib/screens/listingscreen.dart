import 'package:flutter/material.dart';
import '../services/apiservice.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late Future<List<dynamic>> listingsFuture;

  @override
  void initState() {
    super.initState();
    listingsFuture = ApiService.getListings();
  }

  void refreshListings() {
    setState(() {
      listingsFuture = ApiService.getListings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: listingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final listings = snapshot.data ?? [];

          if (listings.isEmpty) {
            return const Center(child: Text('No listings yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final listing = listings[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(listing['title']),
                  subtitle: Text(
                    '${listing['description']}\nLevel: ${listing['level']}\nAvailable: ${listing['availability']}',
                  ),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lesson request sent')),
                      );
                    },
                    child: const Text('Request'),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshListings,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}