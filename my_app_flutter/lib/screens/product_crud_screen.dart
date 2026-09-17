import 'package:flutter/material.dart';

class ProductCrudScreen extends StatefulWidget {
  const ProductCrudScreen({super.key});

  @override
  State<ProductCrudScreen> createState() => _ProductCrudScreenState();
}

class _ProductCrudScreenState extends State<ProductCrudScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manage Records:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Record Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text('Save Record'),
          ),
        ],
      ),
    );
  }
}
