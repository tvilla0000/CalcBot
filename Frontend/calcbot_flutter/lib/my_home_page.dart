import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'vector_operations_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcbot'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome To CalcBot!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'CalcBot Helps You With Various Calculus Operations! Choose A Category To Get Started.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            Center(
              child: Lottie.asset(
                'assets/calcbot-greeting.json', 
                width: 300,
                height: 300,
              ),
            ),

            const SizedBox(height: 20,),
            Card(
              child: ListTile(
                title: const Text('Vector Operations'),
                subtitle: const Text('Perform Operations Like Dot Product, Cross Product, Magnitude and More!'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => 
                          const VectorOperationsPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return Stack(
                            children: [
                              Lottie.asset(
                                'assets/calcbot-page-transition.json',
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                              FadeTransition(
                                opacity: animation,
                                child: child,
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            )
            // Add More Cards Here
          ],
        ),
      ),
    );
  }
}
