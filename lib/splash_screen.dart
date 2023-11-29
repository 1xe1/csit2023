import 'package:flutter/material.dart';
import 'package:csit2023/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('Images/csitlogo.png'),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Welcome !! CSIT Family',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              // กำหนดความกว้างให้เต็มหน้าจอ
              child: OutlinedButton(
                onPressed: () {
                  // เมื่อปุ่มถูกคลิก
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  fixedSize:
                      Size(300, 50), // กำหนดขนาดความกว้างและความสูงของปุ่ม
                  side: BorderSide(
                    color: Color.fromARGB(255, 164, 128, 225), // กำหนดสีขอบ
                    width: 2.0, // กำหนดความหนาขอบ
                  ),
                  backgroundColor:
                      Color.fromARGB(255, 164, 128, 225), // กำหนดสีพื้นหลัง
                ),
                child: Text(
                  'เริ่มใช้งาน',
                  style: TextStyle(
                    color: Colors.white, // กำหนดสีข้อความ
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
