import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';
import 'auth_dialog.dart';

class CommentSection extends StatefulWidget {
  final int articleId;
  final List<Comment> comments;
  final UserSession? currentSession;
  final Future<void> Function(String name, String email, String content) onSubmitComment;

  const CommentSection({
    super.key,
    required this.articleId,
    required this.comments,
    required this.currentSession,
    required this.onSubmitComment,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _populateUser();
  }

  @override
  void didUpdateWidget(covariant CommentSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentSession != oldWidget.currentSession) {
      _populateUser();
    }
  }

  void _populateUser() {
    if (widget.currentSession != null) {
      _nameController.text = widget.currentSession!.name;
      _emailController.text = widget.currentSession!.email;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final content = _contentController.text.trim();

    if (name.isEmpty || email.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name, email, and comment.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await widget.onSubmitComment(name, email, content);
    _contentController.clear();
    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment posted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.chat_bubble_outline, color: BlogTheme.primaryViolet),
            const SizedBox(width: 8),
            Text(
              'Discussion & Comments (${widget.comments.length})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Comment Input Box
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? BlogTheme.darkCardBg : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Leave a comment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              if (widget.currentSession == null) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Your Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Your Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _contentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts on this post...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Post Comment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BlogTheme.primaryViolet,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Comments List
        if (widget.comments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'No comments yet. Be the first to start the conversation!',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.comments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final c = widget.comments[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? BlogTheme.darkCardBg.withOpacity(0.6) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: BlogTheme.primaryViolet,
                      backgroundImage: c.authorAvatarUrl != null && c.authorAvatarUrl!.isNotEmpty
                          ? NetworkImage(c.authorAvatarUrl!)
                          : null,
                      child: c.authorAvatarUrl == null || c.authorAvatarUrl!.isEmpty
                          ? Text(
                              c.authorName.isNotEmpty ? c.authorName[0].toUpperCase() : 'U',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(
                                '${c.createdAt.day}/${c.createdAt.month}/${c.createdAt.year}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(c.content, style: const TextStyle(fontSize: 14, height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
