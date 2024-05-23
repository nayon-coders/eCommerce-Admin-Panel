import 'package:flutter/material.dart';
import 'package:new_admin/utility/assets.dart';
import 'package:new_admin/view/auth/widgets/login.dart';

import '../../utility/colors.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool _isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.all(size.width*.10),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                color: Colors.grey.shade200
              )
            ],
            // image: DecorationImage(
            //   image: AssetImage(AppAssets.loginBg),
            //   fit: BoxFit.contain
            // )
          ),
          child: Row(
            children: [
              //static part
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Text("Welcome TO",
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text("Tech Tonic Solucations BD",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 200,
                      child: Text("We are here to help you to increase your business 80%",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: LoginWidgets(onCreateButtonPress: ()=> setState(() => _isLoginPage = false),)
              )


            ],
          ),
          
        ),
      ),
    );
  }
}
