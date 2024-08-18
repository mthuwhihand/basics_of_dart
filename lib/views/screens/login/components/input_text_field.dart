import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final AuthState? state;
  final String? error;
  final String labelText;
  final double fontSize;
  final IconData? icon;
  final String? hint;
  final TextInputType type;
  final bool obscure;
  final TextInputAction? textInputAction;

  const InputTextField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    required this.controller,
    required this.state,
    required this.error,
    required this.labelText,
    required this.fontSize,
    this.icon,
    required this.hint,
    required this.type,
    required this.obscure,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.type,
      textInputAction: TextInputAction.next,
      obscureText: widget.obscure ? true : false,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 4.0, vertical: 20.0),
        prefixIcon: Icon(widget.icon, color: Colors.white),
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white70),
        errorText: widget.error,
      ),
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.white, fontSize: widget.fontSize),
    );
  }
}
