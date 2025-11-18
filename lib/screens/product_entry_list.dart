import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/product_entry_card.dart';
import 'package:football_shop/screens/product_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    // Ganti dengan URL Django kamu, jangan lupa trailing slash (/)
    // Android emulator: http://10.0.2.2:8000/
    // Chrome/web: http://localhost:8000/
    final response = await request.get('https://tirta-rendy-footballshops.pbp.cs.ui.ac.id/json/');

    // response dari CookieRequest sudah berbentuk List<dynamic>
    final data = response;

    final List<Product> products = [];
    for (final d in data) {
      if (d != null) {
        products.add(Product.fromJson(d));
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
              );
            },
          );
        },
      ),
    );
  }
}

