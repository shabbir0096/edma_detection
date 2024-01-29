import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bottom_nav_check_edema.dart';

class CheckEdema extends StatefulWidget {
  const CheckEdema({super.key});

  @override
  State<CheckEdema> createState() => _CheckEdemaState();
}

class _CheckEdemaState extends State<CheckEdema> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: const Text('Check Edema'),
    ),body: Center(child: SizedBox(height: 200 , child: GridDashboard())));
  }
}

class Items {
  String title;

  Items({
    required this.title,
  });
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "X-Ray Edema",
  );

  Items item2 = Items(
    title: "MRI Edema",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];
    return GridView.count(
      childAspectRatio: 0.9,
      padding: const EdgeInsets.only(left: 16, right: 16 ),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(myList.length, (index) {
        Items data = myList[index];
        final LinearGradient gradient = _getGradient(index);

        return GestureDetector(
          onTap: () {
            _navigateToScreen(context, data);
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    data.title,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _navigateToScreen(BuildContext context, Items data) {
    final Map<Items, Widget> screenMap = {
      item1: const BottomNavigationBarExample(),
      //item2: Screen2(data),
    };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenMap[data]!),
    );
  }
}

LinearGradient _getGradient(int index) {
  // Define your list of gradients
  final List<LinearGradient> gradients = [
    const LinearGradient(
      colors: [Colors.lightBlueAccent, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.purpleAccent, Colors.deepPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  // Use modulo to repeat gradients if there are more containers than gradients
  return gradients[index % gradients.length];
}

class Data {
  final String img;
  final String title;
  final String subtitle;

  Data({required this.img, required this.title, required this.subtitle});
}
