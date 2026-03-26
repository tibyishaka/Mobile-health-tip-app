import 'package:flutter/material.dart';

class CommunityTipsScreen extends StatefulWidget {
  const CommunityTipsScreen({super.key});

  @override
  State<CommunityTipsScreen> createState() => _CommunityTipsScreenState();
}

class _CommunityTipsScreenState extends State<CommunityTipsScreen> {
  final List<Map<String, dynamic>> _tips = [
    {
      'title': 'Drink plenty of water every morning',
      'description':
          'Hydration is key to start the day right. A glass of lukewarm water helps digestion.',
      'author': 'Anonymous',
      'upvotes': 15,
      'downvotes': 2,
    },
    {
      'title': 'Take a 10-minute walk after meals',
      'description':
          'Light walking helps regulate blood sugar levels and improves digestion.',
      'author': 'Jane Doe',
      'upvotes': 34,
      'downvotes': 0,
    },
    {
      'title': 'Practice 4-7-8 breathing before bed',
      'description':
          'Breathe in for 4, hold for 7, out for 8. It calms the nervous system.',
      'author': 'Anonymous',
      'upvotes': 12,
      'downvotes': 1,
    },
  ];

  void _showAddTipDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    bool isAnonymous = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add a Health Tip'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: isAnonymous,
                          onChanged: (val) {
                            setDialogState(() {
                              isAnonymous = val ?? true;
                            });
                          },
                        ),
                        const Text('Post as Anonymous'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      setState(() {
                        _tips.insert(0, {
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'author': isAnonymous
                              ? 'Anonymous'
                              : 'Community Member', // Harcoded name if not anonymous
                          'upvotes': 0,
                          'downvotes': 0,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Post Tip'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Tips')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          final tip = _tips[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upvote / Downvote column
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            tip['upvotes'] = (tip['upvotes'] as int) + 1;
                          });
                        },
                      ),
                      Text(
                        '${(tip['upvotes'] as int) - (tip['downvotes'] as int)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            tip['downvotes'] = (tip['downvotes'] as int) + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Tip content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tip['description'] as String,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'By: ${tip['author']}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTipDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
