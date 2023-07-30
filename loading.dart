/**
 * This code creates a loading page with a purple and blue gradient background, an icon, and a text that says "Loading...please wait...".
 * The initState() method calls the initializeApp() method from the InitApp class.
 */
import 'package:flutter/material.dart';
import 'package:reflections_app/init.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    InitApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 209, 209, 209),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note_alt,
                size: 100,
                color: Color.fromARGB(255, 29, 29, 29),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Loading...please wait...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 29, 29, 29), fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
