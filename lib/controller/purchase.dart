import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '/model/product.dart';

class Purchase extends GetxController {
  var products = <Product>[].obs;
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 1));

    var serverResponse = [
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
      Product(
        1,
        "Demo Product",
        "aby",
        "This is Product that we are going to show by getX",
        300.0,
      ),
    ];

    products.value = serverResponse;
  }
}
