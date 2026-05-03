import 'package:flutter/material.dart';
import '../services/apiservice.dart';


class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  String backendResult = 'Press the button to test backend connection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Listings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final data = await ApiService.getListings();

                  setState(() {
                    backendResult = data.toString();
                  });

                
                  setState(() {
                    backendResult = data.toString();
                  });
                  } catch (error) {
                    setState(() {
                      backendResult = 'Error: $error';
                    });
                  }
              },
              child: const Text('Test Backend'),
            ),

                 
            const SizedBox(height: 20),
            Text(
              backendResult,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

