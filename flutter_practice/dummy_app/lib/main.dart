import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countProvider = context.watch<CountProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPage()),
            ),
            child: const Text("Next page"),
          ),

          const SizedBox(height: 20),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: Container(
                  width: countProvider.count * 10,
                  height: countProvider.count * 10,
                  color: Colors.blue,
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          Text(countProvider.name.toString()),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              context.read<CountProvider>().increment();
            },
            child: Text(countProvider.count.toString()),
          ),

          Transform.scale(
            scale: 1.5
            ,child: Switch(value: isSwitched, onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeThumbImage: const NetworkImage(
                            "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQA2wMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABgcCAwQBCAX/xAAyEAEAAQQBAgUEAAILAAAAAAAAAQIDBBEFBiEHEjFBYRNRcYEyoRUiI0JSYnKiscHh/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AKNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABlTRVVVFNMTMzOoiI7zIPIiZ9DyzvSy+kvCTP5CmjK52/OBj1RFUWaI3eqifv7U+33n4hGOucfA4/nsjiuLwvoWcOr6fnrqmq5dq13mZn2+ARoez6ujJwr2Laxrt+ny0ZNr6tqf8AFT5qqf8AmmQcz2I26OQwr/HZt/DyqfLfsVzRcp+0w02p8tUT5Yq1O9T6SDHUw8Wtx3h1x/VnTGLy/D3K+Ny7sVRVZu7qtVVRMxOveIn9/hX3UHT/ACXT2dOJyuPVauf3avWmuPvTPvAPygAAAAAAAAAAAAAAAAAFzeDfRtqjGp6j5K157tydYdFcdqKfSbn5n0j/ANUzHqubH8WcDjsDEwuN4a/et2LNFuart6m1HaNdoiJ+QWyhPW/hzx/U96c2zeqw+Q8sRVcpp3Rc+3mj7/Lm4HxW4bkcijH5DHvcdcrnUV3Kortb/wBUa1+40n1M7iKomJ3G4mAfPfKeFPVOFXP0Ma1m0b7VWLsROvxVpanDdF8bldP9P083gVVZnHWKZppmuafLXuKqomInU9490w0Ao7rjoTqHlus+SyeN42qvFv3Ka6b9Vymmmd0xue8/fbu6d8G70103eoM+ii3v+tZxp3Mx9vNPouN7779wc+Fh4+BiWcTDsxZx7NPkt247xTT9u/q4OqOnsLqXibuBnU+sbtXY/itV+0x/38Ofqjq7iemLdH9IXKqr9cbt41mIquVfr0iPmUKq8ZbP1J8vA3Jtb9Zy482vx5dfzBUPL8df4nk8rj8unV/HuTRVr0n5j4mNS4kp8Q+cwuouf/pLBsXrH1LFNN2i9EbiuNx21M77aRYAAAAAAAAAAAAAAAAB2xPaPw4nTE9v0DZv7+nylmL4jdR4fEYvG4WVas28ejyU3ZtRXcqjfaJmrcdo7ensh+zYLC4TxY53EvUxy30uQx5n+t/Z027kR8TTER+tftcnB8xhc9x1rkONu/Us3O3+amr3pmPaXyztIOm+rM3p7C5PGxKp1nWfJFUVd7Vfp54+dbgFk9beKNHG5NzA6ft2ci/bny3cm53t0z7xTEa3+fRCrHid1Zbvxdr5K3diJ39KvFt+T/bET/NDNxEREPNg/T53l8nnOVyOSzJj61+YmaaZmYpiI1qN+zg217Ng15H8cfhqbL07q/TWAAAAAAAAAAAAAAAAA3RV2aWUSDZs2w2bBns2w2bBns2w2bBns2w2bArncsHsvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf/2Q==",
                    
                        ),
                        inactiveThumbImage:const NetworkImage("data:image/jpeg;base64,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"),
                         inactiveThumbColor: Colors.blue, 
                         activeThumbColor: Colors.black,
                        
                         activeTrackColor: Colors.black ,
                         inactiveTrackColor: Colors.amber[300],
                  ),
          ),

          CupertinoSwitch(value: isSwitched, onChanged: (a) {
            setState(() {
              isSwitched = a;
            });
          },
          ),
          // 🔥 Draggable Table
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // Drag Handle
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text("Name")),
                              DataColumn(label: Text("Age")),
                            ],
                            rows: const [
                              DataRow(cells: [
                                DataCell(Text("Balaji")),
                                DataCell(Text("22")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Ganesh")),
                                DataCell(Text("25")),
                              ]),
                              DataRow(cells: [
                                DataCell(Text("Chukka")),
                                DataCell(Text("19")),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}