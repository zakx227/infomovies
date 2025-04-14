import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function()? onPressed;
  final TextEditingController? controller;

  const SearchField({super.key, this.onPressed, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Recherche par titre',
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}
