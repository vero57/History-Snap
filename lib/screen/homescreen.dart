import 'package:flutter/material.dart';
import 'package:history_snap/screen/gameplay.dart';
import 'package:history_snap/screen/tutorial.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 20, 31),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'asset/icon.png',
              width: 500, // Sesuaikan ukuran gambar sesuai keinginan Anda
              height: 300,
            ),
            // SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 66, 53, 167).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 0), // perubahan posisi shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GameplayScreen()),
                      );
                    },
                    child: Icon(Icons.play_arrow, size: 100),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 66, 53, 167),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 66, 53, 167).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 0), // perubahan posisi shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorialPage()),
                      );
                      
                    },
                    child: Icon(Icons.help_outline, size: 100),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 66, 53, 167),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
