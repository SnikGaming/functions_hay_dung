import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  int id;
  String name;
  String description;
  double price;

  Product({this.id, this.name, this.description, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      };
}

Future<Product> fetchProduct(int id) async {
  final response =
      await http.get(Uri.parse('https://example.com/products/$id'));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Product.fromJson(json);
  } else {
    throw Exception('Failed to get product $id');
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://example.com/products'));
  if (response.statusCode == 200) {
    final List<dynamic> productsJson = jsonDecode(response.body);
    return productsJson.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get products');
  }
}

Future<Product> createProduct(Product product) async {
  final response = await http.post(Uri.parse('https://example.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()));
  if (response.statusCode == 201) {
    final json = jsonDecode(response.body);
    return Product.fromJson(json);
  } else {
    throw Exception('Failed to create product');
  }
}

Future<Product> updateProduct(int id, Product product) async {
  final response = await http.put(Uri.parse('https://example.com/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Product.fromJson(json);
  } else {
    throw Exception('Failed to update product $id');
  }
}

Future<void> deleteProduct(int id) async {
  final response =
      await http.delete(Uri.parse('https://example.com/products/$id'));
  if (response.statusCode != 204) {
    throw Exception('Failed to delete product $id');
  }
}

void main() async {
  final product1 =
      Product(name: 'Product 1', description: 'Description 1', price: 10.5);
  final createdProduct1 = await createProduct(product1);
  print('Created product: $createdProduct1');

  final product2 =
      Product(name: 'Product 2', description: 'Description 2', price: 20.5);
  final createdProduct2 = await createProduct(product2);
  print('Created product: $createdProduct2');

  final products = await fetchProducts();
  print('Products: $products');

  final productToUpdate = Product(
      id: createdProduct1.id,
      name: 'Updated Product 1',
      description: 'Updated Description 1',
      price: 15.5);
  final updatedProduct1 =
      await updateProduct(createdProduct1.id, productToUpdate);
  print('Updated product: $updatedProduct1');

  await deleteProduct(createdProduct2.id);
  print('Deleted product: ${createdProduct2.id}');

  final fetchedProduct1 = await fetchProduct(createdProduct1.id);
  print('Fetched product 1: $fetchedProduct1');
}
