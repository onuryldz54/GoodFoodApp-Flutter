import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:bitirme/entity/yemekler.dart';
import 'package:flutter/material.dart';

class YemekDetaySayfa extends StatefulWidget {
  String kullaniciAdi;
  Yemekler yemek;
  YemekDetaySayfa({required this.yemek, required this.kullaniciAdi});

  @override
  _YemekDetaySayfaState createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
  var textAdet = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Ürün Detayları",style: TextStyle(fontSize: 20),),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 40),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${int.parse(widget.yemek.yemek_fiyat)*int.parse(textAdet)}₺",style: TextStyle(fontSize: 25),),
                  Spacer(),
                  SizedBox(height: 40,width: 40,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        if(int.parse(textAdet)<=1){textAdet = "1";}
                        else{
                          var sayi = int.parse(textAdet)-1;
                          textAdet = sayi.toString();
                        }
                      });
                    }, child: Text("-",style: TextStyle(color: Colors.grey,fontSize: 20),),style: ElevatedButton.styleFrom(primary: Colors.white,),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Text(textAdet,style: TextStyle(fontSize: 20),),
                  ),
                  SizedBox(height: 40,width: 40,
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        var sayi = int.parse(textAdet)+1;
                        textAdet = sayi.toString();
                      });
                    }, child: Text("+",style: TextStyle(fontSize: 20),),style: ElevatedButton.styleFrom(primary: Colors.green),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: ElevatedButton(onPressed: (){
                context.read<YemekDetaySayfaCubit>().sepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, widget.yemek.yemek_fiyat, textAdet, widget.kullaniciAdi);
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        title: Text("${widget.yemek.yemek_adi} Sepete Eklendi"),
                      );
                    });
              }, child: Text("Sepete Ekle",style: TextStyle(fontSize: 20),),
                style: ElevatedButton.styleFrom(primary: Colors.orange,
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),),
            )
          ],
        ),
      ),
    );
  }
}
