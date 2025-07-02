import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard(
    this.onTitle,
    this.onLabel,
    this.onPrimary,
    this.onSecondary, {
    super.key,
    required Column child,
  });

  final Color onPrimary;
  final Color onSecondary;
  final String onTitle;
  final String onLabel;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [onPrimary, onSecondary.withAlpha(70)],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,

        ),
      ),
      height: 180,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              onTitle,
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.pink.shade300,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                onLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '08/05/2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15, child: VerticalDivider()),
                Text(
                  'Análise',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Visualizar', style: TextStyle(color: Colors.pink)),
              icon: Icon(Icons.verified, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}
