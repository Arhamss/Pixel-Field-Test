import 'package:pixelfield_test/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyscaleBlack2,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: SvgPicture.asset(
            AssetPaths.leftArrowIcon,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Sign in',
                  style: context.h1,
                ),
                const SizedBox(height: 40),
                CustomTextField.email(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'email@email.com',
                  borderStyle: TextFieldBorderStyle.underline,
                  borderColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  cursorColor: AppColors.primary,
                  textStyle: context.b1.copyWith(
                    color: AppColors.greyscaleGrey1,
                  ),
                  hintColor: AppColors.greyscaleGrey1,
                ),
                const SizedBox(height: 24),
                CustomTextField.password(
                  controller: _passwordController,
                  labelText: 'Password',
                  borderStyle: TextFieldBorderStyle.underline,
                  borderColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  cursorColor: AppColors.primary,
                  textStyle: context.b1.copyWith(
                    color: AppColors.greyscaleGrey1,
                  ),
                  suffixIconColor: AppColors.primary,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Continue',
                  onPressed: _onContinue,
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.greyscaleBlack3,
                  borderRadius: 12,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  outsidePadding: EdgeInsetsDirectional.zero,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Can't sign in?",
                      style: context.b1.copyWith(
                        color: AppColors.greyscaleGrey2,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: _onRecoverPassword,
                      child: Text(
                        'Recover password',
                        style: context.t3.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      context.goNamed(AppRouteNames.collection);
    }
  }

  void _onRecoverPassword() {
    // TODO(recover): Navigate to recover password screen
  }
}
