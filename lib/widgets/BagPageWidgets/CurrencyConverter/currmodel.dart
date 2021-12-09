import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class CurrModel extends ChangeNotifier {
  List<Curr> currList = [];
  List<String> cName, cPrice;

  fetchItem(String from, String to, String quantity) async {
    //final apicur = 'http://api.exchangeratesapi.io/v1/latest?access_key=cf837c3c1c5fde9327c635e8af36f3ff&format=1';
    final apicur =
        'https://freecurrencyapi.net/api/v2/latest?apikey=cbb32200-42f2-11ec-9eb0-ad8a18a9f0ae';
    //final response = await http.get(Uri.parse(apicur));
    http.Response response = await http.get(Uri.parse(apicur));
    var data = json.decode(response.body);
    Map<String, dynamic> curr = data["data"];
    curr.forEach((key, value) {
      if (to == key.toString() &&
          !currList.contains(Curr(key, from.toString(), value, quantity))) {
        currList.add(Curr(key, from.toString(), value, quantity));
      }
    });
    notifyListeners();
  }

  clearItem() {
    currList = [];
  }
}

class Curr {
  String name;
  String name2;
  dynamic price;
  String quantity;
  Curr(this.name, this.name2, this.price, this.quantity);
}


