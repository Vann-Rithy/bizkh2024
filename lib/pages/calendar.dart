import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  final List<DateTime> specialDays = [
    DateTime(2024, 7, 30),
    DateTime(2024, 8, 15),
  ];

  final List<DateTime> observanceDays = [
    DateTime(2024, 7, 29),
    DateTime(2024, 8, 5),
  ];

  final Map<String, List<Map<String, String>>> cambodiaHolidaysByMonth = {
    'មករា': [
      {'date': '1', 'event': 'ថ្ងៃថ្មីខ្មែរ'},
    ],
    'មេសា': [
      {'date': '14', 'event': 'ថ្ងៃសំរាប់គ្រួសារ'},
      {'date': '15', 'event': 'ថ្ងៃជាតិ'},
    ],
    'ធ្នូ': [
      {'date': '15', 'event': 'ថ្ងៃបុណ្យភ្ជុំបិណ្ឌ'},
    ],
    // Add more holidays by month
  };

  List<DateTime> _generateCalendarDates() {
    List<DateTime> calendarDates = [];
    DateTime firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    int firstWeekdayOfMonth = firstDayOfMonth.weekday;
    int daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    for (int i = 0; i < firstWeekdayOfMonth - 1; i++) {
      calendarDates.add(firstDayOfMonth.subtract(Duration(days: firstWeekdayOfMonth - 1 - i)));
    }

    for (int i = 0; i < daysInMonth; i++) {
      calendarDates.add(DateTime(_currentDate.year, _currentDate.month, i + 1));
    }

    int trailingDays = 42 - calendarDates.length;
    for (int i = 0; i < trailingDays; i++) {
      calendarDates.add(DateTime(_currentDate.year, _currentDate.month + 1, i + 1));
    }

    return calendarDates;
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + delta, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMM yyyy', 'km').format(_currentDate);
    final List<DateTime> calendarDates = _generateCalendarDates();
    final String month = DateFormat('MMMM', 'km').format(_currentDate);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.teal),
                  onPressed: () => _changeMonth(-1),
                ),
                Column(
                  children: [
                    Text(
                      'ប្រតិទិនខ្មែរ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dayLabel('ចន្ទ', Colors.blue),
                _dayLabel('អង្គារ', Colors.blue),
                _dayLabel('ពុធ', Colors.blue),
                _dayLabel('ព្រហស្បតិ៍', Colors.blue),
                _dayLabel('សុក្រ', Colors.blue),
                _dayLabel('សៅរ៍', Colors.blue),
                _dayLabel('អាទិត្យ', Colors.red),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: calendarDates.length,
              itemBuilder: (context, index) {
                DateTime date = calendarDates[index];
                bool isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;
                bool isSpecialDay = specialDays.contains(date);
                bool isObservanceDay = observanceDays.contains(date);
                bool isSunday = date.weekday == DateTime.sunday;
                bool isSelected = date == _selectedDate;

                Color backgroundColor = Colors.transparent;
                if (isSunday) {
                  backgroundColor = Colors.redAccent;
                } else if (isSpecialDay) {
                  backgroundColor = Colors.orangeAccent;
                } else if (isObservanceDay) {
                  backgroundColor = Colors.blueAccent;
                } else if (isToday) {
                  backgroundColor = Colors.teal;
                } else if (isSelected) {
                  backgroundColor = Colors.lightGreen;
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black87, width: 0.2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: isSunday || isSpecialDay || isObservanceDay || isToday || isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '១០ រោច',
                            style: TextStyle(
                              color: isSunday || isSpecialDay || isObservanceDay || isToday || isSelected ? Colors.white : Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ថ្ងៃឈប់សម្រាកក្នុងខែនេះ:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cambodiaHolidaysByMonth[month]?.map((holiday) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        leading: Icon(Icons.event, color: Colors.orangeAccent, size: 20),
                        title: Text(
                          '${holiday['date']} - ${holiday['event']}',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      );
                    })?.toList() ?? [Text('គ្មានថ្ងៃឈប់សម្រាកសម្រាប់ខែនេះ')],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _dayLabel(String day, Color color) {
    return Expanded(
      child: Center(
        child: Text(
          day,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
