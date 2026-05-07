import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final List<String> requestTitles = [
    'Python Programming Help',
    'Spanish Conversation Practice',
  ];

  final List<String> requestUsers = [
    'Jamie T.',
    'Nina R.',
  ];

  final List<String> requestTimes = [
    'Tue 14:00',
    'Wed 11:30',
  ];

  final List<String> requestStatuses = [
    'Pending',
    'Pending',
  ];

  void updateRequestStatus(int index, String status) {
    setState(() {
      requestStatuses[index] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Request marked as $status')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Lesson Requests',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        for (int i = 0; i < requestTitles.length; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestTitles[i],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('From: ${requestUsers[i]}'),
                  Text('Time: ${requestTimes[i]}'),
                  Text('Status: ${requestStatuses[i]}'),
                  const SizedBox(height: 12),

                  if (requestStatuses[i] == 'Pending')
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            updateRequestStatus(i, 'Accepted');
                          },
                          child: const Text('Accept'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            updateRequestStatus(i, 'Declined');
                          },
                          child: const Text('Decline'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
