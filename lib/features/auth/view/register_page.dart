import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/features/auth/view_model/auth_cubit.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 188, 248, 234),Color.fromARGB(
                      255, 253, 208, 248)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2,),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        onTap: () {},
                        decoration: const InputDecoration(
                          prefixText: '    ',
                          hintText: 'User name',
                          hintFadeDuration: Duration(milliseconds: 500),
                          hintStyle: TextStyle(color: Colors.grey,height: 3),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        onTap: () {},
                        decoration: const InputDecoration(
                          prefixText: '    ',
                          hintText: 'Email address',
                          hintFadeDuration: Duration(milliseconds: 500),
                          hintStyle: TextStyle(color: Colors.grey,height: 3),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: TextFormField(
                        onTap: () {},
                        obscureText: true,
                        decoration:  InputDecoration(
                          prefixText: '    ',
                          suffixIcon: IconButton(onPressed: (){}, icon:const Icon(Icons.remove_red_eye,color: Colors.grey,)),
                          hintText: 'Password',
                          hintFadeDuration: const Duration(milliseconds: 500),
                          hintStyle: const TextStyle(color: Colors.grey,height: 3),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey,
                              ),
                              height: 3,

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey,
                              ),
                              height: 3,

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blueGrey,
                              ),
                              height: 3,

                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration:  BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                color: Colors.blueGrey[700]

                            ),
                            child: MaterialButton(
                                child:const Text('Register',style: TextStyle(color: Colors.white,fontSize: 24,),),
                                onPressed: (){
                                  authCubit.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                  );
                                }

                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 50,
                          color: Colors.blueGrey,
                        ),
                        const Text('    or sign in with    '),
                        Container(
                          height: 1,
                          width: 50,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.hardEdge,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Image(image: AssetImage('assets/img/gg.webp')),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('already have an account? '),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Text('Login',style: TextStyle(color: Colors.blue),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
