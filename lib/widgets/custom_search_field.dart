import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField(
      {Key? key, this.hinText, this.iconData, this.onSuffixIconClick})
      : super(key: key);

  final String? hinText;
  final IconData? iconData;
  final void Function(String value)? onSuffixIconClick;

  @override
  State<CustomSearchField> createState() => CustomSearchFieldState();
}

class CustomSearchFieldState extends State<CustomSearchField> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          print("test");
        }
      },
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.email_outlined),
        fillColor: const Color.fromARGB(175, 255, 255, 255),
        filled: true,
        focusColor: Colors.blue,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        hintText: widget.hinText ?? 'Search',
        hintStyle: const TextStyle(color: Colors.black),
        suffixIcon: widget.iconData != null
            ? IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  widget.onSuffixIconClick!.call(controller.text);
                },
                icon: Icon(widget.iconData))
            : null,
      ),
    );
  }
}
