import 'package:flutter/material.dart';

Widget indicadorPagina(bool currentPage){
  return Container(
    width: currentPage ? 15 : 10,
    height: currentPage ? 15 : 10,
    decoration: BoxDecoration (
      borderRadius: BorderRadius.circular(12),
      color: currentPage ? Colors.black87 : Colors.black38,

      ),
  );

}