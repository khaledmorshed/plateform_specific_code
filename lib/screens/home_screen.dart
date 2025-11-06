import 'package:flutter/material.dart';
import 'package:platform_specific_code/screens/event_channel_screen.dart';

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
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const EventChannelScreen();
                      },
                    ),
                  );
                },
                child: Text("Event channel"),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const EventChannelScreen();
                      },
                    ),
                  );
                },
                child: Text("Event channel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
