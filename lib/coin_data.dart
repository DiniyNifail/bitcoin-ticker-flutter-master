import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String URL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {
//  final String url =
//      'BTCUSD';

//String chosenCurrency;
//
// void selectedCurrency(var selectedCurrency){
//   chosenCurrency = selectedCurrency;
// }

  Future getData(String chosenCurrency, String cryptoCurrency) async {
    http.Response response =
        await http.get(URL + '$cryptoCurrency$chosenCurrency');
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      var lastData = decodedData['last'];
      return lastData;
    } else {
      print(response.statusCode);
    }
  }
}
