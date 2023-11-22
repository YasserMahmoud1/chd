import 'package:chd/features/register/cubit/register_cubit.dart';
import 'package:chd/features/verification/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final fName = TextEditingController();
  final lName = TextEditingController();
  final mobile = TextEditingController();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else {
            isLoading = false;
          }

          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyScreen(phone: mobile.text),
                ));
          }
        },
        builder: (context, state) {
          if (state is RegisterFailure) {
            return const Scaffold(body: Center(child: Text("Error")));
          } else {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Register"),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fName,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              labelText: "First Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Gap(16),
                          TextFormField(
                            controller: lName,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                              labelText: "Last Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Gap(16),
                          TextFormField(
                            controller: mobile,
                            decoration: const InputDecoration(
                              hintText: "Phone number",
                              labelText: "Phone number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Gap(16),
                          FilledButton(
                              onPressed: () {
                                RegisterCubit.get(context).register(
                                    fName: fName.text,
                                    lName: lName.text,
                                    phone: mobile.text);
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
