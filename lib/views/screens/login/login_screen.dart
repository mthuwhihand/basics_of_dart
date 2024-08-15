import 'package:basics_of_dart/utils/colors.dart';
import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_bloc.dart';
import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_event.dart';
import 'package:basics_of_dart/viewmodels/blocs/auth_bloc/auth_state.dart';
import 'package:basics_of_dart/views/screens/login/components/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: ColorPalette.backgroundScaffoldColor,
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is AuthLoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoginInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/imgs/popcorn.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 48.0),
                  InputTextField(
                    controller: emailController,
                    state: state,
                    labelText: 'Email',
                    hint: 'Email',
                    fontSize: 18,
                    onChanged: (value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthLoginEmailChangedEvent(value));
                    },
                    obscure: false,
                    type: TextInputType.emailAddress,
                    error: state is AuthLoginFailureInvalidEmail
                        ? state.error.toString()
                        : null,
                  ),
                  const SizedBox(height: 16.0),
                  InputTextField(
                    controller: passwordController,
                    state: state,
                    labelText: 'Password',
                    hint: 'Password',
                    fontSize: 18,
                    onChanged: (value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthLoginPasswordChangedEvent(value));
                    },
                    obscure: true,
                    type: TextInputType.visiblePassword,
                    error: state is AuthLoginFailureInvalidPassword
                        ? state.error.toString()
                        : null,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLoginSubmittedEvent(
                          emailController.text, passwordController.text));
                    },
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
