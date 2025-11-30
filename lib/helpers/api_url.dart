class ApiUrl {
  // Ganti IP di sini sesuai IP lokal kamu
  static const String baseUrl = "http://192.168.1.29:8080";

  // Endpoint API
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';

  // Produk
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';

  static String updateProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String showProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }
}
