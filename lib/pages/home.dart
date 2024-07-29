import 'package:flutter/material.dart';
import '../screens/phone_number_prediction_page.dart';
import '../screens/house_prediction_page.dart';
import '../screens/vehicle_prediction_page.dart';
import '../screens/guarantee_prediction_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
            childAspectRatio: 1.2, // Aspect ratio of each child
          ),
          itemCount: 4, // Number of items in the grid
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  _onGridItemTap(context, index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getGridItemIcon(index),
                      size: 40,
                      color: Colors.amber[800],
                    ),
                    SizedBox(height: 10),
                    Text(
                      _getGridItemText(index),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onGridItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberPredictionPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HousePredictionPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclePredictionPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => GuaranteePredictionPage()));
        break;
    }
  }

  String _getGridItemText(int index) {
    switch (index) {
      case 0:
        return 'លេខទូរសព្ទ';
      case 1:
        return ' លេខផ្ទះ';
      case 2:
        return 'លេខយានយន្ដ';
      case 3:
        return 'លេខកុងធានាគា';
      default:
        return '';
    }
  }

  IconData _getGridItemIcon(int index) {
    switch (index) {
      case 0:
        return Icons.phone;
      case 1:
        return Icons.home;
      case 2:
        return Icons.directions_car;
      case 3:
        return Icons.card_giftcard;
      default:
        return Icons.help;
    }
  }
}
