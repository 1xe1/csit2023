import 'package:flutter/material.dart';
import 'package:csit2023/main.dart';
import 'package:csit2023/register.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void SubmitLogin(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
// URL ของ API ที่คุณต้องการเรียกใช้ (saveregister.php)
    String apiUrl = 'http://localhost/api_csit21/checklogin.php';
//print(apiUrl);
// สร้าง body ของ request เพื่อส่งข้อมูล
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Login Successfully');
        showSuccessDialog(context);
      } else {
// ด าเนินการเมื่อ request ไม่ส าเร็จ
        print('Login Error');
        showLoginErrorDialog(context);
      }
    } catch (error) {
// ด าเนินการเมื่อเกิดข้อผิดพลาดในการเชื่อมต่อ
      print('เกิดข้อผิดพลาดในการเชื่อมต่อ: $error');
      showNotConnectDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(
                    'images/csitlogo.png'), // เปลี่ยนเป็นที่อยู่ของรูปภาพที่คุณใช้
                width: 250.0, // กำหนดความกว้าง
                height: 250.0, // กำหนดความสูง
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Login Name:'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true, // ซ่อนข้อความในรหัสผ่าน
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  SubmitLogin(context);
                },
                child: Text('Login'),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
// เพิ่มการไปหน้าสร้างผู้ใช้ที่นี่
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RegisterUserForm(),
                  ));
                },
                child: Text('Register!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showNotConnectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error Connection???'),
        content: Text('Your Connection Error..'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิดป๊อปอัพ
            },
            child: Text('Go Back'),
          ),
        ],
      );
    },
  );
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Successfully'),
        content: Text('Your information has been successfully saved..'),
        actions: [
          TextButton(
            onPressed: () {
//Navigator.of(context).pop(); // ปิดป๊อปอัพ
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Text('Goto Main menu'),
          ),
        ],
      );
    },
  );
}

void showLoginErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Login Error'),
        content: Text('Username & Password Not found..'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ปิดป๊อปอัพ
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}