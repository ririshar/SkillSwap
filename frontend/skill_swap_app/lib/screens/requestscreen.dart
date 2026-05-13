import 'package:flutter/material.dart';
import '../services/apiservice.dart';
// this screen displays the list of skill requests that users have received for their listings. Each request card shows the requester's name, the listing they are interested in, their message, and the current status of the request (pending, accepted, rejected). Users can accept or reject requests directly from this screen, which will update the request status accordingly. The screen fetches the requests from the backend API and updates in real-time when changes are made.
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late Future<List<dynamic>> requestsFuture;

  @override
  void initState() {
    super.initState();
    requestsFuture = ApiService.getRequests();
  }

  void refreshRequests() {
    setState(() {
      requestsFuture = ApiService.getRequests();
    });
  }

  Future<void> acceptRequest(int requestId) async {
    await ApiService.acceptRequest(requestId);
    refreshRequests();
  }

  Future<void> rejectRequest(int requestId) async {
    await ApiService.rejectRequest(requestId);
    refreshRequests();
  }

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final requests = snapshot.data ?? [];

          if (requests.isEmpty) {
            return const Center(child: Text('No requests yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requestId = request['id'];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request #$requestId',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Listing ID: ${request['listing_id']}'),
                      Text('From: ${request['requester_name']}'),
                      Text('Message: ${request['message'] ?? 'No message'}'),
                      Text('Status: ${request['status']}'),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await acceptRequest(requestId);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Request accepted')),
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
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await rejectRequest(requestId);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Request rejected')),
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
      floatingActionButton: FloatingActionButton(
        onPressed: refreshRequests,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}