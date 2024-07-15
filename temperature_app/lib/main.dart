import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverterPage(),
    );
  }
}

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  bool isFahrenheitToCelsius = true;
  TextEditingController _inputController = TextEditingController();
  String _result = '';
  List<String> _conversionHistory = [];
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
      conversionText = '$inputTemperature °F = ${convertedTemperature.toStringAsFixed(2)} °C';
      _result = '${convertedTemperature.toStringAsFixed(2)} °C';
    } else {
      convertedTemperature = (inputTemperature * 9 / 5) + 32;
      conversionText = '$inputTemperature °C = ${convertedTemperature.toStringAsFixed(2)} °F';
      _result = '${convertedTemperature.toStringAsFixed(2)} °F';
    }

    setState(() {
      _error = '';
      _conversionHistory.insert(0, conversionText);
    });
  }

  Widget _buildUnitButton(String label, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black, 
        backgroundColor: isSelected ? Colors.blueAccent : Colors.grey[300],
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void _navigateToHistoryPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConversionHistoryPage(
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
        title: Center(
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
          Text(
            'Convert from',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildUnitButton('Fahrenheit', isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = true;
                });
              }),
              _buildUnitButton('Celsius', !isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = false;
                });
              }),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'to',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildUnitButton('Celsius', !isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = false;
                });
              }),
              _buildUnitButton('Fahrenheit', isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = true;
                });
              }),
            ],
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertTemperature,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Convert'),
          ),
          SizedBox(height: 20),
          Text(
            _result.isEmpty ? '' : 'Converted Temperature: $_result',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToHistoryPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('View History'),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            'Convert from',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildUnitButton('Fahrenheit', isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = true;
                });
              }),
              _buildUnitButton('Celsius', !isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = false;
                });
              }),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'to',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildUnitButton('Celsius', !isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = false;
                });
              }),
              _buildUnitButton('Fahrenheit', isFahrenheitToCelsius, () {
                setState(() {
                  isFahrenheitToCelsius = true;
                });
              }),
            ],
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertTemperature,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Convert'),
          ),
          SizedBox(height: 20),
          Text(
            _result.isEmpty ? '' : 'Converted Temperature: $_result',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToHistoryPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('View History'),
          ),
        ],
      ),
    );
  }
}

class ConversionHistoryPage extends StatelessWidget {
  final List<String> conversionHistory;

  ConversionHistoryPage({required this.conversionHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion History'),
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
