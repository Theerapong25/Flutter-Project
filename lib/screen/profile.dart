
import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
          title: Text(
            'ผู้จัดทำ',
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 30,
                fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF8B0000),
        ),
        body: profileTab(), 
        
      ),
    );
  }
}

Widget profileTab() {
  return ListView(
    padding: EdgeInsets.all(20),
    children: [
      personProfile(
        image: 'assets/image/G.jpg',
        nameTH: "อธิวัฒน์ อภิวัฒน์ภูวสิน",
        nameEN: "Athiwat Apiwatpuwasin",
        gender: "ชาย (Male)",
        birthday: "26 มกราคม 2548",
        email: "athiwat2626tg@gmail.com",
        facebook: "Athiwat Apiwatpuwasin",
        ig: "tiger_atw",
        phone: "0935419915",
      ),
      
      personProfile(
        image: 'assets/image/I.jpg',
        nameTH: "ธีรพงศ์ กลิ่นฟุ้ง",
        nameEN: "Threerapong Klinfung",
        gender: "ชาย (Male)",
        birthday: "25 ธันวาคม 2547",
        email: "theerapong9200@gmail.com",
        facebook: "Threerapong Klinfung",
        ig: "I_icceee",
        phone: "0912345678",
      ),
      
      personProfile(
        image: 'assets/image/B.jpg',
        nameTH: "พสิษฐ์ ภูฆัง",
        nameEN: "Pasit Pukang",
        gender: "ชาย (Male)",
        birthday: "16 ธันวาคม 2547",
        email: "pasit@gmail.com",
        facebook: "Pasit Phukang",
        ig: "pasit_pubg",
        phone: "0898765432",
      ),
    ],
  );
}

Widget personProfile({
  required String image,
  required String nameTH,
  required String nameEN,
  required String gender,
  required String birthday,
  required String email,
  required String facebook,
  required String ig,
  required String phone,
}) {
  return Column(
    children: [
      CircleAvatar(
        radius: 70,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 65,
          backgroundImage: AssetImage(image),
        ),
      ),
      SizedBox(height: 20),
      Text(
        "ชื่อ: $nameTH",
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        "Name: $nameEN",
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        "เพศ: $gender",
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        "วันเกิด: $birthday",
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20),
      Text(
        "📞 Contact",
        style: TextStyle(color: Colors.blueAccent, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.email, color: Colors.black87, size: 20),
          SizedBox(width: 10),
          Text(email, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.facebook, color: Colors.blueAccent, size: 20),
          SizedBox(width: 10),
          Text(facebook, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, color: Colors.pink, size: 20),
          SizedBox(width: 10),
          Text(ig, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.phone, color: Colors.green, size: 20),
          SizedBox(width: 10),
          Text(phone, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    ],
  );
}