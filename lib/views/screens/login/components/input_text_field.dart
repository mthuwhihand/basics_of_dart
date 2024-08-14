
// import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_state.dart';
// import 'package:flutter/material.dart';

// class InputTextField extends StatefulWidget {
//   final Function(String)? onSubmitted;
//   final Function(String)? onChanged;
//   final TextEditingController? controller;
//   final AuthState? state;
//   final AuthLoginFailure? errorState;
//   final String labelText;
//   final IconData? icon;
//   final String? hint;
//   final TextInputType type;
//   final bool obscure;
//   final TextInputAction? textInputAction;

//   const InputTextField({
//     super.key,
//     this.onSubmitted,
//     this.onChanged,
//     required this.controller,
//     required this.state,
//     required this.errorState,
//     required this.labelText,
//     this.icon,
//     required this.hint,
//     required this.type,
//     required this.obscure,
//     this.textInputAction = TextInputAction.next,
//   });

//   @override
//   State<InputTextField> createState() => _InputTextFieldState();
// }

// class _InputTextFieldState extends State<InputTextField> {
//   late final TextEditingController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: widget.controller,
//       onChanged: widget.onChanged,
//       onSubmitted: widget.onSubmitted,
//       keyboardType: widget.type,
//       textInputAction: TextInputAction.next,
//       obscureText: widget.obscure ? true : false,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//         prefixIcon: Icon(widget.icon, color: Colors.white),
//         hintText: widget.hint,
//         hintStyle: Theme.of(context)
//             .textTheme
//             .bodyMedium!
//             .copyWith(color: Colors.white70),
//         errorText: widget.errorState is AuthLoginFailureInvalidPassword
//             ? widget.errorState?.error.toString()
//             : null,
//       ),
//       style:
//           Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
//     );
//   }
// }
