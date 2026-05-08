import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  final List<Map<String, dynamic>> sentRequests;

  const RequestScreen({super.key, required this.sentRequests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sentRequests.length,
      itemBuilder: (context, index) {
        final request = sentRequests[index];
        return ListTile(
          title: Text(request['title']),
          subtitle: Text(request['description']),
        );
      },
    );
  }
}