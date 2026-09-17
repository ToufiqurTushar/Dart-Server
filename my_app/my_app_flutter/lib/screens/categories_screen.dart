import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../main.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _nameController = TextEditingController();
  List<Category> _categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.article.getCategories();
      setState(() => _categories = list);
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  Future<void> _addCategory() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    try {
      final slug = name.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
      final newCat = Category(name: name, slug: slug);
      await client.article.createCategory(newCat);
      _nameController.clear();
      await _fetchCategories();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding category: $e')),
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
            'Create New Category:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Category Name (e.g. Technology, Science)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _addCategory,
            icon: const Icon(Icons.category),
            label: const Text('Save Category'),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories List:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _fetchCategories,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _categories.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: Text('No categories created yet.')),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.folder),
                            title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
