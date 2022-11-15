import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:email_auth/email_auth.dart';
import 'package:otp_verification/Pages/success.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  OtpFieldController otpController = OtpFieldController();
  late TextEditingController controller;
  bool isButtonActive = true;
  // Declare the object
  late EmailAuth emailAuth;
  bool submitValid = false;
  String code = "";




  @override
  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;

      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: controller.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  void verify() {
    var res = emailAuth.validateOtp(
        recipientMail: controller.value.text,
        userOtp: code);
    if(res) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Success(),
        ),
      );
    } else {
      print("Wrong OTP");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Enter Email ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style:
                            TextButton.styleFrom(onSurface: Colors.white),
                            onPressed: isButtonActive
                                ? () {
                              sendOtp();
                              setState(() => isButtonActive = false);
                            }
                                : null,
                            child: Text('Send'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Enter OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.grey.shade900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 0),
                    child: Text(
                      'we have sent the verification code to your phone number .',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                otpField(),
                SizedBox(
                  height: 70,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      verify();
                    } catch (e) {
                      print('Wrong OTP');
                    }
                  },
                  child: Container(
                      height: 60,
                    padding: EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width - 90,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFD54F),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 62),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'By clicking Login, you accept our',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey.shade900),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 106),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Terms & Condition',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget otpField() {
    return OTPTextField(
      controller: otpController,
      length: 6,
      margin: const EdgeInsets.only(left: 0, right: 12),
      width: MediaQuery.of(context).size.width,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 48,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 15,
      style: TextStyle(fontSize: 17),
      onChanged: (pin) {
        code = pin;
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
}
