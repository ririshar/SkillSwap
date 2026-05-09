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
  final contactController = TextEditingController();

  String selectedLevel = 'Beginner';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  String getAvailabilityText() {
    if (selectedDate == null || selectedTime == null) {
      return '';
    }

    final date =
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    final time = selectedTime!.format(context);

    return '$date at $time';
  }

  Future<void> submitListing() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (descriptionController.text.trim().length > 150) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Description must be 150 characters or less'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await ApiService.createListing(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        level: selectedLevel,
        availability: getAvailabilityText(),
        contact: contactController.text.trim(),
      );

      if (!mounted) return;

      titleController.clear();
      descriptionController.clear();

      setState(() {
        selectedLevel = 'Beginner';
        selectedDate = null;
        selectedTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing created successfully')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $error')));
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
    contactController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final descriptionLength = descriptionController.text.length;

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
              controller: contactController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Contact details',
                hintText: 'Discord, Instagram, email, etc.',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.contact_mail),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              maxLength: 150,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Briefly explain what the skill session is about',
                border: OutlineInputBorder(),
              ),
            ),

            Text(
              '$descriptionLength / 150 characters',
              style: TextStyle(
                color: descriptionLength > 150 ? Colors.red : Colors.grey,
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

            OutlinedButton.icon(
              onPressed: pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                selectedDate == null
                    ? 'Pick availability date'
                    : 'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              ),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: pickTime,
              icon: const Icon(Icons.access_time),
              label: Text(
                selectedTime == null
                    ? 'Pick availability time'
                    : 'Time: ${selectedTime!.format(context)}',
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
