import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'api_service.dart';

class VectorOperationsPage extends StatefulWidget {
  const VectorOperationsPage({super.key});

  @override
  VectorOperationsPageState createState() => VectorOperationsPageState();
}


  class VectorOperationsPageState extends State<VectorOperationsPage> {
    final ApiService _apiService = ApiService('http://127.0.0.1:8000/');
    String _result = '';
    bool _isLoading = false;
    String _selectedOperation = 'dot_product';
    List<int> _vector1 = [0, 0, 0];
    List<int> _vector2 = [0, 0, 0];

    void _performVectorOperation() async {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _apiService.performVectorOperation(
          _selectedOperation,
          [_vector1, _vector2],
        );
        setState(() {
          _result = response['result'].toString();
        });
      } catch(e) {
        setState(() {
          _result = 'Error Performing The Operation. Please Try Again. $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vector Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Perform Vector Operations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Select An Operation And Enter The Vectors To Perform The Operation.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedOperation,
                items: <String>[
                  'dot_product',
                  'cross_product',
                  'magnitude',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOperation = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildVectorInputField(
                label: 'Vector 1 (comma-separated). For Example: 1, 2, 3',
                onChanged: (value) {
                  setState(() {
                    _vector1 = _parseVector(value);
                  });
                },
              ),
              if (_selectedOperation != 'magnitude')
              _buildVectorInputField(
                label: 'Vector 2 (comma-separated). For Example: 4, 5, 6',
                onChanged: (value) {
                  setState(() {
                    _vector2 = _parseVector(value);
                  });
                },
              ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
              ? Center(
                child: Lottie.asset(
                  'assets/calcbot-greeting.json',
                  width: 150,
                  height: 150,
                ),
              )
            : Column(
              children: [
                ElevatedButton(
                  onPressed: _performVectorOperation,
                  child: const Text('Perform Vector Operation'),
                ),
                const SizedBox(height: 20),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            Text(
              _result,
              style: Theme.of(context).textTheme.headlineLarge,
              ),
                Lottie.asset(
                  'assets/calcbot-greeting.json',
                  width: 300,
                  height: 300,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            //  Add Detailed Steps For Operation Here
            ],
          ),
        )
      );
    }

    Widget _buildVectorInputField({
      required String label,
      required ValueChanged<String> onChanged,
    }) {
      return TextField(
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      );
    }

    List<int> _parseVector(String value) {
      return value.split(',').map((e) => int.tryParse(e.trim()) ?? 0 ).toList();
    }

  }
