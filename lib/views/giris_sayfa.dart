import 'package:bitirme/views/anasayfa.dart';
import 'package:flutter/material.dart';

class GirisSayfa extends StatefulWidget {
  @override
  _GirisSayfaState createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<GirisSayfa> {
  var tfKullaniciAdi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Image.asset("images/logo.png"),
              ),
              SizedBox(width: 300,
                  child: TextField(controller: tfKullaniciAdi,decoration: InputDecoration(hintText: "Kullanıcı Adı"),)),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Anasayfa(tfKullaniciAdi.text)));
                }, child: Text("GİRİŞ",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.orange),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
