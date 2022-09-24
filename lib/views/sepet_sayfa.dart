import 'package:bitirme/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme/entity/sepet_yemekler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var sepetimBosMu ;
var sepetToplami ;

class SepetSayfa extends StatefulWidget {
  String kullaniciAdi;

  SepetSayfa(this.kullaniciAdi);

  @override
  _SepetSayfaState createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriYukle(widget.kullaniciAdi);
    sepetToplami = 0;
    sepetimBosMu = false;
  }

  @override
  Widget build(BuildContext context) {
    return !sepetimBosMu ? Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Sepet",style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
        builder: (context,sepettekiYemeklerListesi){
          sepetToplami = 0;
          for(var i = 0 ; i<sepettekiYemeklerListesi.length;i++){
            sepetToplami += int.parse(sepettekiYemeklerListesi[i].yemek_fiyat) * int.parse(sepettekiYemeklerListesi[i].yemek_siparis_adet);
          }
          if(sepettekiYemeklerListesi.isNotEmpty){
            return Column(
                children : [ Expanded(
                  child: ListView.builder(
                    itemCount: sepettekiYemeklerListesi.length,
                    itemBuilder: (context,indeks){
                      var sepettekiYemek = sepettekiYemeklerListesi[indeks];
                      return Card(
                        child: SizedBox(height: 80,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text("${sepettekiYemek.yemek_siparis_adet}"),
                              ),
                              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepettekiYemek.yemek_resim_adi}"),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0,top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${sepettekiYemek.yemek_adi}"),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text("Toplam Fiyat : ${int.parse(sepettekiYemek.yemek_fiyat) * int.parse(sepettekiYemek.yemek_siparis_adet)} ₺",
                                        style: TextStyle(color: Colors.orange),),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.orange),onPressed: (){

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Seçilen ürünü silmek istediğinize emin misiniz?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: (){

                                        context.read<SepetSayfaCubit>().sepettenYemekSil(sepettekiYemek.sepet_yemek_id, widget.kullaniciAdi);

                                        if(sepettekiYemeklerListesi.length  == 1){
                                          setState((){
                                            sepetimBosMu =true;
                                            sepettekiYemeklerListesi.clear();
                                          });
                                        }

                                      },
                                    ),
                                  ));

                                }, child: Text("Sil")),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 15),
                    child: Container(width:300,height:50,color: Colors.transparent,
                        child: Text("Sepet Toplamı : ${sepetToplami} ₺",style: TextStyle(fontSize: 30),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(minimumSize: Size(300, 40),primary: Colors.orange[400]),
                        onPressed: (){
                          for(var i = 0 ; i<sepettekiYemeklerListesi.length;i++){
                            context.read<SepetSayfaCubit>().sepettenYemekSil(String.fromEnvironment(sepettekiYemeklerListesi[i].sepet_yemek_id),"a");
                          }
                          setState(()
                          {
                            sepetimBosMu = true;
                            sepettekiYemeklerListesi.clear();
                          }
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Sepetiniz Onaylandı Tebrikler"),
                                  content: Text("Sepet toplamınız : ${sepetToplami} ₺"),
                                  actions:  [
                                    TextButton(child: Text("Tamam"),onPressed: (){
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                    }),
                                  ],);
                              }
                          );
                        }, child: Text("Sepeti Onayla")),
                  ),
                ],
            );
          }else{
            return Center(
              child:Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sepetiniz boş"),
                  Container(height: 50,),
                  Icon(Icons.local_mall,size: 100),
                ],
              ),
            );
          }
        },
      ),
    ):
    Scaffold(
      appBar: AppBar(
        title: Text("Sepetiniz",style: TextStyle(fontFamily: 'PtBold',fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: (){
          Navigator.of(context).popUntil((route) => route.isFirst);
        }, icon: Icon(Icons.arrow_back)),),
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sepetiniz boş"),
            Container(height: 50,),
            Icon(Icons.local_mall,size: 100),
          ],
        ),
      ),
    );
  }
}
