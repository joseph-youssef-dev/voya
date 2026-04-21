import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;

  const Password({
    super.key,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<Password> createState() => _ContainerDesignLoginState();
}

class _ContainerDesignLoginState extends State<Password> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Color(0xFF002D6E), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(widget.icon, color: Color(0xFF002D6E)),

          SizedBox(width: 10),

          Expanded(
            child: TextField(
              obscureText: widget.isPassword ? isHidden : false,

              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),

          //  العين
          if (widget.isPassword)
            IconButton(
              icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  isHidden = !isHidden;
                });
              },
            ),
        ],
      ),
    );
  }
}
