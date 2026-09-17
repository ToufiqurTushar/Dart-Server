import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../main.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final _nameController = TextEditingController();
  List<Tag> _tags = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.article.getTags();
      setState(() => _tags = list);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading tags: $e')),
        );
      }
    }
  }

  Future<void> _addTag() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    try {
      final slug = name.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
      final newTag = Tag(name: name, slug: slug);
      await client.article.createTag(newTag);
      _nameController.clear();
      await _fetchTags();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding tag: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create New Tag (Many-to-Many):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Tag Name (e.g. #flutter, #dart, #serverpod)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _addTag,
            icon: const Icon(Icons.tag),
            label: const Text('Save Tag'),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Tags:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _fetchTags,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _tags.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: Text('No tags created yet.')),
                    )
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _tags.map((tag) {
                        return Chip(
                          avatar: const Icon(Icons.label, size: 16),
                          label: Text(tag.name),
                          backgroundColor: Colors.blue.shade50,
                        );
                      }).toList(),
                    ),
        ],
      ),
    );
  }
}
