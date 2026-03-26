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

  final List<String> _categories = [
    'Nutrition',
    'Sleep',
    'Fitness',
    'Mental Health',
    'Stress Management',
    'Mindfulness'
  ];

  void _showAddTipDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = _categories.first;
    bool isAnonymous = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Share a Health Tip',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Help the community by sharing your best advice.',
                      style: TextStyle(fontSize: 14, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),

                    // Category Dropdown
                    Text('Category', style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black54)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          items: _categories.map((String cat) {
                            return DropdownMenuItem<String>(
                              value: cat,
                              child: Text(cat),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            if (val != null) setModalState(() => selectedCategory = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text('Title', style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black54)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'E.g., Drink water first thing in the morning',
                        filled: true,
                        fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF4CAF82), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Text('Description', style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black54)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Explain why it helps...',
                        filled: true,
                        fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF4CAF82), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Anonymous Checkbox
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: isAnonymous,
                            activeColor: const Color(0xFF4CAF82),
                            onChanged: (val) {
                              setModalState(() {
                                isAnonymous = val ?? true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Post Anonymously', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Cancel', style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                                final currentUser = _auth.currentUser;
                                final authorName = isAnonymous
                                    ? 'Anonymous'
                                    : (currentUser?.displayName?.isNotEmpty == true
                                        ? currentUser!.displayName!
                                        : 'Community Member');

                                await _firestore.collection('communityTips').add({
                                  'title': titleController.text,
                                  'description': descriptionController.text,
                                  'category': selectedCategory,
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF82),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Post Tip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Community Tips',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('communityTips')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong', style: TextStyle(color: isDark ? Colors.white54 : Colors.grey)));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4CAF82)));
          }

          final tips = snapshot.data?.docs ?? [];

          if (tips.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.forum_outlined, size: 64, color: isDark ? Colors.white24 : Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No tips yet.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Be the first to share one!',
                    style: TextStyle(color: isDark ? Colors.white54 : Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              final tipDoc = tips[index];
              final tip = tipDoc.data() as Map<String, dynamic>;
              final docId = tipDoc.id;

              final authorId = tip['authorId'] as String?;
              final isOwner = currentUserId != null && authorId == currentUserId;

              final upvotes = tip['upvotes'] as int? ?? 0;
              final downvotes = tip['downvotes'] as int? ?? 0;
              final score = upvotes - downvotes;
              
              final category = tip['category'] as String? ?? 'General';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upvote / Downvote column
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => _upvoteTip(docId, upvotes),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.keyboard_arrow_up_rounded, color: Color(0xFF4CAF82), size: 28),
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: score > 0 ? const Color(0xFF4CAF82) : (score < 0 ? Colors.redAccent : (isDark ? Colors.white : Colors.black87)),
                              ),
                            ),
                            InkWell(
                              onTap: () => _downvoteTip(docId, downvotes),
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.redAccent, size: 28),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Tip content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4CAF82).withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          category.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF4CAF82),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        tip['title'] as String? ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: isDark ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isOwner)
                                  InkWell(
                                    onTap: () => _deleteTip(docId),
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tip['description'] as String? ?? '',
                              style: TextStyle(
                                fontSize: 14, 
                                height: 1.5,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                                  child: Icon(Icons.person, size: 12, color: isDark ? Colors.white54 : Colors.grey.shade500),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'By ',
                                  style: TextStyle(
                                    color: isDark ? Colors.white54 : Colors.grey.shade600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTipDialog,
        backgroundColor: const Color(0xFF4CAF82),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Share Tip', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
