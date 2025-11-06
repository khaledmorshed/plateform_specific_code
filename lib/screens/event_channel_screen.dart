import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelScreen extends StatefulWidget {
  const EventChannelScreen({super.key});

  @override
  State<EventChannelScreen> createState() => _EventChannelScreenState();
}

class _EventChannelScreenState extends State<EventChannelScreen> {
  static const EventChannel _batteryEventChannel = EventChannel('samples.flutter.dev/charging');

  String _chargingStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _listenBatteryStatus();
  }

  void _listenBatteryStatus() {
    _batteryEventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _chargingStatus = event == 'charging' ? 'Charging ⚡' : 'Not charging ❌';
      });
    }, onError: (error) {
      setState(() {
        _chargingStatus = 'Error: ${error.toString()}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Status Listener')),
      body: Center(
        child: Text(
          _chargingStatus,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
