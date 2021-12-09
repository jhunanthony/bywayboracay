import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'currmodel.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  List<String> currencyName = [
    'CAD',
    'HKD',
    'ISK',
    'PHP',
    'DKK',
    'HUF',
    'CZK',
    'GBP',
    'RON',
    'SEK',
    'IDR',
    'INR',
    'BRL',
    'RUB',
    'HRK',
    'JPY',
    'THB',
    'CHF',
    'EUR',
    'MYR',
    'BGN',
    'TRY',
    'CNY',
    'NOK',
    'NZD',
    'ZAR',
    'USD',
    'MXN',
    'SGD',
    'AUD',
    'ILS',
    'KRW',
    'PLN',
  ];
  String from, to, quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width * 1.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      iconEnabledColor: Colors.white,
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      dropdownColor: Color(0xff187bcd),
                      hint: Text(
                        from == null ? 'FROM' : from,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      value: from,
                      items: currencyName.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          from = value;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      iconEnabledColor: Colors.white,
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      dropdownColor: Color(0xff187bcd),
                      hint: Text(
                        to == null ? 'TO' : to,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      value: to,
                      items: currencyName.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          to = value;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Quantity',
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 18.0)),
                  onChanged: (val) => setState(() => quantity = val),
                ),
                // ignore: deprecated_member_use

                ElevatedButton.icon(
                  icon: Icon(Icons.sync_outlined),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff187bcd)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    Provider.of<CurrModel>(context, listen: false).fetchItem(
                        from.toString(), to.toString(), quantity.toString());

                    Navigator.pop(context);
                  },
                  label: Text(
                    "Convert",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OxffB3CDE0 {}
