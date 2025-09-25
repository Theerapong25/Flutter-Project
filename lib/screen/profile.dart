
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
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
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
        image: 'assets/images/tiger.jpg',
        nameTH: "อธิวัฒน์ อภิวัฒน์ภูวสิน",
        nameEN: "Athiwat Apiwatpuwasin",
        gender: "ชาย (Male)",
        birthday: "26 ธันวาคม 2548",
        email: "athiwat2626tg@gmail.com",
        facebook: "Athiwat Apiwatpuwasin",
        ig: "tiger_atw",
        phone: "0935419915",
      ),
      Divider(height: 50, thickness: 2, color: Colors.grey[400]),
      personProfile(
        image: 'assets/images/sea.jpg',
        nameTH: "ธีรพงศ์ กลิ่นฟุ้ง",
        nameEN: "Threerapong Krinfung",
        gender: "ชาย (Male)",
        birthday: "10 มกราคม 2547",
        email: "theerapong@example.com",
        facebook: "Threerapong Krinfung",
        ig: "theerapong_ig",
        phone: "0912345678",
      ),
      Divider(height: 50, thickness: 2, color: Colors.grey[400]),
      personProfile(
        image: 'assets/images/pubg.jpg',
        nameTH: "พสิษท์ ภูฆัง",
        nameEN: "Pasit Phukang",
        gender: "ชาย (Male)",
        birthday: "5 พฤษภาคม 2549",
        email: "pasit@example.com",
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