class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {

  List<String> list = ['Avanit' , "aava" , "Bass" , "ccdgeet" , "qwpio" , "oopp"
      "cvnnr"];

  String pattern = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _textField(),
              ElevatedButton(onPressed: (){}, child: Text("text"))
            ],
          ) ,
        ),
      ),
    );
  }
  Widget _textField(){
    return Container(
      child: Autocomplete(
        optionsBuilder: (value){
          print(value);
          List<String> filter = [];
          if(value.text.isNotEmpty){
            filter =  list.where((element) => element.contains(value.text))
                .toList();
          }
          return filter;
        },
        displayStringForOption: (String value)=>value,
        initialValue: TextEditingValue.empty,
        onSelected: (value){
          print(value);
        },
        optionsMaxHeight: 200,
        fieldViewBuilder: (context,textcontroller , focusnode , onsubmit){
          return TextField(
            controller: textcontroller,
            focusNode: focusnode,
            onSubmitted: (value){
              onsubmit;
            },
            onChanged: (value){
              setState(() {
                pattern = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2
                )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                  )
              ),

              hintText: "Search...",
            ),
          );
        },
        optionsViewBuilder: (context , select , list){
          return Material(
            child: Container(
              height: 200,
              child: ListView.builder(
                itemBuilder: (context,index){
                  return ListTile(title: _getText(list.elementAt(index).toString()));
                },
                itemCount: list.length,

              ),
            ),
          );
        },
      ),
    );
  }
  
 Widget _getText(String text){
    int firstIndex = text.indexOf(pattern);
    int lastIndex = text.lastIndexOf(pattern.substring(pattern.length - 1,pattern
        .length));



    String prefix = "";
    String suffix = "";

    for(int i=0;i<text.length;i++){
      if(i<firstIndex){
        prefix += text[i];
      }
      if(i>lastIndex){
        suffix += text[i];
      }
    }
    print("1st index: $firstIndex");
    print("last index: $lastIndex");

    print("prefix:  $prefix");
    print("suffix:  $suffix");

    return Container(
      child: Row(
        children: [
          prefix.isNotEmpty ? Text(prefix) : Container(),
          pattern.isNotEmpty ? Text(pattern,style: TextStyle(fontWeight:
          FontWeight.bold),) : Container(),
          suffix.isNotEmpty ? Text(suffix) : Container()

        ],
      ),
    );

 }

}
