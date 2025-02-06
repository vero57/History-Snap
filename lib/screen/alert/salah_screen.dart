import 'package:flutter/material.dart';
import 'package:history_snap/screen/homescreen.dart';
import 'package:history_snap/screen/gameplay.dart';

class SalahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15141F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WAHH KAMU MASIH BELUM BERHASIL',
              style: TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold, fontFamily: 'Larken DEMO'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Kamu belum menebak semua tebakan',
              style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Larken DEMO'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 66, 53, 167).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 100, // Set the width here
                    height: 100, // Set the height here
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 66, 53, 167),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.home, size: 50, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 66, 53, 167).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 100, // Set the width here
                    height: 100, // Set the height here
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameplayScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 66, 53, 167),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.restart_alt, size: 50, color: Colors.white),
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