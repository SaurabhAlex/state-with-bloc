import 'dart:io';
import 'package:connectivity_with_bloc/signIn/bloc/sign_in_bloc.dart';
import 'package:connectivity_with_bloc/signIn/bloc/sign_in_event.dart';
import 'package:connectivity_with_bloc/signIn/bloc/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign-In Screen",
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            spacing: 20,
            children: [
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(state.errorMessage,
                      style: TextStyle(color: Colors.red));
                } else {
                  return Container();
                }
              }),
              TextField(
                controller: emailController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangedEvent(
                          emailController.text, passwordController.text));
                },
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: passwordController,
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangedEvent(
                          emailController.text, passwordController.text));
                },
                decoration: InputDecoration(hintText: "Password"),
              ),
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                return SizedBox(
                  width: 400,
                  child: CupertinoButton(
                    onPressed: () {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              emailController.text, passwordController.text));
                    },
                    color:
                        (state is SignInValidState) ? Colors.blue : Colors.grey,
                    child: (state is SignInLoadingState)
                        ? Center(
                            child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Platform.isAndroid
                                    ? CircularProgressIndicator(
                                        color: Colors.black,
                                      )
                                    : CupertinoActivityIndicator(
                                        color: Colors.black)),
                          )
                        : Text(
                            "Sign-in",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                );
              })
            ],
          )),
    );
  }
}
