/**
 * This code creates a stateless widget called AppProgressIndicator that displays a CircularProgressIndicator and text in a Container.
 * The text is passed in as a required argument.
 * The CircularProgressIndicator and text are both purple.
 * The Container is displayed over a white background with 70% opacity.
 */
import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(
                color: Color.fromARGB(255, 29, 29, 29),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 29, 29, 29),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
