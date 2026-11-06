import 'package:flutter/material.dart';
import '../services/crypto_service.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final CryptoService _cryptoService = CryptoService();
  final TextEditingController _usdController = TextEditingController(text: '100');
  
  late Future<Map<String, dynamic>> _futurePrices;
  double usdAmount = 100.0;

  @override
  void initState() {
    super.initState();
    _futurePrices = _cryptoService.fetchPrices();
  }

  void _calculate() {
    setState(() {
      usdAmount = double.tryParse(_usdController.text) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convertidor de Criptomonedas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto en USD (\$)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _calculate(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _futurePrices,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Text('Sin datos');
                  }

                  final prices = snapshot.data!;
                  final btcPrice = prices['bitcoin']['usd'] * 1.0;
                  final ethPrice = prices['ethereum']['usd'] * 1.0;
                  final solPrice = prices['solana']['usd'] * 1.0;

                  return ListView(
                    children: [
                      _cryptoTile('Bitcoin (BTC)', btcPrice, usdAmount),
                      _cryptoTile('Ethereum (ETH)', ethPrice, usdAmount),
                      _cryptoTile('Solana (SOL)', solPrice, usdAmount),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cryptoTile(String name, double price, double usd) {
    final amount = price > 0 ? (usd / price).toStringAsFixed(6) : '0';
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Precio unitario: \$$price USD'),
        trailing: Text(
          '$amount\nFracción',
          textAlign: TextAlign.right,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
