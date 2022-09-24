import 'package:bitirme/entity/sepet_yemekler.dart';
import 'package:bitirme/entity/yemekler.dart';
import 'package:bitirme/entity/yemekler_cevap.dart';
import 'package:bitirme/entity/sepet_yemekler_cevap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class YemeklerDaoRepository {

  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemeklerListesi;
  }

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemeklerListesi;
  }

  Future<List<Yemekler>> tumYemekleriAl() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepeteYemekEkle(String yemek_adi,String yemek_resim_Adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_Adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi};
    var cevap = await http.post(url,body: veri);
  }

  Future<List<SepetYemekler>> sepettekiYemekleriAl(String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi" : kullanici_adi};
    var cevap = await http.post(url, body: veri);
    return parseSepetYemeklerCevap(cevap.body);
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id,String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {
      "sepet_yemek_id" : sepet_yemek_id,
      "kullanici_adi" : kullanici_adi};
    var cevap = await http.post(url, body: veri);
  }
}