import 'package:bitirme/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekDetaySayfaCubit extends Cubit<void> {
  YemekDetaySayfaCubit():super(0);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepeteEkle(String yemek_adi,String yemek_resim_Adi,String yemek_fiyat,String yemek_siparis_adet,String kullanici_adi) async{
    await yrepo.sepeteYemekEkle(yemek_adi, yemek_resim_Adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}