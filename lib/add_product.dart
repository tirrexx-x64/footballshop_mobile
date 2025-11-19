import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _categories = <String>[
    'Jersey',
    'Shoes',
    'Accessories',
    'Ball',
  ];

  late String _name;
  late String _price;
  late String _description;
  late String _thumbnail;
  late String _category;
  late bool _isFeatured;
  late String _stock;
  late String _brand;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final fields = widget.product!.fields;
      _name = fields.name;
      _price = fields.price.toString();
      _description = fields.description;
      _thumbnail = fields.thumbnail;
      _category = _categories.contains(fields.category) ? fields.category : '';
      _isFeatured = fields.isFeatured;
      _stock = fields.stock.toString();
      _brand = fields.brand;
    } else {
      _name = '';
      _price = '';
      _description = '';
      _thumbnail = '';
      _category = '';
      _isFeatured = false;
      _stock = '';
      _brand = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Edit Product' : 'Create Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _price = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price cannot be empty';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Price must be a number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Thumbnail URL',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _thumbnail = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Thumbnail URL cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  value: _category.isEmpty ? null : _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _stock = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Stock cannot be empty';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Stock must be a number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _brand = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Brand cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Featured'),
                  value: _isFeatured,
                  onChanged: (value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Ganti URL dengan URL Django kamu
                      // Emulator Android: http://10.0.2.2:8000/
                      // Chrome/web: http://localhost:8000/
                      final data = {
                        'name': _name,
                        'price': int.parse(_price),
                        'description': _description,
                        'thumbnail': _thumbnail,
                        'category': _category,
                        'is_featured': _isFeatured,
                        'stock': int.parse(_stock),
                        'brand': _brand,
                      };
                      dynamic response;
                      if (widget.product != null) {
                        // Edit
                        response = await request.postJson(
                          'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/edit_product_flutter/${widget.product!.pk}/',
                          jsonEncode(data),
                        );
                      } else {
                        // Create
                        response = await request.postJson(
                          'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/create-flutter/',
                          jsonEncode(data),
                        );
                      }

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(widget.product != null ? 'Product successfully updated!' : 'Product successfully saved!'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Something went wrong, please try again.',
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(widget.product != null ? 'Update Product' : 'Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

