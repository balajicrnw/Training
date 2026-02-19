class Self<T>{
  T content;
  static int updatesDone=0;
  static int count_id=0;
  int id=1;
  Map<int,T> selfcontents={};
  Self(this.id,this.content);
  void getContent(id){
    print("Content: ${selfcontents[id]}");
  }
  void addContent(int id,T content){
    if(selfcontents.containsKey(id)){
      print("id already present try updating content in self");
      return;
    }
    selfcontents[id]=content;
    count_id++;
  }
  void removeContent(int id){
    selfcontents.remove(id);
    count_id--;
  }
  void updateContent(int id,T content){
    selfcontents[id]=content;
    updatesDone++;
    print("Updates done: $updatesDone");
  }
  void numberOfContents(){
    print("Number of contents: ${count_id}");
  }

}
void main() { 
   Self<String> self = Self<String>(1,"one");
   self.addContent(2, "rendu");   
    self.addContent(3, "three");
    self.addContent(4, "nallu");
    self.getContent(2);
    self.updateContent(2, "two");
    self.getContent(2);
    self.numberOfContents();
    self.removeContent(4);
    self.numberOfContents();
    self.updateContent(2, "two");
    self.numberOfContents();
} 
