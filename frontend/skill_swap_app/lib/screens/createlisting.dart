import 'package:flutter/material.dart';
import '../services/apiservice.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final availabilityController = TextEditingController();

  String selectedLevel = 'Beginner';
  bool isLoading = false;

  Future<void> submitListing() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        availabilityController.text.isEmpty) {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
  }
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.createListing(
        title: titleController.text,
        description: descriptionController.text,
        level: selectedLevel,
        availability: availabilityController.text,
      );

      titleController.clear();
      descriptionController.clear();
      availabilityController.clear();


    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing created successfully')),
      );
    }
    } catch (error) {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  } 

  if (mounted) {
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    availabilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Create Skill Listing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Skill title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedLevel,
              decoration: const InputDecoration(
                labelText: 'Skill level',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLevel = value!;
                });
              },
            ),
            const SizedBox(height: 12),

            TextField(
              controller: availabilityController,
              decoration: const InputDecoration(
                labelText: 'Availability (e.g. Tuesday 14:00)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : submitListing,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Listing'),
            ),
          ],
        ),
      ),
    );
  }
}