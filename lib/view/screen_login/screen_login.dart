import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaigo_test/controller/login/login_bloc.dart';
import 'package:zaigo_test/view/screen_home/screen_home.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController mobile = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('  Login')),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingWidget();
          } else if (state.isError) {
            return const ErrorWidget();
          } else if (state.isSucces) {
            return const SuccessWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputForm(
                  mobile: mobile,
                  password: password,
                  formKey: formKey,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(Login(
                            phoneNumber: mobile.text.trim(),
                            password: password.text.trim()));
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/login_successful.png'),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenHome(),
              ));
            },
            child: const Text('Continue'),
          ),
        )
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/login_failed.png'),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(Reset());
            },
            child: const Text('Retry'),
          ),
        )
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            'Logging In please wait',
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}

_loginSuccess(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const ScreenHome(),
    ),
  );
}

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.mobile,
    required this.password,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController mobile;
  final TextEditingController password;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          inputField(mobile, "Mobile"),
          const SizedBox(
            height: 20,
          ),
          inputField(password, "Password")
        ],
      ),
    );
  }

  TextFormField inputField(TextEditingController controller, String label) {
    return TextFormField(
      validator: (value) {
        return validate(value, label);
      },
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(),
        ),
        hintText: "Enter your $label",
        label: Text(label),
        suffixIcon:
            label == "Mobile" ? const Icon(Icons.mail) : const Icon(Icons.lock),
      ),
      keyboardType: label == "Mobile" ? TextInputType.number : null,
      obscureText: label == "Mobile" ? false : true,
    );
  }
}

String? validate(String? value, String label) {
  if (value == null || value.isEmpty) {
    return "$label cannot be empty";
  } else if (value.length < 6 && label == "Password") {
    return "Password should be more than 6 letters";
  } else if (label == "Mobile" && value.length != 10) {
    return "Enter a valid Mobile";
  }
  return null;
}
