import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    //required this.pdfController,
    required this.onSubmitted,
    required this.controller,
  }) : super(key: key);

  //final PdfController pdfController;
  final Function(String value) onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Center(
        child: SizedBox(
          width: 60,
          height: 40,
          child: TextField(
            cursorColor: Colors.teal,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller,
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F2F2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(width: 0),
              ),
              hintText: 'Sayfa',
              /*suffixIcon: const Icon(
                Icons.search,
                color: Color(0xff3d3d3d),
                size: 24,
              ),*/
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(width: 0),
              ),
              hintStyle: const TextStyle(
                color: Color(0xFF3D3D3D),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
