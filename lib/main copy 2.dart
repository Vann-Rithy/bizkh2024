// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeDateFormatting('km_KH', null); // Initialize Khmer locale
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: TextTheme(
//           bodyLarge: TextStyle(color: Colors.black87), // Updated text style
//           bodyMedium: TextStyle(color: Colors.black54), // Updated text style
//         ),
//       ),
//       home: CalendarPage(),
//     );
//   }
// }

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   int _selectedMonth = DateTime.now().month;

//   final List<Holiday> _holidays = [
//     Holiday(date: DateTime(2024, 1, 1), name: "ទិវាចូលឆ្នាំសាកល (New Year's Day)"),
//     Holiday(date: DateTime(2024, 2, 14), name: "ទិវានៃក្តីស្រលាញ់ (Valentine's Day)"),
//     // Add more holidays here
//     Holiday(date: DateTime(2024, 7, 4), name: "Independence Day (July 4)"), // Example for July
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('បុណ្យជាតិប្រចាំខែ'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         elevation: 4.0,
//       ),
//       body: Column(
//         children: [
//           _buildCalendar(),
//           SizedBox(height: 10),
//           _buildHolidayList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildCalendar() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 4,
//             blurRadius: 12,
//             offset: Offset(0, 6), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TableCalendar(
//         locale: 'km_KH',
//         firstDay: DateTime.utc(2020, 1, 1),
//         lastDay: DateTime.utc(2030, 12, 31),
//         focusedDay: _focusedDay,
//         calendarFormat: CalendarFormat.month,
//         selectedDayPredicate: (day) {
//           return isSameDay(_selectedDay, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//             _selectedMonth = selectedDay.month; // Update the selected month
//           });
//         },
//         onPageChanged: (focusedDay) {
//           setState(() {
//             _focusedDay = focusedDay;
//             _selectedMonth = focusedDay.month; // Update the selected month
//           });
//         },
//         holidayPredicate: (day) {
//           return _holidays.any((holiday) => isSameDay(holiday.date, day));
//         },
//         headerStyle: HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: true,
//           titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
//           leftChevronIcon: Icon(Icons.chevron_left, size: 30, color: Colors.blueAccent),
//           rightChevronIcon: Icon(Icons.chevron_right, size: 30, color: Colors.blueAccent),
//         ),
//         calendarStyle: CalendarStyle(
//           isTodayHighlighted: true,
//           selectedDecoration: BoxDecoration(
//             color: Colors.blueAccent,
//             borderRadius: BorderRadius.circular(8), // Square corners
//           ),
//           todayDecoration: BoxDecoration(
//             color: Colors.orangeAccent,
//             borderRadius: BorderRadius.circular(8), // Square corners
//           ),
//           holidayDecoration: BoxDecoration(
//             color: Colors.redAccent,
//             borderRadius: BorderRadius.circular(8), // Square corners
//           ),
//           outsideDaysVisible: false,
//           defaultDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8), // Square corners
//           ),
//           defaultTextStyle: TextStyle(color: Colors.black87),
//         ),
//         calendarBuilders: CalendarBuilders(
//           defaultBuilder: (context, day, focusedDay) {
//             final dayText = DateFormat('d', 'km_KH').format(day);
//             final isSpecialDay = day.day == 10; // Example condition for custom text

//             return Center(
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             dayText,
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16, // Improved font size
//                             ),
//                           ),
//                           if (isSpecialDay)
//                             Text(
//                               '១០ រោច',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (isSpecialDay) // Example condition for adding icon
//                     Positioned(
//                       right: 0,
//                       bottom: 0,
//                       child: Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                         size: 18,
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//         daysOfWeekStyle: DaysOfWeekStyle(
//           weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           weekendStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   Widget _buildHolidayList() {
//     final monthHolidays = _holidays.where((holiday) => holiday.date.month == _selectedMonth).toList();

//     return Expanded(
//       child: ListView.builder(
//         itemCount: monthHolidays.length,
//         itemBuilder: (context, index) {
//           final holiday = monthHolidays[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
//             child: Card(
//               elevation: 6.0, // Enhanced elevation
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.all(16),
//                 title: Text(
//                   DateFormat('dd-MM-yyyy').format(holiday.date) + ' ' + holiday.name,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 leading: Icon(Icons.celebration, color: Colors.redAccent, size: 30),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class Holiday {
//   final DateTime date;
//   final String name;

//   Holiday({required this.date, required this.name});
// }
