import 'package:chd/features/login/manager/cubit/login_cubit.dart';
import 'package:chd/features/register/view/register.dart';
import 'package:chd/features/verification/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final p = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoading) {
            isLoading = true;
          } else {
            isLoading = false;
          }

          if (state is LoginSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyScreen(phone: p.text),
                ));
            
          }
        },
        builder: (context, state) {
          if (state is LoginFailure) {
            return const Scaffold(body: Center(child: Text("Error")));
          } else {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
                appBar: AppBar(title: const Text("Login")),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: p,
                            decoration: const InputDecoration(
                              hintText: "Phone Number",
                              labelText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Gap(16),
                          FilledButton(
                            onPressed: () {
                              final c = LoginCubit.get(context);
                              c.login(p.text, context);
                            },
                            child: const Text("Login"),
                          ),
                          const Gap(8),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: const Text("Register")),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     super.key,
//     required this.phone,
//   });
//   final String phone;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LoginCubit(getIt.get()),
//       child: BlocBuilder<LoginCubit, LoginState>(
//         builder: (context, state) {
//           if (state is LoginFailure) {
//             return const Text("error");
//           } else if (state is LoginLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return 
//           }
//         },
//       ),
//     );
//   }
// }
