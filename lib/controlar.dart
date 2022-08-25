import 'dart:typed_data';

import 'package:client_section/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';




class claintcontrolar extends GetxController {
  ClaintModel? claintModel;
  List<String> logs=[];
  int port=4000;
  Stream<NetworkAddress> ?stream;
  NetworkAddress ? address;


  @override
  void onInit() {
    // TODO: implement onInit
    getApiAdderss();
    super.onInit();
  } 
  getApiAdderss(){
    stream=NetworkAnalyzer.discover2('192.168.1', port);
    stream!.listen((NetworkAddress networkAddress) {
      if(networkAddress.exists){
        address=networkAddress;
        claintModel=ClaintModel(hostname: networkAddress.ip, onData: onData, onError: onError, port: port);

      }

     });
     update();
  }

void sendMessage(String message){
  logs.add("Me: $message");
  claintModel!.write(message); 
  update();
  

}


  onData(Uint8List data){
    final message=String.fromCharCodes(data);
    logs.add(message);

    update();

  }
  onError(dynamic data){
    debugPrint("error is : $data");

  }
}