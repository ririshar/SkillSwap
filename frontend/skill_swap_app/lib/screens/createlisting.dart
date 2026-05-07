import 'package:flutter/material.dart';

class CreateListingScreen extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final TextEditingController availabilityController;
  final VoidCallback onCreateListing;

  const CreateListingScreen({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.tagsController,
    required this.availabilityController,
    required this.onCreateListing,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
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
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: tagsController,
          decoration: const InputDecoration(
            labelText: 'Tags, e.g. Coding, Python',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: availabilityController,
          decoration: const InputDecoration(
            labelText: 'Availability, e.g. Tuesday 14:00',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onCreateListing,
          child: const Text('Create Listing'),
        ),
      ],
    );
  }
}
