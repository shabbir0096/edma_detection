import 'package:edemadetection/screens/detail_screen.dart/aboutUs.dart';
import 'package:edemadetection/screens/detail_screen.dart/doctors.dart';
import 'package:edemadetection/screens/detail_screen.dart/edema.dart';
import 'package:edemadetection/screens/detail_screen.dart/feedback.dart';
import 'package:edemadetection/screens/detail_screen.dart/result.dart';
import 'package:edemadetection/screens/detail_screen.dart/upload_image.dart';
import 'package:edemadetection/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String userName = "Guest"; // Default value if user is not logged in

  @override
  void initState() {
    super.initState();
    // Check if the user is logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in, update the displayed name
        setState(() {
          userName = user.displayName ?? "Guest";
        });
      } else {
        // User is signed out, reset the displayed name
        setState(() {
          userName = "Guest";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff392850),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 110,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello $userName",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Color(0xffa29aac),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                   Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context)=> const LoginView()
                    )
                    );
                    }
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;

  Items({
    required this.title,
    required this.subtitle,
    required this.img,
  });
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Upload Image",
    subtitle: "X-ray/MRI",
    img: "assets/Images/uploadImage.png",
  );

  Items item2 = Items(
    title: "Detection Results",
    subtitle: "results of the edema detection",
    img: "assets/Images/detection.png",
  );
  Items item3 = Items(
    title: "Doctors Consultation",
    subtitle: "Book your appointment",
    img: "assets/Images/DrConsult.jpg",
  );
  Items item4 = Items(
    title: "About Edema",
    subtitle: "causes, symptoms, and potential treatments.",
    img: "assets/Images/description.png",
  );
  Items item5 = Items(
    title: "Feedbacks/Reviews",
    subtitle: "users to give feedback, report issues,",
    img: "assets/Images/feedback.png",
  );
  Items item6 = Items(
    title: "About Us",
    subtitle: " information about our app",
    img: "assets/Images/aboutUs.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 0.9,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: myList.map((data) {
          return GestureDetector(
            onTap: () {
              _navigateToScreen(context, data);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(color),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
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
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Items data) {
    final Map<Items, Widget> screenMap = {
      item1: Screen1(data),
      item2: Screen2(data),
      item3: Screen3(data),
      item4: Screen4(data),
      item5: Screen5(data),
      item6: Screen6(data),
    };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenMap[data]!),
    );
  }
}






// Add more screens for other items
