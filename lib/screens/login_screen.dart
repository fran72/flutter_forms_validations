import 'package:flutter/material.dart';
import 'package:flutter_app_cap12/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import '../ui/ui.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  // String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  // RegExp regExp  = new RegExp(pattern);

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 130),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text('login',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 20),
                    ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Crear nueva cuenta',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'email',
                labelText: 'Email',
                icon: Icons.alternate_email_sharp,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Valor no permitido';
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'password',
                icon: Icons.lock_open,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Contraseña minima debe ser 6 caracteres';
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              disabledColor: Colors.red,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      Future.delayed(const Duration(seconds: 2));
                      loginForm.isLoading = false;
                      Navigator.pushReplacementNamed(context, 'home');
                    },
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
