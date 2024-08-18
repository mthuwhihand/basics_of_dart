import 'package:basics_of_dart/common/response.dart';
import 'package:basics_of_dart/models/services/auth_service.dart';
import 'package:basics_of_dart/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  bool hasInvalidEmailError =
      false; // Flag to indicate if there is an invalid email error
  bool hasInvalidPasswordError =
      false; // Flag to indicate if there is an invalid password error

  AuthBloc({required this.authService}) : super(AuthLoginInitial()) {
    on<AuthLoginEmailChangedEvent>(_onAuthLoginEmailChanged);
    on<AuthLoginPasswordChangedEvent>(_onAuthLoginPasswordChanged);
    on<AuthLoginSubmittedEvent>(_onAuthLoginSubmittedEvent);
    on<AuthLogoutRequestedEvent>(_onAuthLogoutRequestedEvent);
  }

  // Handle email change event and emit appropriate states
  void _onAuthLoginEmailChanged(
      AuthLoginEmailChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidEmailError) {
      if (!Validators.isValidEmail(event.email)) {
        emit(const AuthLoginFailureInvalidEmail());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  // Handle password change event and emit appropriate states
  void _onAuthLoginPasswordChanged(
      AuthLoginPasswordChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidPasswordError) {
      if (!Validators.isValidPassword(event.password)) {
        emit(const AuthLoginFailureInvalidPassword());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  // Handle login submission event and perform authentication
  void _onAuthLoginSubmittedEvent(
      AuthLoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress()); // Emit loading state to show loading circle

    // Validate email and password before calling authRepository
    if (!Validators.isValidEmail(event.email)) {
      hasInvalidEmailError = true;
      emit(
          const AuthLoginFailureInvalidEmail()); // Emit failure state for invalid email
      return;
    }

    if (!Validators.isValidPassword(event.password)) {
      hasInvalidPasswordError = true;
      emit(
          const AuthLoginFailureInvalidPassword()); // Emit failure state for invalid password
      return;
    }

    // Delay for 1 seconds before proceeding
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result =
          await authService.login(email: event.email, password: event.password);

      if (result is Success<bool> && result.data == true) {
        emit(AuthLoginSuccess());
      } else if (result is Failure<bool>) {
        emit(AuthLoginFailure(result.message));
      }
    } catch (error) {
      emit(AuthLoginFailure('Error during login: ${error.toString()}'));
    }
  }

  // Handle logout request event and perform logout
  void _onAuthLogoutRequestedEvent(
      AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress()); // Emit loading state to show loading circle

    // Delay for 1 seconds before proceeding
    await Future.delayed(const Duration(seconds: 1));

    try {
      final result = await authService.logout();

      if (result is Success) {
        emit(AuthLogoutSuccess());
      } else if (result is Failure) {
        emit(AuthLoginFailure(result.message));
      }
    } catch (error) {
      emit(AuthLoginFailure('Error during logout: ${error.toString()}'));
    }
  }
}
