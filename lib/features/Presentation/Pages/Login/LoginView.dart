import 'package:flutter/material.dart';

import 'package:kerjain/Config/Routes/Routes.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/spacings.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/features/Presentation/widgets/AppButtonComp.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space24,
            vertical: AppSpacing.space40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: AppSpacing.space40),
              Text(
                'Welcome back,',
                style: AppFont.title1Bold.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              Text(
                'we happy to see you here again. Enter your email address and password.',
                style: AppFont.bodyRegular.copyWith(
                  color: Colors.black.withOpacity(0.7),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: AppSpacing.space40),
              
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email'),
              ),
              const SizedBox(height: AppSpacing.space16),

         
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: _inputDecoration('Password'),
              ),

              const SizedBox(height: AppSpacing.space40),
              AppButton(
                label: 'Login',
                size: AppButtonSize.large,          
                variant: AppButtonVariant.primary,   
                onPressed: () {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  if (email == "alifanwar@gmail.com" && password == "123") {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email atau password salah')),
                    );
                  }
                },
              ),

             
              const SizedBox(height: AppSpacing.space24),
              Center(
                child: Text(
                  'Forgot password?',
                  style: AppFont.bodyRegular.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),

              
              const SizedBox(height: AppSpacing.space24),
              AppButton(
                label: 'Create an Account',
                size: AppButtonSize.large,
                variant: AppButtonVariant.secondary,
                onPressed: () {
                  print("belum tau mau dibikin apa");
                },
              ),
              const SizedBox(height: AppSpacing.space24),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppFont.bodyRegular.copyWith(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE5E5E5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE5E5E5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.black,
          width: 1.5,
        ),
      ),
    );
  }
}
