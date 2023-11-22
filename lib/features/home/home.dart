import 'package:chd/core/cookie_manager.dart';
import 'package:chd/cubit/core_cubit.dart';
import 'package:chd/features/home/Model/home_model.dart';
import 'package:chd/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Welcome"),
                actions: [
                  TextButton(
                      onPressed: () {
                        CookieManager().clearToken();
                        CoreCubit.get(context).checkSignIN();
                      },
                      child: const Text("Sign out"))
                ],
              ),
              body: ListView.builder(
                itemBuilder: (context, index) =>
                    HomeCard(home: state.products[index]),
                itemCount: state.products.length,
              ),
            );
          } else if (state is HomeFailure) {
            return const Scaffold(
              body: Center(
                child: Text("Fail"),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.home,
  });
  final HomeModel home;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(.075),
          borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                home.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      home.type,
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      home.model,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Gap(16),
          SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Text(
                home.description,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              )),
        ],
      ),
    );
  }
}
