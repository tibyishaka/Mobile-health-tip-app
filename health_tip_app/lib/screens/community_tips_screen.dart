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

  static const List<String> _categoryFilters = [
    'All',
    'Nutrition',
    'Sleep',
    'Fitness',
    'Mental Health',
    'Stress Management',
    'Mindfulness',
  ];

  String _selectedFilter = 'All';
  int _limit = 20;

  Stream<QuerySnapshot> get _tipsStream {
    Query query = _firestore
        .collection('communityTips')
        .orderBy('timestamp', descending: true)
        .limit(_limit);

    if (_selectedFilter != 'All') {
      query = _firestore
          .collection('communityTips')
          .where('category', isEqualTo: _selectedFilter)
          .orderBy('timestamp', descending: true)
          .limit(_limit);
    }

    return query.snapshots();
  }

  // ─── Voting ────────────────────────────────────────────────────────────────

  Future<void> _vote(
    String docId,
    Map<String, dynamic> data,
    bool isUpvote,
  ) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final upvoterIds = List<String>.from(data['upvoterIds'] ?? []);
    final downvoterIds = List<String>.from(data['downvoterIds'] ?? []);
    final Map<String, dynamic> updates = {};

    if (isUpvote) {
      if (upvoterIds.contains(userId)) {
        // Toggle off existing upvote
        updates['upvoterIds'] = FieldValue.arrayRemove([userId]);
        updates['upvotes'] = FieldValue.increment(-1);
      } else {
        updates['upvoterIds'] = FieldValue.arrayUnion([userId]);
        updates['upvotes'] = FieldValue.increment(1);
        // Remove any prior downvote
        if (downvoterIds.contains(userId)) {
          updates['downvoterIds'] = FieldValue.arrayRemove([userId]);
          updates['downvotes'] = FieldValue.increment(-1);
        }
      }
    } else {
      if (downvoterIds.contains(userId)) {
        // Toggle off existing downvote
        updates['downvoterIds'] = FieldValue.arrayRemove([userId]);
        updates['downvotes'] = FieldValue.increment(-1);
      } else {
        updates['downvoterIds'] = FieldValue.arrayUnion([userId]);
        updates['downvotes'] = FieldValue.increment(1);
        // Remove any prior upvote
        if (upvoterIds.contains(userId)) {
          updates['upvoterIds'] = FieldValue.arrayRemove([userId]);
          updates['upvotes'] = FieldValue.increment(-1);
        }
      }
    }

    await _firestore.collection('communityTips').doc(docId).update(updates);
  }

  // ─── Delete with confirmation ──────────────────────────────────────────────

  void _confirmDelete(String docId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete this tip?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        content: Text(
          'This action cannot be undone.',
          style: TextStyle(
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              _firestore.collection('communityTips').doc(docId).delete();
              Navigator.pop(ctx, true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // ─── Add tip dialog ────────────────────────────────────────────────────────

  void _showAddTipDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = _categoryFilters[1]; // 'Nutrition'
    bool isAnonymous = true;

    // Use only real categories (skip 'All')
    final tipCategories = _categoryFilters.skip(1).toList();

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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Category dropdown
                    Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          dropdownColor: isDark
                              ? const Color(0xFF2A2A2A)
                              : Colors.white,
                          items: tipCategories.map((cat) {
                            return DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setModalState(() => selectedCategory = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title field with character limit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: titleController,
                          builder: (_, v, __) => Text(
                            '${v.text.length}/100',
                            style: TextStyle(
                              fontSize: 12,
                              color: v.text.length > 90
                                  ? Colors.redAccent
                                  : (isDark
                                        ? Colors.grey.shade500
                                        : Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      maxLength: 100,
                      buildCounter:
                          (
                            _, {
                            required currentLength,
                            required isFocused,
                            maxLength,
                          }) => null,
                      decoration: InputDecoration(
                        hintText:
                            'E.g., Drink water first thing in the morning',
                        filled: true,
                        fillColor: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF5F7FA),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF4CAF82),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description field with character limit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: descriptionController,
                          builder: (_, v, __) => Text(
                            '${v.text.length}/500',
                            style: TextStyle(
                              fontSize: 12,
                              color: v.text.length > 450
                                  ? Colors.redAccent
                                  : (isDark
                                        ? Colors.grey.shade500
                                        : Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      maxLength: 500,
                      buildCounter:
                          (
                            _, {
                            required currentLength,
                            required isFocused,
                            maxLength,
                          }) => null,
                      decoration: InputDecoration(
                        hintText: 'Explain why it helps...',
                        filled: true,
                        fillColor: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF5F7FA),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF4CAF82),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Anonymous toggle
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: isAnonymous,
                            activeColor: const Color(0xFF4CAF82),
                            onChanged: (val) =>
                                setModalState(() => isAnonymous = val ?? true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Post Anonymously',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final title = titleController.text.trim();
                              final desc = descriptionController.text.trim();
                              if (title.isEmpty || desc.isEmpty) return;

                              final currentUser = _auth.currentUser;
                              final authorName = isAnonymous
                                  ? 'Anonymous'
                                  : (currentUser?.displayName?.isNotEmpty ==
                                            true
                                        ? currentUser!.displayName!
                                        : 'Community Member');

                              await _firestore.collection('communityTips').add({
                                'title': title,
                                'description': desc,
                                'category': selectedCategory,
                                'author': authorName,
                                'authorId': currentUser?.uid ?? 'unknown',
                                'upvotes': 0,
                                'downvotes': 0,
                                'upvoterIds': [],
                                'downvoterIds': [],
                                'timestamp': FieldValue.serverTimestamp(),
                              });

                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF82),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Post Tip',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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

  // ─── Build ────────────────────────────────────────────────────────────────

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

      // ── Category filter chips ──────────────────────────────────────────────
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _categoryFilters.length,
              itemBuilder: (context, index) {
                final filter = _categoryFilters[index];
                final isSelected = filter == _selectedFilter;
                return ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = filter;
                      _limit = 20; // reset pagination when filter changes
                    });
                  },
                  selectedColor: const Color(0xFF4CAF82),
                  backgroundColor: isDark
                      ? const Color(0xFF2A2A2A)
                      : Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.grey.shade300 : Colors.black87),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                );
              },
            ),
          ),

          // ── Tips stream ───────────────────────────────────────────────────
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _tipsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4CAF82)),
                  );
                }

                final tips = snapshot.data?.docs ?? [];

                if (tips.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.forum_outlined,
                          size: 64,
                          color: isDark ? Colors.white24 : Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedFilter == 'All'
                              ? 'No tips yet.'
                              : 'No tips in $_selectedFilter yet.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Be the first to share one!',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white54
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                  itemCount: tips.length + (tips.length == _limit ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Load More button at the end
                    if (index == tips.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: OutlinedButton(
                            onPressed: () => setState(() => _limit += 20),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4CAF82),
                              side: const BorderSide(color: Color(0xFF4CAF82)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Load More'),
                          ),
                        ),
                      );
                    }

                    final tipDoc = tips[index];
                    final tip = tipDoc.data() as Map<String, dynamic>;
                    final docId = tipDoc.id;

                    final authorId = tip['authorId'] as String?;
                    final isOwner =
                        currentUserId != null && authorId == currentUserId;

                    final upvotes = tip['upvotes'] as int? ?? 0;
                    final downvotes = tip['downvotes'] as int? ?? 0;
                    final upvoterIds = List<String>.from(
                      tip['upvoterIds'] ?? [],
                    );
                    final downvoterIds = List<String>.from(
                      tip['downvoterIds'] ?? [],
                    );

                    final hasUpvoted =
                        currentUserId != null &&
                        upvoterIds.contains(currentUserId);
                    final hasDownvoted =
                        currentUserId != null &&
                        downvoterIds.contains(currentUserId);

                    final category = tip['category'] as String? ?? 'General';
                    final author =
                        tip['author'] as String? ?? 'Community Member';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                        ),
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
                            // Vote column
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFF5F7FA),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  // Upvote
                                  InkWell(
                                    onTap: () => _vote(docId, tip, true),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: hasUpvoted
                                            ? const Color(0xFF4CAF82)
                                            : (isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade400),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$upvotes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: hasUpvoted
                                          ? const Color(0xFF4CAF82)
                                          : (isDark
                                                ? Colors.white54
                                                : Colors.black54),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '$downvotes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: hasDownvoted
                                          ? Colors.redAccent
                                          : (isDark
                                                ? Colors.white54
                                                : Colors.black54),
                                    ),
                                  ),
                                  // Downvote
                                  InkWell(
                                    onTap: () => _vote(docId, tip, false),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: hasDownvoted
                                            ? Colors.redAccent
                                            : (isDark
                                                  ? Colors.grey.shade500
                                                  : Colors.grey.shade400),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFF4CAF82,
                                                ).withOpacity(0.12),
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isOwner)
                                        InkWell(
                                          onTap: () => _confirmDelete(docId),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                              size: 20,
                                            ),
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
                                      color: isDark
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: isDark
                                            ? Colors.grey.shade800
                                            : Colors.grey.shade200,
                                        child: Icon(
                                          Icons.person,
                                          size: 12,
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.grey.shade500,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        author,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white54
                                              : Colors.grey.shade600,
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
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTipDialog,
        backgroundColor: const Color(0xFF4CAF82),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Share Tip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
