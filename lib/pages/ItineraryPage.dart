import 'package:bywayborcay/widgets/Navigation/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ItineraryPage extends StatefulWidget {

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
 /* CalendarController _controller;

  @override
  void initState() {
    
    super.initState();
    _controller = CalendarController();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 21),
                    focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                calendarStyle: CalendarStyle(
                  
                  todayDecoration: BoxDecoration(
                    color: Colors.blue[50]
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.blue
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.yellow[50]
                  ),
                   selectedTextStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                ),
               
                
              )
            ],)
        ),
        
      
      ]),
      //bottomNavigationBar: BottomNavBar(),
      );
  }
}