import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const SkillSwapApp());
}

class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillSwap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SkillSwap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final availabilityController = TextEditingController();

  final List<String> skillTitles = [
    'Python Programming Help',
    'Spanish Conversation Practice',
    'CAD Basics Support',
  ];

  final List<String> skillDescriptions = [
    'Help with beginner Python, coursework logic, and debugging.',
    'Practice Spanish speaking with another student.',
    'Basic CAD support for engineering students.',
  ];

  final List<String> skillLevels = [
    'Beginner',
    'Intermediate',
    'Beginner',
  ];

  final List<String> skillTimes = [
    'Available Tue 14:00',
    'Available Wed 11:30',
    'Available Fri 16:00',
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    availabilityController.dispose();
    super.dispose();
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void createListing() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final tags = tagsController.text.trim();
    final availability = availabilityController.text.trim();

    if (title.isEmpty ||
        description.isEmpty ||
        tags.isEmpty ||
        availability.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      skillTitles.add(title);
      skillDescriptions.add('$description\nTags: $tags');
      skillLevels.add('Beginner');
      skillTimes.add('Available $availability');

      titleController.clear();
      descriptionController.clear();
      tagsController.clear();
      availabilityController.clear();

      selectedIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Listing created and added to Browse')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget getCurrentPage() {
    if (selectedIndex == 0) {
      return buildHomePage();
    } else if (selectedIndex == 1) {
      return buildCreateListingPage();
    } else {
      return buildProfilePage();
    }
  }

  Widget buildHomePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Browse Skills',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Search for a skill',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < skillTitles.length; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.school),
              title: Text(skillTitles[i]),
              subtitle: Text(
                '${skillDescriptions[i]}\nLevel: ${skillLevels[i]}\n${skillTimes[i]}',
              ),
              isThreeLine: true,
              trailing: ElevatedButton(
                onPressed: () {
                  showSkillDetails(skillTitles[i]);
                },
                child: const Text('View'),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildCreateListingPage() {
    return Padding(
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
            onPressed: createListing,
            child: const Text('Create Listing'),
          ),
        ],
      ),
    );
  }

  Widget buildProfilePage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person, size: 40),
          ),
          const SizedBox(height: 20),
          const Text(
            'Name: Student User',
            style: TextStyle(fontSize: 18),
          ),
          const Text(
            'University: University of Portsmouth',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Hide surname'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Show course'),
            value: false,
            onChanged: (value) {},
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Export My Data'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  void showSkillDetails(String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: const Text(
            'This is where the user can request a lesson, chat, report, or block another user.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lesson request sent')),
                );
              },
              child: const Text('Request Lesson'),
            ),
          ],
        );
      },
    );
  }
}
