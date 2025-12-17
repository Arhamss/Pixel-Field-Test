import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.email,
  });

  final String? email;

  OnboardingState copyWith({
    String? email,
  }) {
    return OnboardingState(
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    email,
  ];
}
