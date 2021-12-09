import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Navigation/TopNavBar.dart';
import 'calculation.dart';
import 'currmodel.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
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
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(0),
              child: Calculation(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.blue,
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'CURRENCY CONVERTER',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff187bcd)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    setState(() {
                      Provider.of<CurrModel>(context, listen: false)
                          .clearItem();
                    });
                  },
                  label: Text("Delete"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CONVERSION',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('VALUE', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer<CurrModel>(
                builder: (context, cmod, child) {
                  return ListView(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: cmod.currList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: Key(cmod.currList[index].toString()),
                              onDismissed: (direction) {
                                setState(() {
                                  cmod.currList.removeAt(index);
                                });

                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("Item Removed")));
                              },
                              background: Container(color: Colors.red),
                              child: Column(
                                children: [
                                  ListTile(
                                      title: Text(
                                          cmod.currList[index].name.toString()),
                                      subtitle: Text(
                                          '${cmod.currList[index].name2.toString()} to ${cmod.currList[index].name.toString()}\nQuantity=${cmod.currList[index].quantity.toString()}'),
                                      trailing: Text(
                                        (cmod.currList[index].price *
                                                double.parse(
                                                    '${cmod.currList[index].quantity}'))
                                            .toStringAsFixed(2),
                                      )),
                                ],
                              ));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSettingsPanel(),
        label: const Text('Converter'),
        icon: const Icon(Icons.sync_outlined),
        backgroundColor: Color(0xff187bcd),
      ),
    );
  }
}
