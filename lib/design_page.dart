import 'package:client_section/client.dart';
import 'package:client_section/controlar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scaffaoldkey= GlobalKey<ScaffoldState>();
  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<claintcontrolar>(
      init: claintcontrolar(),
    
      builder: (controler) {
        return Scaffold(
        
          appBar: AppBar(
            title: Text("client"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(
              child: Column(
                children: <Widget>[
                   controler.claintModel==null || !controler.claintModel!.isconected?
                   Column(
                    children: [ 
                   InkWell(
                     onTap: () async {
                       await controler.claintModel!.conectet();
                        final info=await deviceInfoPlugin.androidInfo;
                        controler.sendMessage("conect to${info.brand} ${info.model}");
                        setState(() {                          
                        });
                     },
                     child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                       // ignore: prefer_const_literals_to_create_immutables
                       children: [
                         if(controler.address==null)
                         Text("No Device Found")
                         else
                         Column(
                           children: [
                              Text('Desktop'),
                         Text(controler.address!.ip),
                    
                           ],
                         )
                        
                       ],
                     ),
                   ),
                   
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       SizedBox(
                         height: 30,
                         width: 30,
                         child: CircularProgressIndicator(
                           strokeWidth: 2,
                         ),
                       ),
              
                       SizedBox(width: 20,),
                       TextButton.icon(onPressed: (){
                         controler.getApiAdderss();
                         setState(() {
                           
                         });
                       },
                      
                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
                        icon: Icon(Icons.search), label: const Text('search'))
                     ],
                   ),
                    ])
                    :Text("Conected to ${controler.claintModel!.hostname}") ,
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Client"),
                       TextButton(
                         
                         onPressed: (){},
                          child: Text('Disconectet'),)
                     ],
                   ),
                   if(controler.claintModel==null)
              
                   Text("No Server Found")
                   else 
                   TextButton(onPressed: ()async{
                      final info=await deviceInfoPlugin.androidInfo;
                      if(controler.claintModel!.isconected){
                      
                       controler.claintModel!.disconect(info);
                       setState(() {
                         
                       });
                    
                      }
                      else{
                       controler.claintModel!.conectet();
                       
                      }
                    
                    
                   }, child: Text(!controler.claintModel!.isconected?"Connect to server" :"Disconected From Server"),),
                    
                      Expanded(child: ListView(
                        children:controler.logs.map((e) => Text(e)).toList() ,
                      )),
                    
                       Container(
                            height: 80,
                           child: Row(children: [
                            Expanded(child: TextField(
                              controller: textEditingController,
                             
                              decoration: InputDecoration(
                                labelText: "Enter Message",
                              ),
                            )),
                             SizedBox(width: 10,),
                             IconButton(onPressed: (){
                              textEditingController.clear();
                        
                    
                             }, icon: Icon(Icons.clear)),
                             SizedBox(width: 10,),
                             IconButton(onPressed: (){
                    
                              controler.sendMessage(textEditingController.text);
                              setState(() {
                                
                              });
                              textEditingController.clear();
                              
                             }, icon: Icon(Icons.send)),
                    
                            ],)
                           ),
                          
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
