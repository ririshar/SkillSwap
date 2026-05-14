import 'package:flutter/material.dart';
import '../services/apiservice.dart';

// This screen allows users to create a new skill listing
class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  // Controllers used to get text from the input fields
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contactController = TextEditingController();

  // Stores the selected skill level
  String selectedLevel = 'Beginner';

  // Stores the selected availability date and time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Tracks when the form is being submitted
  bool isLoading = false;

  // Opens the date picker and saves the selected date
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

  // Opens the time picker and saves the selected time
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

  // Combines the selected date and time into one availability text
  String getAvailabilityText() {
    if (selectedDate == null || selectedTime == null) {
      return '';
    }

    final date =
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    final time = selectedTime!.format(context);

    return '$date at $time';
  }

  // Checks the form and sends the listing to the backend
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

    // Checks that the description is not too long
    if (descriptionController.text.trim().length > 150) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Description must be 150 characters or less'),
        ),
      );
      return;
    }

    // Shows loading while the listing is being created
    setState(() {
      isLoading = true;
    });

    try {
      // Sends the listing data to the backend
      await ApiService.createListing(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        level: selectedLevel,
        availability: getAvailabilityText(),
        contact: contactController.text.trim(),
      );

      if (!mounted) return;

      // Clears the form after the listing is created
      titleController.clear();
      descriptionController.clear();
      contactController.clear();

      // Resets the selected values
      setState(() {
        selectedLevel = 'Beginner';
        selectedDate = null;
        selectedTime = null;
      });

      // Shows a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing created successfully')),
      );
    } catch (error) {
      if (!mounted) return;

      // Shows an error message if the listing fails
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $error')));
    }

    if (!mounted) return;

    // Stops the loading state
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // Disposes controllers when the screen is closed
    titleController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Gets the current length of the description
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

            // Input field for the skill title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Skill title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Input field for contact details
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

            // Input field for the listing description
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

            // Shows the description character count
            Text(
              '$descriptionLength / 150 characters',
              style: TextStyle(
                color: descriptionLength > 150 ? Colors.red : Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // Dropdown for selecting the skill level
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

            // Button for choosing the availability date
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

            // Button for choosing the availability time
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

            // Button that submits the listing
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
