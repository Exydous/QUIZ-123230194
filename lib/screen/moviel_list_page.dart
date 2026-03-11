import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'movie_detail_page.dart';
import 'login_page.dart'; // Import halaman login untuk logout

class MovieListPage extends StatelessWidget {
  final String username;
  const MovieListPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menampilkan pesan selamat datang [cite: 29]
        title: Text("Welcome, $username!"),
        actions: [
          // TOMBOL LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // SESSION DESTROY: Kembali ke Login dan hapus semua riwayat navigasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false, // Menghapus tumpukan halaman agar tidak bisa 'back'
              );
            },
          ),
        ],
      ),
      
      // Implementasi ListView untuk menampilkan daftar film [cite: 12, 13]
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return InkWell(
            // Navigasi ke halaman detail film saat diklik [cite: 14]
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetailPage(movie: movie)),
            ),
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Menampilkan gambar poster film [cite: 13]
                    Image.network(movie.imgUrl, width: 80, height: 120, fit: BoxFit.cover),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul dan tahun rilis film [cite: 13]
                          Text("${movie.title} (${movie.year})", 
                               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          // Genre film [cite: 13]
                          Text(movie.genre),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 16),
                              // Rating film [cite: 13]
                              Text(" ${movie.rating}/10"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Tombol 'Add to List' sesuai instruksi [cite: 19, 20]
                    const AddToListButton(), 
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Widget Stateful untuk mengelola perubahan warna tombol 'Add to List' [cite: 19]
class AddToListButton extends StatefulWidget {
  const AddToListButton({super.key});

  @override
  State<AddToListButton> createState() => _AddToListButtonState();
}

class _AddToListButtonState extends State<AddToListButton> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => setState(() => isAdded = !isAdded),
      style: OutlinedButton.styleFrom(
        // Default: putih, Jika diklik: biru 
        backgroundColor: isAdded ? Colors.blue : Colors.white,
        // Default: outline abu, Jika diklik: outline biru 
        side: BorderSide(color: isAdded ? Colors.blue : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(8),
      ),
      child: Icon(
        isAdded ? Icons.bookmark : Icons.bookmark_border,
        color: isAdded ? Colors.white : Colors.black, // Ikon berubah putih saat latar biru
      ),
    );
  }
}