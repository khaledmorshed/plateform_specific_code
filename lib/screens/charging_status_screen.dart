import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChargingStatusScreen extends StatefulWidget {
  const ChargingStatusScreen({super.key});

  @override
  State<ChargingStatusScreen> createState() => _ChargingStatusScreenState();
}

class _ChargingStatusScreenState extends State<ChargingStatusScreen> {
  static const EventChannel eventChannel = EventChannel('samples.flutter.dev/charging');
  String _status = 'Unknown';

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    eventChannel.receiveBroadcastStream().listen((event) {
      if(mounted){
        setState(() {
          _status = event == 'charging' ? 'Charging ⚡' : 'Not Charging ❌';
        });
      }
    }, onError: (error) {
      if(mounted){
        setState(() {
          _status = 'Error: ${error.toString()}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Charging Status')),
      body: Center(
        child: Text(
          'Status: $_status',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
