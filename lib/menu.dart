import 'package:flutter/material.dart';
import 'package:football_news/add_product.dart';

// ======================================================
// Class ItemHomepage
// ======================================================
// Menyimpan data untuk setiap tombol card (name dan icon)
class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}

// ======================================================
// Class InfoCard
// ======================================================
// Kartu informasi sederhana untuk menampilkan NPM, Nama, dan Kelas.
class InfoCard extends StatelessWidget {
  final String title;   // Judul kartu
  final String content; // Isi kartu

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// Class ItemCard
// ======================================================
// Card tombol dengan ikon dan teks
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final int index;

  const ItemCard(this.item, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors for each button
    List<Color> colors = [Colors.blue, Colors.green, Colors.red];
    Color buttonColor = colors[index % colors.length];

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}"),
                ),
              );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// Class MyHomePage
// ======================================================
// Halaman utama aplikasi yang menampilkan InfoCard dan ItemCard
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // Data pribadi
  final String nama = "Tirta Rendy Siahaan";
  final String npm = "2406355621";
  final String kelas = "C";

  // Daftar tombol di halaman utama
  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.inventory),
    ItemHomepage("My Products", Icons.person),
    ItemHomepage("Create Product", Icons.add),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Football Shop Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Halaman Utama'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Produk'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProductPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris InfoCard
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Konten utama
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Football Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // Grid tombol
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.asMap().entries.map((entry) {
                      int index = entry.key;
                      ItemHomepage item = entry.value;
                      return ItemCard(item, index);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
