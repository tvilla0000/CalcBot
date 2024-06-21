import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'vector_operations_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override 
  MyHomePageState createState() => MyHomePageState();
}

  class MyHomePageState extends State<MyHomePage> {
    bool _isTransitioning = false;

    void _navigateToVectorPage(BuildContext context) async {
      setState(() {
        _isTransitioning = true;
      });

      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const VectorOperationsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Stack(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 2.0,
                    heightFactor: 2.0,
                    child: Lottie.asset(
                      'assets/calcbot-page-transition.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ],
            );
          },
          // transitionDuration: const Duration(milliseconds: 1500),
        )
      ).then((_) {
        setState(() {
          _isTransitioning = false;
        });
      });
    }


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcbot'),
      ),

      body: _isTransitioning 
      ? Center(
        child: FractionallySizedBox(
          widthFactor: 2.0,
          heightFactor: 2.0,
          child: Lottie.asset(
            'assets/calcbot-page-transition.json',
            fit: BoxFit.contain,
          )
        ),
      )
     : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start  ,
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
                  onPressed: () =>  _navigateToVectorPage(context),
                ),
              ),
            )
            // Add More Cards Here
          ],
        )
        ),
      ),
    );
  }
}
  


