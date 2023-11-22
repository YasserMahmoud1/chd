import 'package:chd/cubit/core_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'manager/cubit/verify_cubit.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({Key? key, required this.phone}) : super(key: key);
  final String phone;
  final otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCubit(),
      child: BlocConsumer<VerifyCubit, VerifyState>(
        listener: (context, state) {
          if (state is VerifySuccess) {
            print("done2");
            Navigator.pop(context);
            CoreCubit.get(context).checkSignIN();
          }
        },
        builder: (context, state) {
          if (state is VerifyFailure) {
            return const Scaffold(body: Center(child: Text("Error")));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("OTP Verification"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: otp,
                          decoration: const InputDecoration(
                            hintText: "OTP (4-digits)",
                            labelText: "OTP",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const Gap(16),
                        FilledButton(
                            onPressed: () {
                              VerifyCubit.get(context)
                                  .verify(int.parse(otp.text), phone);
                            },
                            child: const Text("Verify")),
                      ],
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
