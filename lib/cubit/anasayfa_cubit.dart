import  'package:bitirme/entity/yemekler.dart';
import 'package:bitirme/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await yrepo.tumYemekleriAl();
    emit(liste);
  }
}
