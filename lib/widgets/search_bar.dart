import 'package:egitimlerim/consts.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const SearchInput({required this.textController, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              onChanged: (value) {
                //Do something wi
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black38,),
                filled: true,
                fillColor: cardColor,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black38),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            const Divider(
              color: appBarColor,
              thickness: 2.0,
              indent: 5.0,
              endIndent: 5.0,
            ),
          ],
        ),

      ),
    );
  }
}
