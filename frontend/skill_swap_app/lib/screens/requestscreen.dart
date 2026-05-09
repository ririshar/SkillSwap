import 'package:flutter/material.dart';
import '../services/apiservice.dart';

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

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.mail),
                  title: Text('Request for listing ID: ${request['listing_id']}'),
                  subtitle: Text(
                    'From: ${request['requester_name']}\n'
                    'Message: ${request['message'] ?? 'No message'}\n'
                    'Status: ${request['status']}',
                  ),
                  isThreeLine: true,
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