import 'package:flutter/material.dart';
import 'package:platform_specific_code/screens/system_info_screen.dart';
import 'battery_level_screen.dart';
import 'charging_status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BatteryLevelScreen()),
                  );
                },
                child: const Text('🔋 Battery Level (MethodChannel)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChargingStatusScreen()),
                  );
                },
                child: const Text('⚡ Charging Status (EventChannel)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SystemInfoScreen()),
                  );
                },
                child: const Text('📱 System Info (Inline Channel)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
