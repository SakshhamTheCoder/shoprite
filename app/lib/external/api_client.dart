import 'package:dio/dio.dart';

class APIClient {
  final String baseUrl = 'http://localhost:3000';

  Future<dynamic> _fetchData(String endpoint, {Map<String, dynamic>? params}) async {
    final String url = '$baseUrl/$endpoint';

    try {
      final response = await Dio().get(url, queryParameters: params);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<dynamic> fetchFlipkartSearch({Map<String, dynamic>? params}) async {
    return await _fetchData('api/flipkart/search', params: params);
  }

  Future<dynamic> fetchSearch({Map<String, dynamic>? params}) async {
    return await _fetchData('api/search', params: params);
    // return {
    //   "products": [
    //     {
    //       "productName": "Sample Product",
    //       "productLink": "https://www.amazon.in/sample-product",
    //       "thumbnail": "https://via.placeholder.com/150",
    //       "currentPrice": "₹999",
    //       "originalPrice": "₹1999",
    //       "vendor": "Amazon"
    //     },
    //     {
    //       "productName": "Sample Product 2",
    //       "productLink": "https://www.amazon.in/sample-product-2",
    //       "thumbnail": "https://via.placeholder.com/150",
    //       "currentPrice": "₹499",
    //       "originalPrice": "₹999",
    //       "vendor": "Amazon"
    //     },
    //     {
    //       "productName":
    //           "ABC AMOL BICYCLE COMPONENTS Premium Quality Cycle For Kids, Color -Red 14 T (inch) Road Cycle",
    //       "productLink":
    //           "https://www.flipkart.com/abc-amol-bicycle-components-premium-quality-cycle-kids-color-red-14-t-inch-road/p/itma79aeb7219f37?pid=CCEHY24Z7NCQZXYB&lid=LSTCCEHY24Z7NCQZXYBYHKBQ4&marketplace=FLIPKART&q=abc&store=search.flipkart.com&srno=s_1_1&otracker=search&fm=organic&iid=en_2QXjeLIRK-OZQcvQhzGaLnGUIRsNb1SfyLs3IFI5uDjRoIhv8ts55Da1BlFiqH_lCUpVaFHDq_7jK68VCP7Xsw%3D%3D&ppt=None&ppn=None&ssid=xinxb7a8m80000001745664326350&qH=900150983cd24fb0",
    //       "thumbnail":
    //           "https://rukminim2.flixcart.com/image/612/612/xif0q/cycle/y/m/d/premium-quality-cycle-for-kids-color-red-14-13-abc-amol-bicycle-original-imah3avvhfzdvyzg.jpeg?q=70",
    //       "currentPrice": "₹2,222",
    //       "originalPrice": "₹5,999",
    //       "vendor": "Flipkart"
    //     },
    //     {
    //       "productName": "ABC Nylon Home Use Apron - Free Size",
    //       "productLink":
    //           "https://www.flipkart.com/abc-nylon-home-use-apron-free-size/p/itm9db28d3b9f422?pid=APRH49Y6HHDFASKS&lid=LSTAPRH49Y6HHDFASKSDUIGDN&marketplace=FLIPKART&q=abc&store=search.flipkart.com&srno=s_1_2&otracker=search&fm=organic&iid=en_2QXjeLIRK-OZQcvQhzGaLnGUIRsNb1SfyLs3IFI5uDgKKjlMduJuU-atMQVRFKEpUJA_0TwnZ8qPcf9zw7T8Nw%3D%3D&ppt=None&ppn=None&ssid=xinxb7a8m80000001745664326350&qH=900150983cd24fb0",
    //       "thumbnail":
    //           "https://rukminim2.flixcart.com/image/612/612/xif0q/shopsy-apron/k/s/h/free-a2-nalixx-original-imahb5hhtphb8muz.jpeg?q=70",
    //       "currentPrice": "₹257",
    //       "originalPrice": "₹599",
    //       "vendor": "Flipkart"
    //     }
    //   ]
    // };
  }
}
