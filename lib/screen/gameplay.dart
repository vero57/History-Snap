import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:history_snap/models/data.dart';
import 'package:history_snap/screen/alert/salah_screen.dart';
import 'package:history_snap/screen/homescreen.dart';
import 'alert/benar_screen.dart';

class GameplayScreen extends StatefulWidget {
  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  int remainingTime = 5;
  late Timer _timer;
  List<bool> revealStates = [];
  late Map<String, String> currentQuestion;
  bool isGuessingTime = false;
  List<Map<String, String>> usedQuestions = [];
  int incorrectGuesses = 0; // Add this line

  @override
  void initState() {
    super.initState();
    _startMemorizationPhase();

    // Untuk mengacak gambar pahlawan
    figures.shuffle();

    // Untuk mengambil soal pertama
    currentQuestion = _getNewQuestion();

    revealStates = List<bool>.filled(figures.length, false);
  }

  Map<String, String> _getNewQuestion() {
    final unusedQuestions = figures.where((question) => !usedQuestions.contains(question)).toList();

    if (unusedQuestions.isEmpty) {
      usedQuestions.clear(); // Mereset jika semua soal sudah digunakan
      return _getNewQuestion();
    }

    final newQuestion = unusedQuestions[Random().nextInt(unusedQuestions.length)];
    usedQuestions.add(newQuestion);
    return newQuestion;
  }

  void _startMemorizationPhase() {
    setState(() {
      isGuessingTime = false;
      remainingTime = 30;
    });
    _startTimer(() {
      _startGuessingPhase();
    });
  }

  void _startGuessingPhase() {
    setState(() {
      isGuessingTime = true;
      remainingTime = 10;
    });
    _startTimer(() {
      // Ketika waktu habis, cek jawaban
      if (!revealStates.every((revealed) => revealed)) {
        _showAlert("Salah", "Waktu habis! Anda belum menjawab semua gambar.");
      }
    });
  }

  void _startTimer(VoidCallback onComplete) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _timer.cancel();
          onComplete();
        }
      });
    });
  }

  void _handleGuess(int index) {
    if (!isGuessingTime || revealStates[index]) return;

    setState(() {
      if (figures[index]['soal'] == currentQuestion['soal']) {
        revealStates[index] = true;
        currentQuestion = _getNewQuestion();
      } else {
        revealStates[index] = true;
        incorrectGuesses++; // Increment incorrect guesses
        if (incorrectGuesses >= 5) { // Check if incorrect guesses reach 5
          _timer.cancel(); // Stop the timer
          _showAlert("Salah", "Anda telah salah menebak 5 kali.");
          return;
        }
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            revealStates[index] = false;
          });
        });
      }

      // Cek apakah semua kotak telah terjawab
      if (revealStates.every((revealed) => revealed)) {
        _timer.cancel(); // Hentikan timer jika masih berjalan
        _showAlert("Benar", "Selamat, Anda telah menjawab semua gambar dengan benar!");
      }
    });
  }

  void _showAlert(String title, String message) {
    if (title == "Benar") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BenarScreen()));
    } else if (title == "Salah") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalahScreen()));
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 20, 31),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 20, 31),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('asset/Subtract.png'),
          onPressed: () {
            Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
          },
        ),
        title: Text(
          isGuessingTime ? 'Waktunya Menebak' : 'Hafalkan!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: "Larken DEMO",
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Center(
              child: Container(
                width: 152,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 66, 53, 167),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(remainingTime ~/ 60).toString().padLeft(1, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "Larken DEMO",
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 0,
                ),
                itemCount: figures.length,
                itemBuilder: (context, index) {
                  bool isCorrect = revealStates[index] && figures[index]['soal'] == currentQuestion['soal'];
                  bool isIncorrect = revealStates[index] && figures[index]['soal'] != currentQuestion['soal'];
                  bool isAlreadyCorrect = revealStates[index] && usedQuestions.any((question) => question['name'] == figures[index]['name']);

                  return GestureDetector(
                    onTap: () => _handleGuess(index),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              if (isCorrect || isAlreadyCorrect)
                                BoxShadow(
                                  color: Colors.blue.withOpacity(1),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                ),
                              if (isIncorrect)
                                BoxShadow(
                                  color: const Color.fromARGB(178, 244, 67, 54).withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              figures[index]['image']!,
                              height: 183,
                              width: 152,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (!isGuessingTime && !revealStates[index])
                          Positioned(
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Text(
                                figures[index]['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Larken DEMO'
                                ),
                              ),
                            ),
                          ),
                        if (isGuessingTime && !revealStates[index])
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'asset/image/penutup.png',
                              height: 183,
                              width: 152,
                              fit: BoxFit.cover,
                            ),
                          ), if (revealStates[index] && isGuessingTime && usedQuestions.any((question) => question['name'] == figures[index]['name']))
                          Positioned( 
                            bottom: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Text(
                                figures[index]['name']!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Larken DEMO'
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          if (isGuessingTime)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 66, 53, 167),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  currentQuestion['soal']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Larken DEMO",
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}