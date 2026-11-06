import 'package:flutter/material.dart';
import 'screens/movie_screen.dart';
import 'screens/cat_meme_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/crypto_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Los 4 Retos Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Los 4 Retos en Flutter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildChallengeCard(
              context,
              title: 'Reto 1: Recomendador de Películas',
              subtitle: 'API de TMDB / Consumo HTTP y Lista',
              icon: Icons.movie,
              color: Colors.indigo,
              screen: const MovieScreen(),
            ),
            const SizedBox(height: 12),
            _buildChallengeCard(
              context,
              title: 'Reto 2: Generador de Memes de Gatos',
              subtitle: 'API Cataas / Manejo de Estados y URLs Dinámicas',
              icon: Icons.pets,
              color: Colors.orange,
              screen: const CatMemeScreen(),
            ),
            const SizedBox(height: 12),
            _buildChallengeCard(
              context,
              title: 'Reto 3: App del Clima Minimalista',
              subtitle: 'API OpenWeatherMap / Estados de Carga',
              icon: Icons.wb_sunny,
              color: Colors.blue,
              screen: const WeatherScreen(),
            ),
            const SizedBox(height: 12),
            _buildChallengeCard(
              context,
              title: 'Reto 4: Convertidor de Criptomonedas',
              subtitle: 'API CoinGecko / Operaciones Matemáticas y FutureBuilder',
              icon: Icons.currency_bitcoin,
              color: Colors.green,
              screen: const CryptoScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
