import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/services/cache_helper.dart';
import 'package:mirror_original/core/utils/functions.dart';
import 'package:mirror_original/features/auth/view/register_page.dart';
import 'package:mirror_original/features/auth/view_model/auth_cubit.dart';
import 'package:mirror_original/features/auth/view_model/auth_state.dart';
import 'package:mirror_original/features/home/view/home_page.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
        listener: (context, state) {
          if(state is LoginErrorState)
          {
            showToast(message: state.error, state: ToastState.error);
          }
          if(state is LoginSuccessState)
          {
            context.read<HomeCubit>().getProducts();
            context.read<HomeCubit>().getCart();

            showToast(message: 'Logged in successfully', state: ToastState.success);
              navigateAndFinish(context, HomePage());
          }
        },
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
                    colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(
                        255, 255, 255, 255)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2,),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Login',style: TextStyle(color: Colors.blueGrey,fontSize: 35,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                            validator: (value)
                            {
                              if (value!.isEmpty)
                              {
                                return "Email is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                              color: Colors.blue,
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                            onTap: () {},
                            validator: (value)
                            {
                              if (value!.isEmpty)
                              {
                                return "Password is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                            obscureText: authCubit.isVisible,
                            decoration:  InputDecoration(
                              prefixText: '    ',
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    authCubit.changeIcon();
                                  },
                                  icon: authCubit.isVisible ? Icon(Icons.remove_red_eye_outlined,color: Colors.grey,) : Icon(Icons.visibility_off_outlined,color: Colors.grey,)),
                              hintText: 'Password',
                              hintFadeDuration: const Duration(milliseconds: 500),
                              hintStyle: const TextStyle(color: Colors.grey,height: 3),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                                onTap: (){},
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Forget Password?',style: TextStyle(color: Colors.blue),),
                                )),
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
                                    color: Color.fromRGBO(81, 179, 236, 1.0)
                                ),
                                child: MaterialButton(
                                    child: ConditionalBuilder(
                                      builder: (context) => Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      condition: state is! LoginLoadingState,
                                      fallback:(context) => Center(child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircularProgressIndicator(color: Colors.white,),
                                      )),
                                    ),
                                    onPressed: (){
                                      if(formKey.currentState!.validate())
                                      {
                                        authCubit.login(email: emailController.text.trim(), password: passController.text.trim());

                                      }
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
                              color: Color.fromRGBO(81, 179, 236, 1.0),
                            ),
                            const Text('    or sign in with    '),
                            Container(
                              height: 1,
                              width: 50,
                              color: Color.fromRGBO(81, 179, 236, 1.0),
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
                            const Text('Don\'t have an account? '),
                            InkWell(
                                onTap: (){
                                   navigateTo(context, RegisterPage());
                                },
                                child: const Text('Register',style: TextStyle(color: Colors.blue),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
