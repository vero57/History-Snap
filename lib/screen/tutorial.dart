import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 20, 31),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 20, 31),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('asset/Subtract.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CARA BERMAIN',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: 'Larken DEMO'
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 1000,
              height: 500,
              decoration: BoxDecoration(
                color: Color(0xFF4335A7),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 66, 53, 167).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Text(
                    '1. Kamu akan diberikan waktu selama 1 Menit untuk menghafal posisi dan nama dari tokoh-tokoh yang ada',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Larken DEMO'
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '2. Setelah waktu menghafal habis, kamu akan diberikan soal dan kamu harus menjawab soal tersebut dengan apa yang tokoh tersebut lakukan. Misalkan soal adalah bapak proklamator, maka jawabannya adalah Soekarno',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Larken DEMO'
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '3. Kamu diberikan kesempatan salah sebanyak 5 kali, jika kamu salah sebanyak 5 kali maka kamu akan kalah',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Larken DEMO'
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '4. Jika berhasil menjawab semua, dan semua gambar terbuka. Maka kamu akan mendapatkan kemenangan',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Larken DEMO'
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}