import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csit2023/login_screen.dart';

class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;

    // ตรวจสอบว่าข้อมูลไม่ควรเป็นค่าว่าง
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        dob.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        password.isNotEmpty) {
      // URL ของ API (saveregister.php)
      String apiUrl = 'http://localhost/api_csit21/saveregister.php';

      // สร้าง body ของ request เพื่อส่งข้อมูล
      Map<String, dynamic> requestBody = {
        'firstname': firstName,
        'lastname': lastName,
        'dob': dob,
        'email': email,
        'phone': phone,
        'password': password,
      };

      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          body: requestBody,
        );

        if (response.statusCode == 200) {
          showSuccessDialog(context);
        } else {
          print('ไม่สามารถสมัครสมาชกิได้');
        }
      } catch (error) {
        print('เกิดข้อผิดผลาดในการเชื่อมต่อ : $error');
      }
    } else {
      // แจ้งเตือนถ้าข้อมูลไม่ครบ
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ข้อมูลไม่ครบถ้วน'),
            content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'Firstname'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Lastname'),
            ),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Telephone'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: Text('Goto Login Page'),
          ),
        ],
      );
    },
  );
}