import 'package:flutter/material.dart';
import '../Service/dragonball_service.dart';
import '../Models/dragonball_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DragonballService service = DragonballService();
  late Future<List<DragonBallModel>> charList;

  @override
  void initState() {
    super.initState();
    charList = DragonballService().getCharacters();
    charList.then((characters) {
  print("Characters count: ${characters.length}");

  for (var c in characters) {
    print(c.name);
  }
});
    
  }

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: FutureBuilder<List<DragonBallModel>>(
  future: charList,
  builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text("Error loading data"));
    }

    var characters = snapshot.data!;
    

    return GridView.builder(
  itemCount: characters.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,        // 2 columns
    childAspectRatio: 0.8,    // card shape
  ),
  itemBuilder: (context, index) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.network(
            characters[index].image,
            height: 100,
          ),

          SizedBox(height: 10),

          Text(
            characters[index].name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  },
);
  },
),
    );
  }
}