import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/count_provider.dart';
import 'dart:math';
import '../Pages/new_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [ChangeNotifierProvider(create: (context)=>CountProvider())],
      child:MaterialApp(
      
      title: 'Flutter Demo',
      
      home: const MyHomePage(),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20),
            ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPage())), child:Text("Next page")),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: Container(
                    width: context.watch<CountProvider>().count*10,
                    height:context.watch<CountProvider>().count *10,
                    color: Colors.blue,
                  ),
                );
              },
            ),
            Text(context.watch<CountProvider>().name.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<CountProvider>().increment();
              },
              child:  Text(context.watch<CountProvider>().count.toString())),
            
          ],
        ),
      ),
    );
  }
}
