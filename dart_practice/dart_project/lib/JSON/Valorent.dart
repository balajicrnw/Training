class ValorentModel {
  String name;
  String role;

  ValorentModel({required this.name,required this.role});

  factory ValorentModel.fromJson(Map<String, String> json) {
    return ValorentModel(
      name :json['name']!,
      role :json['role']!
    );
  }

  Map<String,String> toJson(){
    return({
      'name':name,
      'role':role
    });
  }
}

void main(){
  List<Map<String,String>> jsonData=[
    {
      'name':'Jett',
      'role':'Duelist'
    },
    {
      'name':'Sage',
      'role':'Sentinel'
    },
    {
      'name':'Phoenix',
      'role':'Duelist'
    },
    {
      'name':'Sova',
      'role':'Initiator'
    }
  ];

  List<ValorentModel> agents=jsonData.map((json)=>ValorentModel.fromJson(json)).toList();

  agents.forEach((agent){
    print("Name: ${agent.name}");
    print("Role: ${agent.role}");
      print("*"*20);
    });

  ValorentModel newAgent= new ValorentModel(name: "Reyna", role: "Duelist");
  jsonData.add(newAgent.toJson());

  print(jsonData);
  }