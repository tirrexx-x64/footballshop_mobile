JAWABAN README TUGAS 1 FLUTTER :

1. Widget Tree pada Flutter
Widget tree adalah struktur hierarki yang membentuk UI aplikasi Flutter. Setiap widget dapat memiliki child widget, dan hubungan parent-child bekerja dengan cara parent widget mengatur layout dan properti untuk child-nya. Misalnya, Scaffold sebagai parent dapat memiliki AppBar dan body sebagai child, di mana body sendiri bisa berisi Column yang memiliki beberapa Text atau Button sebagai child-nya.

2. Widget yang Digunakan dalam Proyek Ini
- MaterialApp: Widget root yang menyediakan tema Material Design dan navigasi
- Scaffold: Struktur dasar halaman dengan AppBar, body, dan floating action button
- AppBar: Bilah aplikasi di bagian atas dengan judul
- Padding: Menambahkan padding di sekitar widget child
- Column: Mengatur widget child secara vertikal
- Row: Mengatur widget child secara horizontal
- Card: Kontainer dengan elevasi dan sudut melengkung
- Text: Menampilkan teks dengan styling
- Icon: Menampilkan ikon dari Material Icons
- GridView.count: Menampilkan widget dalam grid dengan jumlah kolom tertentu
- Material: Memberikan efek material dengan warna dan border radius
- InkWell: Membuat area yang dapat diklik dengan efek ripple
- Container: Kontainer yang dapat dikustomisasi dengan padding, margin, dll.
- Center: Memusatkan widget child
- SizedBox: Memberikan jarak antar widget
- SnackBar: Menampilkan pesan sementara di bagian bawah layar

3. Fungsi Widget MaterialApp
MaterialApp adalah widget root yang sering digunakan karena menyediakan konfigurasi dasar aplikasi Material Design. Fungsi utamanya adalah:
- Mengatur tema aplikasi (warna, font, dll.)
- Mengelola routing dan navigasi
- Menyediakan lokalization
- Mengatur judul aplikasi
- Memberikan akses ke BuildContext global

4. Perbedaan StatelessWidget dan StatefulWidget
- StatelessWidget: Widget yang tidak memiliki state internal. UI-nya hanya bergantung pada konfigurasi yang diberikan saat konstruksi. Cocok untuk widget statis seperti ikon, teks, atau layout yang tidak berubah.
- StatefulWidget: Widget yang memiliki state internal yang dapat berubah selama lifetime widget. Memiliki objek State terpisah yang menyimpan data yang dapat berubah. Digunakan ketika UI perlu diperbarui berdasarkan interaksi user atau data yang berubah.

5. BuildContext
BuildContext adalah objek yang menyediakan informasi tentang lokasi widget dalam widget tree. Penting karena:
- Digunakan untuk mengakses tema, media query, dan ancestor widget
- Diperlukan untuk operasi seperti navigasi, menampilkan dialog, atau mengakses provider
- Dalam metode build, BuildContext digunakan untuk mendapatkan informasi tentang constraints layout dan konfigurasi tema

6. Hot Reload vs Hot Restart
- Hot Reload: Memuat ulang kode yang diubah tanpa kehilangan state aplikasi. Hanya memperbarui widget tree yang terpengaruh, sehingga aplikasi tetap berjalan dengan data yang sama. Lebih cepat dan cocok untuk perubahan UI.
- Hot Restart: Melakukan restart penuh aplikasi, menghapus semua state dan memuat ulang dari awal. Lebih lambat tapi memastikan semua perubahan diterapkan dengan benar, terutama untuk perubahan pada main() atau konfigurasi global.


Tirta Rendy Siahaan
2406355621
PBP C

JAWABAN README.md untuk TUGAS 2:

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() digunakan untuk menambahkan halaman baru ke stack navigasi, sehingga pengguna dapat kembali ke halaman sebelumnya dengan tombol back. Navigator.pushReplacement() menggantikan halaman saat ini dengan halaman baru tanpa menyimpannya di stack, sehingga tidak dapat kembali. Pada aplikasi Football Shop, saya menggunakan Navigator.push() untuk navigasi dari halaman utama ke halaman tambah produk karena pengguna mungkin ingin kembali. Navigator.pushReplacement() akan berguna jika ada skenario seperti setelah menyimpan produk berhasil, langsung kembali ke halaman utama tanpa bisa kembali ke form yang sudah tidak relevan.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Saya memanfaatkan Scaffold sebagai fondasi setiap halaman untuk struktur yang konsisten. AppBar ditempatkan di bagian atas untuk judul dan navigasi, sementara Drawer menyediakan menu samping. Pada halaman utama, Scaffold berisi AppBar dengan judul "Football Shop", body dengan Padding dan Column yang menampung InfoCard serta GridView untuk tombol-tombol, dan Drawer dengan ListTile untuk "Halaman Utama" dan "Tambah Produk". Pada halaman tambah produk, Scaffold memiliki AppBar dengan judul "Add New Product" dan body dengan Padding serta Form yang berisi ListView untuk elemen input. Hierarki ini menciptakan konsistensi visual dan memudahkan pemeliharaan kode.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Padding memberikan ruang yang tepat antar elemen untuk meningkatkan keterbacaan dan menghindari tampilan yang terlalu padat. SingleChildScrollView memungkinkan konten panjang di-scroll tanpa error overflow, ideal untuk layar kecil. ListView efisien untuk menampilkan daftar elemen yang dapat diperluas dengan performa optimal. Pada aplikasi Football Shop, Padding digunakan di body halaman utama (EdgeInsets.all(16.0)) dan form tambah produk untuk spacing konsisten. SingleChildScrollView membungkus Form pada halaman tambah produk agar dapat di-scroll jika konten melebihi layar. ListView digunakan dalam Form untuk menyusun TextFormField, DropdownButtonFormField, dan SwitchListTile secara vertikal.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Saya menyesuaikan tema melalui MaterialApp dengan ThemeData menggunakan ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blueAccent[400]), menciptakan nuansa biru yang konsisten. Tema ini diterapkan global pada AppBar (backgroundColor: Theme.of(context).colorScheme.primary), tombol-tombol (ElevatedButton), dan Drawer header (BoxDecoration(color: Colors.blue)). Pendekatan ini memastikan identitas visual koheren di seluruh aplikasi, dengan warna biru yang mencerminkan kesegaran dan kepercayaan, tanpa perlu pengaturan manual pada setiap widget.


Tirta Rendy Siahaan
2406355621
PBP C
