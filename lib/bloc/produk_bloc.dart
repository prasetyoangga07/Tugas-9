import 'dart:convert';
import 'package:h1d023028_tugas8/helpers/api.dart';
import 'package:h1d023028_tugas8/helpers/api_url.dart';
import 'package:h1d023028_tugas8/model/produk.dart';

class ProdukBloc {
  // GET All Produk
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;

    var response = await Api().get(apiUrl);
    List<dynamic> listProduk = response['data'];

    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }

    return produks;
  }

  // CREATE Produk
  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().post(apiUrl, body);
    return response["status"];
  }

  // UPDATE Produk
  static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString(),
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    return response["status"];
  }

  // DELETE Produk
  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);

    var response = await Api().delete(apiUrl);

    // karena status menentukan berhasil atau gagal
    return response["status"] == true;
  }

}
