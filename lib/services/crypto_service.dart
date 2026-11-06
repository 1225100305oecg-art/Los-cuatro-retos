import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  Future<Map<String, dynamic>> fetchPrices() async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los precios de criptomonedas');
    }
  }
}
