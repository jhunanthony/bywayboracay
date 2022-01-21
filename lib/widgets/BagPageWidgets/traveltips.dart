import 'package:flutter/material.dart';

import '../Navigation/TopNavBar.dart';

class TravelTips extends StatefulWidget {
  @override
  State<TravelTips> createState() => _TravelTipsState();
}

class _TravelTipsState extends State<TravelTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        colorbackground: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Fimages1.jpg?alt=media&token=ad938518-5f3c-43cd-8ad6-cd6b4fcee14b'),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 75.0),
                              child: Row(
                                children: [
                                  Icon(Icons.checklist_rounded),
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'TRAVEL TIPS',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Dining by the beach is prohibited.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'The annual LaBoracay Party on \n May 1st has  been banned..',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Souvenir shops and hawkers along \n  beachfront have been banned.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Fire dancing that uses kerosene \n lamps has been prohibited.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Casinos have been banned on the \n island.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Hot-coal roasting of meat is \n prohibited.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Tourists are required to present the \n hotel  reservation voucher before \n entering  the island',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'Fireworks displays will be allowed \n until 9:00pm.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.close_rounded,
                                            size: 40.0, color: Colors.red),
                                        Text(
                                            'No smoking and drinking alcoholic \n beverages along  the White beach.',
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2Fimages2.jpg?alt=media&token=a824b906-c5f2-4459-98d3-3779072d3762'),
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      'Disclaimer: This app contains photos that Byway Boracay\n do not own.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          shadows: <Shadow>[
                            Shadow(blurRadius: 3.0, color: Colors.grey[900]),
                          ],
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
