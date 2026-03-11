import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Details")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie.imgUrl, width: double.infinity, height: 400, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${movie.title} (${movie.year})", 
                       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Directed by ${movie.director}", 
                       style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 15),
                  Text(movie.synopsis, textAlign: TextAlign.justify),
                  const SizedBox(height: 15),
                  Text("Genre: ${movie.genre}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Casts: ${movie.casts.join(', ')}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      Text(" Rated ${movie.rating}/10", style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // BAGIAN YANG DIPERBAIKI
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(movie.movieUrl);
                        // Cek apakah URL bisa dibuka
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Could not launch Wikipedia for ${movie.title}")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      child: const Text("Go to Wikipedia", style: TextStyle(color: Colors.black)),
                    ),
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