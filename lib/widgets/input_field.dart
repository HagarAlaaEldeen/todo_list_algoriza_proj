import 'package:flutter/material.dart';

class TaskInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const TaskInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(children: [
              Expanded(
                  child: TextFormField(
                readOnly: widget == null ? false : true,
                autofocus: false,
                cursorColor: Colors.grey[700],
                controller: controller,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500]),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500]),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0))),
              )),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ]),
          ),
        ],
      ),
    );
  }
}
