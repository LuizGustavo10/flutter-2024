// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pageBody(String imgUrl, String title, String description){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(imgUrl),
        Text(
          title,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
             
             ),
          ),
          Text(description, style: TextStyle(fontSize: 15, color: Colors.black26
          ),
          textAlign: TextAlign.justify,
          
          ),
      ],
    ),
  );
}