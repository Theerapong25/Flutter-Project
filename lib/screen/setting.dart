import 'package:final_project/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("การตั้งค่า"),
        backgroundColor: Colors.red.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text("ข้อมูลผู้จัดทำ"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // ---------------- App Version ----------------
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: Icon(Icons.info, color: Colors.green),
              title: Text("App Version"),
              subtitle: Text("1.0.0"),
            ),
          ),
          const SizedBox(height: 12),

          // ---------------- Toggle Theme ----------------
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode, color: Colors.purple),
              title: const Text("โหมดมืด (Dark Mode)"),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((onValue){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen ();
                  },));
                });
              },
              child: const Text('ออกจากระบบ'),
            ),
          ),
        ],
      ),
    );
  }
}
