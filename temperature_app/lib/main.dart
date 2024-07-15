import 'package:flutter/material.dart';
void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  bool isFahrenheitToCelsius = true;
  final TextEditingController _inputController = TextEditingController();
  String _result = '';
  final List<String> _conversionHistory = [];
  String _error = '';

  void _convertTemperature() {
    if (_inputController.text.isEmpty) {
      setState(() {
        _error = 'Please enter a temperature value';
      });
      return;
    }

    double inputTemperature = double.tryParse(_inputController.text) ?? 0;
    double convertedTemperature;
    String conversionText;

    if (isFahrenheitToCelsius) {
      convertedTemperature = (inputTemperature - 32) * 5 / 9;
      conversionText = '$inputTemperature °F = ${convertedTemperature.toStringAsFixed(1)} °C';
      _result = '${convertedTemperature.toStringAsFixed(1)} °C';
    } else {
      convertedTemperature = (inputTemperature * 9 / 5) + 32;
      conversionText = '$inputTemperature °C = ${convertedTemperature.toStringAsFixed(1)} °F';
      _result = '${convertedTemperature.toStringAsFixed(1)} °F';
    }

    setState(() {
      _error = '';
      _conversionHistory.insert(0, conversionText);
    });
  }

  Widget _buildTempButtons() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ToggleButtons(
          isSelected: [isFahrenheitToCelsius, !isFahrenheitToCelsius],
          onPressed: (int index) {
            setState(() {
              isFahrenheitToCelsius = index == 0;
            });
          },
          color: Colors.black,
          selectedColor: Colors.white,
          fillColor: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('F to °C'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('°C to F'),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConvertHistoryPage(
          conversionHistory: _conversionHistory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Temperature Converter'),
        ),
        backgroundColor: Colors.blueAccent,
        toolbarHeight: isLandscape ? 50.0 : kToolbarHeight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildTempButtons(),
          const SizedBox(height: 20),
          TextField(
            controller: _inputController,
            decoration: InputDecoration(
              labelText: 'Enter temperature',
              errorText: _error.isEmpty ? null : _error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertTemperature,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Convert'),
          ),
          const SizedBox(height: 20),
          Text(
            _result.isEmpty ? '' : 'Converted Temperature: $_result',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToHistory,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[200],
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View History', style: TextStyle(color: Colors.white)),

          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildTempButtons(),
          const SizedBox(height: 20),
          TextField(
            controller: _inputController,
            decoration: InputDecoration(
              labelText: 'Enter temperature',
              errorText: _error.isEmpty ? null : _error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertTemperature,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Convert'),
          ),
          const SizedBox(height: 20),
          Text(
            _result.isEmpty ? '' : 'Converted Temperature: $_result',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToHistory,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View History'),
          ),
        ],
      ),
    );
  }
}

class ConvertHistoryPage extends StatelessWidget {
  final List<String> conversionHistory;

  const ConvertHistoryPage({super.key, required this.conversionHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: conversionHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(conversionHistory[index]),
          );
        },
      ),
    );
  }
}
