import 'package:flutter/material.dart';
import 'api_service.dart';
import 'my_home_page.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalcBot',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override 
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   final ApiService apiService = ApiService('http://127.0.0.1:8000');
//   String _result = '';
//   bool _isLoading = false;

//   String _selectedOperation = 'dot_product';
//   List<int> _vector1 = [0, 0, 0];
//   List<int> _vector2 = [0, 0, 0];


// void _performVectorOperation() async {
//   setState(() {
//     _isLoading = true;
//   });

//   try {
//     final response = await apiService.performVectorOperation(_selectedOperation, [
//      _vector1,
//      _vector2
//     ]);
//     setState(() {
//       _result = response['result'].toString();
//     }); 
//   } catch (e) {
//     setState(() {
//       _result = 'Error Performing Operation. Please Try Again. $e';
//     });
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

// @override 
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('CalcBot'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text('Result:'),
//           Text(
//             _result,
//             style: Theme.of(context).textTheme.headlineMedium, 
//           ),
//           const SizedBox(height: 20),
//           _buildVectorInputField(
//             label: "Vector1 (comma-separated). Example: '1,2,3'.",
//             onChanged: (value) {
//               setState(() {
//                 _vector1 = _parseVector(value); 
//               });
//             },
//           ), 

//           _buildVectorInputField(
//             label: 'Vector 2 (comma-separated)',
//             onChanged: (value) {
//               setState(() {
//                 _vector2 = _parseVector(value);
//               });
//             },
//           ),

//           const SizedBox(height: 20),
//           DropdownButton<String>(
//             value: _selectedOperation,
//             items: <String> [
//               'dot_product',
//               'cross_product',
//               'magnitude',
//             ].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedOperation = newValue!;
//               });
//             },
//           ),
          
//           const SizedBox(height: 20),
//           _isLoading
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//               onPressed: _performVectorOperation, 
//               child: const Text('Perform Vector Operation'),
//               ),
//           ],

//         ),
//       ),
//     );
//   }

//   Widget _buildVectorInputField({
//     required String label, 
//     required ValueChanged<String> onChanged,
//   }) {
//     return TextField(
//       decoration: InputDecoration(labelText: label),
//       onChanged: onChanged,
//     );
//   }

//   List<int> _parseVector(String value) {
//     return value.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList();
//   }

// }

