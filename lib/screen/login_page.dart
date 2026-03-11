import 'package:flutter/material.dart';
import 'moviel_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Sesuai instruksi: Menggunakan 3 digit terakhir NIM (194) 
    if (username == "Benedictus" && password == "194") { 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Berhasil!")),
      );
      // Navigasi ke halaman list film setelah login sukses
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MovieListPage(username: username)),
      (route) => false, // Ini akan menghapus semua halaman sebelumnya
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Gagal: Password harus 3 digit NIM!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul halaman login [cite: 24]
            const Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text("Welcome back to Minilenst"), // 
            const SizedBox(height: 40),
            // Field untuk Username [cite: 9, 26]
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            // Field untuk Password dengan obscureText [cite: 9, 27]
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            // Tombol Login [cite: 28]
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                child: const Text("Login", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}