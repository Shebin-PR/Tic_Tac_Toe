import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> boxElements = ['', '', '', '', '', '', '', '', ''];
  bool playerO = true;
  int pointOfO = 0;
  int pointOfX = 0;
  int selectedbox = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff000428),
                Color(0xff004e92),
                Color(0xff000428),
                Color(0xff004e92),
                Color(0xff000428),
                Color(0xff004e92),
                Color(0xff000428),
                Color(0xff004e92),
                // Color(0xffE684AE),
              ],
            ),
          ),
          child: Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Tic Tac Toe",
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: Offset(0, -10),
                        )
                      ],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      decorationThickness: 3,
                      fontSize: 25,
                      letterSpacing: .7,
                      fontWeight: FontWeight.bold,
                      color: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Player O',
                              style: GoogleFonts.handlee(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade200,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              pointOfO.toString(),
                              style: GoogleFonts.handlee(
                                fontSize: 25,
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Player X',
                              style: GoogleFonts.handlee(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade200,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              pointOfX.toString(),
                              style: GoogleFonts.handlee(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                    indent: 9,
                    endIndent: 9,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            boxPressed(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade900,
                                    offset: const Offset(4.0, 4.0),
                                    blurRadius: 8.0,
                                    spreadRadius: 1.0,
                                  ),
                                  BoxShadow(
                                    color: Colors.blue.shade900,
                                    offset: const Offset(-4.0, -4.0),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  boxElements[index],
                                  style: GoogleFonts.permanentMarker(
                                    color: Colors.red.shade900,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent.shade100,
          onPressed: () {
            clearAll();
          },
          label: Row(
            children: const [
              Icon(
                Icons.clear_all_rounded,
                color: Colors.black,
                size: 30,
              ),
              Text(
                " Clear All",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void boxPressed(int index) {
    setState(() {
      if (playerO && boxElements[index] == '') {
        boxElements[index] = 'O';
        selectedbox++;
      } else if (!playerO && boxElements[index] == '') {
        boxElements[index] = 'X';
        selectedbox++;
      }

      playerO = !playerO;
      checkBoxes();
    });
  }

  void showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' $winner  won the round'),
          actions: [
            TextButton(
              child: const Text("Continue playing"),
              onPressed: () {
                clearBox();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );

    if (winner == 'O') {
      pointOfO++;
    } else if (winner == 'X') {
      pointOfX++;
    }
  }

  void checkBoxes() {
   
    if (boxElements[0] == boxElements[1] &&
        boxElements[0] == boxElements[2] &&
        boxElements[0] != '') {
      showWinDialog(boxElements[0]);
    }
    if (boxElements[3] == boxElements[4] &&
        boxElements[3] == boxElements[5] &&
        boxElements[3] != '') {
      showWinDialog(boxElements[3]);
    }
    if (boxElements[6] == boxElements[7] &&
        boxElements[6] == boxElements[8] &&
        boxElements[6] != '') {
      showWinDialog(boxElements[6]);
    }


    if (boxElements[0] == boxElements[3] &&
        boxElements[0] == boxElements[6] &&
        boxElements[0] != '') {
      showWinDialog(boxElements[0]);
    }
    if (boxElements[1] == boxElements[4] &&
        boxElements[1] == boxElements[7] &&
        boxElements[1] != '') {
      showWinDialog(boxElements[1]);
    }
    if (boxElements[2] == boxElements[5] &&
        boxElements[2] == boxElements[8] &&
        boxElements[2] != '') {
      showWinDialog(boxElements[2]);
    }

 
    if (boxElements[0] == boxElements[4] &&
        boxElements[0] == boxElements[8] &&
        boxElements[0] != '') {
      showWinDialog(boxElements[0]);
    }
    if (boxElements[2] == boxElements[4] &&
        boxElements[2] == boxElements[6] &&
        boxElements[2] != '') {
      showWinDialog(boxElements[2]);
    } else if (selectedbox == 9) {
      showBoxDialog();
    }
  }

  void showBoxDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Draw match"),
          actions: [
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {
                clearBox();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void clearBox() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        boxElements[i] = '';
      }
    });

    selectedbox = 0;
  }

  void clearAll() {
    setState(() {
      pointOfX = 0;
      pointOfO = 0;
      for (int i = 0; i < 9; i++) {
        boxElements[i] = '';
      }
    });
    selectedbox = 0;
  }
}
