import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../theme/blog_theme.dart';

class ArticleEditorDialog extends StatefulWidget {
  final Article? article;
  final List<Category> categories;
  final List<Tag> tags;
  final Function(Article article) onSave;

  const ArticleEditorDialog({
    super.key,
    this.article,
    required this.categories,
    required this.tags,
    required this.onSave,
  });

  static Future<void> show(
    BuildContext context, {
    Article? article,
    required List<Category> categories,
    required List<Tag> tags,
    required Function(Article) onSave,
  }) {
    return showDialog(
      context: context,
      builder: (context) => ArticleEditorDialog(
        article: article,
        categories: categories,
        tags: tags,
        onSave: onSave,
      ),
    );
  }

  @override
  State<ArticleEditorDialog> createState() => _ArticleEditorDialogState();
}

class _ArticleEditorDialogState extends State<ArticleEditorDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _slugController;
  late TextEditingController _summaryController;
  late TextEditingController _contentController;
  late TextEditingController _coverController;
  late TextEditingController _authorController;
  late TextEditingController _authorAvatarController;
  late TextEditingController _readingTimeController;

  int? _selectedCategoryId;
  bool _isFeatured = false;
  String _status = 'published';

  @override
  void initState() {
    super.initState();
    final a = widget.article;
    _titleController = TextEditingController(text: a?.title ?? '');
    _slugController = TextEditingController(text: a?.slug ?? '');
    _summaryController = TextEditingController(text: a?.summary ?? '');
    _contentController = TextEditingController(text: a?.content ?? '');
    _coverController = TextEditingController(text: a?.coverImageUrl ?? 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800');
    _authorController = TextEditingController(text: a?.authorName ?? 'Admin Editorial');
    _authorAvatarController = TextEditingController(text: a?.authorAvatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150');
    _readingTimeController = TextEditingController(text: (a?.readingTimeMinutes ?? 5).toString());
    
    _selectedCategoryId = a?.categoryId ?? (widget.categories.isNotEmpty ? widget.categories.first.id : null);
    _isFeatured = a?.isFeatured ?? false;
    _status = a?.status ?? 'published';

    _titleController.addListener(_generateSlug);
  }

  void _generateSlug() {
    if (widget.article == null) {
      final slug = _titleController.text
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
          .replaceAll(RegExp(r'\s+'), '-');
      _slugController.text = slug;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _summaryController.dispose();
    _contentController.dispose();
    _coverController.dispose();
    _authorController.dispose();
    _authorAvatarController.dispose();
    _readingTimeController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final newArticle = Article(
        id: widget.article?.id,
        title: _titleController.text.trim(),
        slug: _slugController.text.trim(),
        summary: _summaryController.text.trim(),
        content: _contentController.text.trim(),
        coverImageUrl: _coverController.text.trim(),
        authorName: _authorController.text.trim(),
        authorAvatarUrl: _authorAvatarController.text.trim(),
        status: _status,
        viewsCount: widget.article?.viewsCount ?? 0,
        likesCount: widget.article?.likesCount ?? 0,
        readingTimeMinutes: int.tryParse(_readingTimeController.text) ?? 5,
        isFeatured: _isFeatured,
        publishedAt: _status == 'published' ? (widget.article?.publishedAt ?? now) : null,
        createdAt: widget.article?.createdAt ?? now,
        updatedAt: now,
        categoryId: _selectedCategoryId,
      );

      widget.onSave(newArticle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEditing = widget.article != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: isDark ? BlogTheme.darkCardBg : Colors.white,
      child: Container(
        width: 750,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Edit Post Studio' : 'Create New Article Studio',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12),

                // Form rows
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Article Title',
                    hintText: 'Enter an engaging title...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _slugController,
                        decoration: const InputDecoration(
                          labelText: 'URL Slug',
                          prefixText: 'blog/',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedCategoryId,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.categories.map((c) {
                          return DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.name),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedCategoryId = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _summaryController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Short Subtitle / Excerpt Summary',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _contentController,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    labelText: 'Article Body Content (Markdown supported)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Content cannot be empty' : null,
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _coverController,
                        decoration: const InputDecoration(
                          labelText: 'Cover Image URL',
                          prefixIcon: Icon(Icons.image_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _readingTimeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Read Time (Minutes)',
                          prefixIcon: Icon(Icons.timer_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _authorController,
                        decoration: const InputDecoration(
                          labelText: 'Author Name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _authorAvatarController,
                        decoration: const InputDecoration(
                          labelText: 'Author Avatar URL',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Toggles: Status & Featured
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Publish Immediately'),
                        subtitle: Text(_status == 'published' ? 'Visible on public feed' : 'Saved as draft'),
                        value: _status == 'published',
                        activeColor: BlogTheme.primaryViolet,
                        onChanged: (val) => setState(() => _status = val ? 'published' : 'draft'),
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Highlight as Featured'),
                        subtitle: const Text('Displays in Hero banner'),
                        value: _isFeatured,
                        activeColor: BlogTheme.goldYellow,
                        onChanged: (val) => setState(() => _isFeatured = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Save buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _handleSave,
                      icon: const Icon(Icons.save),
                      label: Text(isEditing ? 'Save Changes' : 'Publish Article'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BlogTheme.primaryViolet,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
