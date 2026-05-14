import 'package:flutter/material.dart';
import '../services/apiservice.dart';

// This screen shows all the skill listings from the backend
class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  // Stores the future list of listings from the backend
  late Future<List<dynamic>> listingsFuture;

  // Controller for the search input
  final searchController = TextEditingController();

  // Stores the selected level filter
  String selectedLevel = 'All';

  @override
  void initState() {
    super.initState();

    // Loads listings when the screen first opens
    listingsFuture = ApiService.getListings();
  }

  // Reloads the listings from the backend
  void refreshListings() {
    setState(() {
      listingsFuture = ApiService.getListings();
    });
  }

  // Deletes a listing and refreshes the list
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

  // Sends a lesson request for a listing
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

  // Shows a pop up form for sending a request
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
                // Input for the requester's name
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                // Input for the request message
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
            // Closes the request form
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            // Sends the request after checking the fields
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

  // Filters listings using the search text and selected level
  List<dynamic> filterListings(List<dynamic> listings) {
    final searchText = searchController.text.toLowerCase();

    return listings.where((listing) {
      final title = listing['title'].toString().toLowerCase();
      final description = listing['description'].toString().toLowerCase();
      final level = listing['level'].toString();

      final matchesSearch =
          title.contains(searchText) || description.contains(searchText);

      final matchesLevel = selectedLevel == 'All' || level == selectedLevel;

      return matchesSearch && matchesLevel;
    }).toList();
  }

  @override
  void dispose() {
    // Disposes the search controller when the screen closes
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: listingsFuture,
        builder: (context, snapshot) {
          // Shows a loading icon while listings are loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Shows an error message if listings fail to load
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final allListings = snapshot.data ?? [];

          // Applies search and level filters
          final filteredListings = filterListings(allListings);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar for filtering listings
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

                // Dropdown for filtering by skill level
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
                      value: 'Intermediate',
                      child: Text('Intermediate'),
                    ),
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

                              // Card for each listing
                              return Card(
                                margin: const EdgeInsets.only(bottom: 14),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Shows the listing title
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

                                      // Shows the listing description
                                      Text(listing['description']),

                                      const SizedBox(height: 10),

                                      // Shows listing details such as level and availability
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

                                          // Shows contact details if they exist
                                          if (listing.containsKey('contact') &&
                                              listing['contact'] != null &&
                                              listing['contact']
                                                  .toString()
                                                  .trim()
                                                  .isNotEmpty)
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
                                            // Opens the request form
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

                                            // Deletes the listing
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

      // Refresh button for reloading listings
      floatingActionButton: FloatingActionButton(
        onPressed: refreshListings,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
