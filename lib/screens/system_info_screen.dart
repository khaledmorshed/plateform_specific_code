import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemInfoScreen extends StatefulWidget {
  const SystemInfoScreen({super.key});

  @override
  State<SystemInfoScreen> createState() => _SystemInfoScreenState();
}

class _SystemInfoScreenState extends State<SystemInfoScreen> {
  static const platform = MethodChannel('samples.flutter.dev/systemInfo');
  Map<String, dynamic>? _info;

  Future<void> _getSystemInfo() async {
    try {
      final result = await platform.invokeMethod('getSystemInfo');
      setState(() {
        _info = Map<String, dynamic>.from(result);
      });
    } on PlatformException catch (e) {
      setState(() {
        _info = {"error": e.message};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getSystemInfo();
  }

  @override
  Widget build(BuildContext context) {
    final info = _info;
    return Scaffold(
      appBar: AppBar(title: const Text('System Info')),
      body: Center(
        child: info == null
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Device: ${info["device"] ?? "-"}'),
            Text('Manufacturer: ${info["manufacturer"] ?? "-"}'),
            Text('Android Version: ${info["androidVersion"] ?? "-"}'),
          ],
        ),
      ),
    );
  }
}
