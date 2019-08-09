import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var btclastData;
  var ETHlastData;
  var LTClastData;
  String lastDataToString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLastData();
  }

  void getLastData() async {
    CoinData coinData = CoinData();
    btclastData = await coinData.getData(selectedCurrency, 'BTC');
    LTClastData = await coinData.getData(selectedCurrency, 'LTC');
    ETHlastData = await coinData.getData(selectedCurrency, 'ETH');
//    UpdateUI();
    setState(() {});

    print(btclastData);
  }

  void UpdateUI() {
    setState(() {
//      lastData = lastData;
//      lastDataToString = lastData.toString();
    });
  }

  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(selectedCurrency);
          getLastData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                CryptoCard(
                  lastData: btclastData,
                  selectedCurrency: selectedCurrency,
                  cryptoType: 'BTC',
                ),
                SizedBox(height: 10.0),
                CryptoCard(
                  lastData: ETHlastData,
                  selectedCurrency: selectedCurrency,
                  cryptoType: 'ETH',
                ),
                SizedBox(height: 10.0),
                CryptoCard(
                  lastData: LTClastData,
                  selectedCurrency: selectedCurrency,
                  cryptoType: 'LTC',
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.lastData,
    @required this.selectedCurrency,
    @required this.cryptoType,
  }) : super(key: key);

  final lastData;
  final cryptoType;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoType = $lastData $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
