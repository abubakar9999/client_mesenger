import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

typedef Unit8ListCallback=Function(Uint8List data);
typedef dynamicCallback=Function(dynamic data);

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();



class ClaintModel{
  String hostname;
  int port;
  Unit8ListCallback onData;
  dynamicCallback onError;
  ClaintModel({required this.hostname,required this.onData,required this.onError,required this.port});

  bool isconected =false;
  Socket? socket;
  Future<void> conectet()async{
    try {
      socket =await Socket.connect(hostname, port);
    socket!.listen(onData, onError: onError,onDone:  () async{
      final info=await deviceInfoPlugin.androidInfo;
      disconect(info);
      isconected=false;
     });
     isconected=true;
      
    } catch (e) {
      debugPrint("debugPirint is aaaaaaaaaa $e");
      
    }
  }
  void write(String message){
    socket!.write(message);
  }

  void disconect(AndroidDeviceInfo androidDeviceInfo){
    final message="${androidDeviceInfo.brand}${androidDeviceInfo.model} disconected";
    write(message);
    if(socket!=null){
      socket!.destroy();

    }
    isconected=false;


  }

}


