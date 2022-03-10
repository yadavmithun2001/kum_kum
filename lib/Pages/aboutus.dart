import 'package:flutter/material.dart';

import '../constraint.dart';

class AboutusPage extends StatelessWidget {
  const AboutusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/back.png")
                    ),
                    Expanded(child: SizedBox()),
                    Center(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                SizedBox(height: 20),
                Text("About us",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey.shade400)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("We\'re KumKum",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28)),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                    "Diam sagittis sociosqu adipiscing. Per mollis in netus eros arcu tempor tempus adipiscing aenean rhoncus hendrerit dapibus "
                        "imperdiet curae; sociosqu lacus eget aptent potenti viverra imperdiet nam etiam placerat ac molestie tempor potenti. Dictum. \n"
                        "Malesuada cras morbi orci integer posuere pretium. Arcu pulvinar, luctus lacus magnis per blandit ultrices aliquam penatibus at lectus maecenas tempor nec proin mollis natoque netus ridiculus pellentesque felis. Mi nascetur gravida sagittis senectus dolor fringilla duis arcu dolor cum malesuada gravida varius nibh tristique senectus sociis ornare est pretium eu. \nIn vel hymenaeos eros duis malesuada venenatis sagittis. Tempor accumsan lobortis suspendisse rutrum adipiscing primis, erat. Ut velit dictum rhoncus malesuada orci urna aliquet massa egestas amet taciti vulputate ridiculus. Nisi eleifend tortor fames semper at facilisi montes suscipit dignissim hac nisl aenean imperdiet risus. Nonummy sociis phasellus. Mattis cursus. Fringilla netus pretium platea primis rhoncus ornare a porta duis per mus aliquam ac. Primis, id tellus. Ac lobortis.",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                )








              ],
            ),
          ),
        ),
      ),
    );
  }
}
