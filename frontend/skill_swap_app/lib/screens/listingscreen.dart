import 'package:flutter/material.dart';
import '../services/apiservice.dart';
// this screen displays the list of skill listings that users can browse through. It includes a search bar to filter listings by skill name or description, and a dropdown to filter by skill level (beginner, intermediate, advanced). Each listing card shows the skill title, description, level, availability, and contact details if provided. Users can also send a request to the listing owner directly from this screen or delete their own listings. The screen fetches the listings from the backend API and updates in real-time when changes are made.

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late Future<List<dynamic>> listingsFuture;

  final searchController = TextEditingController();
  String selectedLevel = 'All';

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

  Future<void> deleteListing(int listingId) async {
  try {
    await ApiService.deleteListing(listingId);

    refreshListings();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Listing deleted')),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}

  Future<void> sendRequest(
  int listingId,
  String requesterName,
  String message,
) async {
  try {
    await ApiService.createRequest(
      listingId: listingId,
      requesterName: requesterName,
      message: message,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lesson request sent')),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }
}
 void showRequestDialog(int listingId, String listingTitle) {
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('Request: $listingTitle'),

        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Your name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Request message',
                  hintText: 'Hi, I would like help with this skill...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            onPressed: () async {
              final requesterName = nameController.text.trim();
              final message = messageController.text.trim();

              if (requesterName.isEmpty || message.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill in all fields'),
                  ),
                );
                return;
              }

              Navigator.pop(dialogContext);

              await sendRequest(
                listingId,
                requesterName,
                message,
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      );
    },
  );
}

  List<dynamic> filterListings(List<dynamic> listings) {
    final searchText = searchController.text.toLowerCase();

    return listings.where((listing) {
      final title = listing['title'].toString().toLowerCase();
      final description = listing['description'].toString().toLowerCase();
      final level = listing['level'].toString();

      final matchesSearch =
          title.contains(searchText) || description.contains(searchText);

      final matchesLevel =
          selectedLevel == 'All' || level == selectedLevel;

      return matchesSearch && matchesLevel;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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

          final allListings = snapshot.data ?? [];
          final filteredListings = filterListings(allListings);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search for a skill',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: selectedLevel,
                  decoration: const InputDecoration(
                    labelText: 'Filter by level',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All')),
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(
                        value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: filteredListings.isEmpty
                      ? const Center(child: Text('No matching listings found.'))
                      : RefreshIndicator(
                          onRefresh: () async {
                            refreshListings();
                          },
                          child: ListView.builder(
                            itemCount: filteredListings.length,
                            itemBuilder: (context, index) {
                              final listing = filteredListings[index];

                              return Card(
                                margin: const EdgeInsets.only(bottom: 14),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.school),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              listing['title'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Text(listing['description']),

                                      const SizedBox(height: 10),

                                      Wrap(
                                        spacing: 8,
                                        children: [
                                          Chip(
                                            label: Text(
                                              'Level: ${listing['level']}',
                                            ),
                                          ),

                                          Chip(
                                            label: Text(
                                              'Available: ${listing['availability']}',
                                            ),
                                          ),
                                          
                                          
                                          if (listing.containsKey('contact') &&
                                            listing['contact'] != null &&
                                            listing['contact'].toString().trim().isNotEmpty)
                                          Chip(
                                            label: Text(
                                              'Contact: ${listing['contact']}',
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                           ElevatedButton.icon(
                                            onPressed: () {
                                              showRequestDialog(
                                                listing['id'],
                                                listing['title'],
                                              );        
                                            },          
                                          icon: const Icon(Icons.send),
                                          label: const Text('Request'),
                                        ),

                                        const SizedBox(width: 8),

                                        IconButton(
                                          onPressed: () {
                                            deleteListing(listing['id']);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
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