import 'package:flutter/material.dart';

class CatMemeScreen extends StatefulWidget {
  const CatMemeScreen({super.key});

  @override
  State<CatMemeScreen> createState() => _CatMemeScreenState();
}

class _CatMemeScreenState extends State<CatMemeScreen> {
  final TextEditingController _textController = TextEditingController();
  String memeText = "Hola Flutter";
  int _reloadKey = 0;

  void _generateMeme() {
    setState(() {
      memeText = _textController.text.isEmpty ? "Gato" : _textController.text;
      _reloadKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String cataasUrl =
        "https://cataas.com/cat/says/${Uri.encodeComponent(memeText)}?size=50&color=white&key=$_reloadKey";

    return Scaffold(
      appBar: AppBar(title: const Text('Generador de Memes de Gatos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Escribe tu frase para el gato',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _generateMeme,
              child: const Text('Crear / Cambiar Meme'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Image.network(
                  cataasUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Error al cargar la imagen'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
