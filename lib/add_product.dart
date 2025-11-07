import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  String? _selectedCategory;
  bool _isFeatured = false;

  final List<String> _categories = [
    'Jersey',
    'Ball',
    'Shoes',
    'Accessories',
    'Equipment',
    'Merchandise',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price cannot be empty';
    }
    final double? price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid number';
    }
    if (price <= 0) {
      return 'Price must be greater than 0';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description cannot be empty';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    if (value.length > 500) {
      return 'Description must be less than 500 characters';
    }
    return null;
  }

  String? _validateThumbnail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Thumbnail URL cannot be empty';
    }
    final Uri? uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  String? _validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Collect data
      final String name = _nameController.text;
      final double price = double.parse(_priceController.text);
      final String description = _descriptionController.text;
      final String thumbnail = _thumbnailController.text;
      final String category = _selectedCategory ?? '';
      final bool isFeatured = _isFeatured;

      // Show dialog with data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Product Saved'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name'),
                Text('Price: \$${price.toStringAsFixed(2)}'),
                Text('Description: $description'),
                Text('Thumbnail: $thumbnail'),
                Text('Category: $category'),
                Text('Is Featured: ${isFeatured ? 'Yes' : 'No'}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Go back to home
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: _validateNotEmpty,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: _validatePrice,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: _validateDescription,
              ),
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                validator: _validateThumbnail,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: _validateCategory,
              ),
              SwitchListTile(
                title: const Text('Is Featured'),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}