import 'package:flutter/material.dart';
import 'package:mirror_original/features/home/view/home_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffECECEF),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),

            // TOP LOGO
            Column(
              children: [

                const Text(
                  'ABU MOUSA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  width: 70,
                  height: 2,
                  color: Colors.black,
                ),
              ],
            ),

            const SizedBox(height: 120),

            // CENTER CONTENT
            Column(
              children: [

                const Text(
                  'Abu Mousa',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'PREMIUM FOOTWEAR',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.4,
                    child: LinearProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.white54,
                    ),
                ),

              ],
            ),

            const Spacer(),

            // FOOTER
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Authenticity & Quality Curated.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
