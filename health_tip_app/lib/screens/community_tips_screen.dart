import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommunityTipsScreen extends StatefulWidget {
  const CommunityTipsScreen({super.key});

  @override
  State<CommunityTipsScreen> createState() => _CommunityTipsScreenState();
}

class _CommunityTipsScreenState extends State<CommunityTipsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      final currentUser = _auth.currentUser;
                      // Fallback name if no user is totally logged in, but better to use displayName or 'Community Member'
                      final authorName = isAnonymous
                          ? 'Anonymous'
                          : (currentUser?.displayName?.isNotEmpty == true
                                ? currentUser!.displayName!
                                : 'Community Member');

                      await _firestore.collection('communityTips').add({
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'author': authorName,
                        'authorId': currentUser?.uid ?? 'unknown',
                        'upvotes': 0,
                        'downvotes': 0,
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
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

  void _deleteTip(String docId) async {
    await _firestore.collection('communityTips').doc(docId).delete();
  }

  void _upvoteTip(String docId, int currentUpvotes) async {
    await _firestore.collection('communityTips').doc(docId).update({
      'upvotes': currentUpvotes + 1,
    });
  }

  void _downvoteTip(String docId, int currentDownvotes) async {
    await _firestore.collection('communityTips').doc(docId).update({
      'downvotes': currentDownvotes + 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = _auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Community Tips')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('communityTips')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tips = snapshot.data?.docs ?? [];

          if (tips.isEmpty) {
            return const Center(
              child: Text('No tips yet. Be the first to share!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              final tipDoc = tips[index];
              final tip = tipDoc.data() as Map<String, dynamic>;
              final docId = tipDoc.id;

              final authorId = tip['authorId'] as String?;
              final isOwner =
                  currentUserId != null && authorId == currentUserId;

              final upvotes = tip['upvotes'] as int? ?? 0;
              final downvotes = tip['downvotes'] as int? ?? 0;
              final score = upvotes - downvotes;

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
                              color: Color(0xFF4CAF82),
                            ),
                            onPressed: () => _upvoteTip(docId, upvotes),
                          ),
                          Text(
                            '$score',
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
                            onPressed: () => _downvoteTip(docId, downvotes),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      // Tip content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    tip['title'] as String? ?? '',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (isOwner)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _deleteTip(docId),
                                    tooltip: 'Delete Tip',
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              tip['description'] as String? ?? '',
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
                                  'By: ${tip['author'] ?? 'Unknown'}',
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
