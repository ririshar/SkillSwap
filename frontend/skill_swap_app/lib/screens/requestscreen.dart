import 'package:flutter/material.dart';
import '../services/apiservice.dart';

// This screen shows all lesson requests from the backend
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  // Stores the future list of requests from the backend
  late Future<List<dynamic>> requestsFuture;

  @override
  void initState() {
    super.initState();

    // Loads requests when the screen first opens
    requestsFuture = ApiService.getRequests();
  }

  // Reloads the requests from the backend
  void refreshRequests() {
    setState(() {
      requestsFuture = ApiService.getRequests();
    });
  }

  // Accepts a request and refreshes the list
  Future<void> acceptRequest(int requestId) async {
    await ApiService.acceptRequest(requestId);
    refreshRequests();
  }

  // Rejects a request and refreshes the list
  Future<void> rejectRequest(int requestId) async {
    await ApiService.rejectRequest(requestId);
    refreshRequests();
  }

  // Deletes a request and refreshes the list
  Future<void> deleteRequest(int requestId) async {
    await ApiService.deleteRequest(requestId);
    refreshRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: requestsFuture,
        builder: (context, snapshot) {
          // Shows a loading icon while requests are loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Shows an error message if requests fail to load
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final requests = snapshot.data ?? [];

          // Shows a message if there are no requests
          if (requests.isEmpty) {
            return const Center(child: Text('No requests yet.'));
          }

          // Builds the list of request cards
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requestId = request['id'];

              // Card for each request
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shows the request number
                      Text(
                        'Request #$requestId',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Shows the request details
                      Text('Listing ID: ${request['listing_id']}'),
                      Text('From: ${request['requester_name']}'),
                      Text('Message: ${request['message'] ?? 'No message'}'),
                      Text('Status: ${request['status']}'),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          // Accepts the request
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await acceptRequest(requestId);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request accepted'),
                                  ),
                                );
                              } catch (error) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')),
                                );
                              }
                            },
                            child: const Text('Accept'),
                          ),

                          const SizedBox(width: 8),

                          // Rejects the request
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await rejectRequest(requestId);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request rejected'),
                                  ),
                                );
                              } catch (error) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $error')),
                                );
                              }
                            },
                            child: const Text('Reject'),
                          ),

                          const SizedBox(width: 8),

                          // Deletes the request
                          IconButton(
                            onPressed: () async {
                              await deleteRequest(requestId);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // Refresh button for reloading requests
      floatingActionButton: FloatingActionButton(
        onPressed: refreshRequests,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
