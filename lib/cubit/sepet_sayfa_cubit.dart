import 'package:bitirme/entity/sepet_yemekler.dart';
import 'package:bitirme/entity/sepet_yemekler.dart';
import 'package:bitirme/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepettekiYemekleriYukle(String kullanici_adi) async{
    var liste = await yrepo.sepettekiYemekleriAl(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettenYemekSil(String sepet_yemek_id, String kullanici_adi) async{
    await yrepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepettekiYemekleriYukle(kullanici_adi);
  }
}