import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/count_provider.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  GlobalKey key=GlobalKey();
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Page"),
      ),
      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
      
        children: [Text("This is a new page"),
        ElevatedButton(
              onPressed: () {
                context.read<CountProvider>().decrement();
              },
              child:  Text(context.watch<CountProvider>().count.toString())),
              const SizedBox(height: 20),
              TextField(
                
                key: key,
                controller: nameController,
                decoration: InputDecoration(
                 hintText: 'Enter a name',
                 contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                 
        ),
              ),
              ElevatedButton(onPressed: (){
                context.read<CountProvider>().changeName(nameController.text);
              }, child: Text("Change Name"))
  ]),)

  
    );
  }
}

