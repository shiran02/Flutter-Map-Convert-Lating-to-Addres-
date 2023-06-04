import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLAtingToAddress extends StatefulWidget {
  const ConvertLAtingToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLAtingToAddress> createState() => _ConvertLAtingToAddressState();
}

class _ConvertLAtingToAddressState extends State<ConvertLAtingToAddress> {

  String stAddress = '';
  String st = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Text(stAddress),
          Text(st),
          GestureDetector(
            onTap: ()async{


              //address to longitude and latitude
              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");

              //latitude and lonitude to address
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);

              setState(() {
                stAddress = locations.last.longitude.toString() +" "+ locations.last.latitude.toString();
                st =  placemarks.reversed.last.country.toString() +"  "+placemarks.reversed.last.locality.toString()+"  "+
                    placemarks.reversed.last.subAdministrativeArea.toString();
              });
            },

            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green
                ),

                child: const Center(
                  child: Text("Convert",style: TextStyle(fontSize: 19.3 , color:Colors.black),),
                ),

              ),
            ),
          ),

        ],
      ),
    );
  }
}
