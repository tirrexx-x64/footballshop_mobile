import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football_shop/add_product.dart';
import 'package:football_shop/models/product.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/product_entry_card.dart';
import 'package:football_shop/screens/product_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key, this.onlyMyProducts = false});

  final bool onlyMyProducts;

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    // TODO: Ganti dengan URL Django kamu, jangan lupa trailing slash (/)
    // Android emulator: http://10.0.2.2:8000/
    // Chrome/web: http://localhost:8000/
    String url;
    if (widget.onlyMyProducts) {
      final dynamic currentUserId = request.jsonData['id'];
      final int? userId = currentUserId != null ? (currentUserId is int ? currentUserId : int.tryParse(currentUserId.toString())) : null;
      if (userId != null) {
        url = 'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/api/products/user/$userId/';
      } else {
        // Fallback to all if no userId
        url = 'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/products/json/';
      }
    } else {
      url = 'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/products/json/';
    }
    final response = await request.get(url);

    // response dari CookieRequest sudah berbentuk List<dynamic>
    final data = response;

    print('Response data: $data'); // Debug print

    List<Product> products = [];
    for (final d in data) {
      if (d != null) {
        products.add(Product.fromJson(d));
      }
    }

    print('Total products fetched: ${products.length}');

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print('jsonData: ${request.jsonData}');
    final dynamic userIdDynamic = request.jsonData['id'];
    final int? currentUserId = userIdDynamic != null
        ? (userIdDynamic is int ? userIdDynamic : int.tryParse(userIdDynamic.toString()))
        : null;
    print('Current user ID in build: $currentUserId');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMyProducts ? 'My Products' : 'All Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'There are no products in football shop yet.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff59A5D8),
                ),
              ),
            );
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductEntryCard(
                product: product,
                currentUserId: currentUserId,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product: product,
                      ),
                    ),
                  );
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductPage(product: product),
                    ),
                  ).then((_) => setState(() {})); // Refresh after edit
                },
                onDelete: () async {
                  final request = context.read<CookieRequest>();
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Product'),
                      content: const Text('Are you sure you want to delete this product?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    final response = await request.postJson(
                      'https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/delete_product_flutter/${product.pk}/',
                      jsonEncode({}),
                    );
                    if (response['status'] == 'success') {
                      setState(() {}); // Refresh list
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product deleted successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to delete product')),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

