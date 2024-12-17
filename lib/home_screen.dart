import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: BlocConsumer<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state == InternetState.gained) {
                    return const Text("Internet Connected!");
                  } else if (state == InternetState.lost) {
                    return const Text("Internet Not Connected");
                  } else {
                    return const Text("Loading....");
                  }
                },
                listener: (BuildContext context, state) {
                  if (state == InternetState.gained) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Connected"),
                      backgroundColor: Colors.green,
                    ));
                  } else if (state == InternetState.lost) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Not Connected"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
              )),
        ));
  }
}
