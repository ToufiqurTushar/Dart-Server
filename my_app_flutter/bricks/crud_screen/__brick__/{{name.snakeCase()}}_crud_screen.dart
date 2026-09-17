import 'package:flutter/material.dart';
import 'package:my_app_client/my_app_client.dart';
import '../main.dart';

class {{name.pascalCase()}}CrudScreen extends StatefulWidget {
  const {{name.pascalCase()}}CrudScreen({super.key});

  @override
  State<{{name.pascalCase()}}CrudScreen> createState() => _{{name.pascalCase()}}CrudScreenState();
}

class _{{name.pascalCase()}}CrudScreenState extends State<{{name.pascalCase()}}CrudScreen> {
  final _nameController = TextEditingController();
  List<{{name.pascalCase()}}> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    setState(() => _isLoading = true);
    try {
      // Auto-generated fetching logic
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage {{name.pascalCase()}} Records:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '{{name.pascalCase()}} Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text('Save {{name.pascalCase()}}'),
          ),
        ],
      ),
    );
  }
}
