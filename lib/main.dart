import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ItemShop',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Electrónica'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.app_registration),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Productos Disponibles:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(child: ProductList()),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  ProductList({super.key});

  final List<Map<String, String>> products = [
    {
      'name': 'Llave Inglesa',
      'image': 'assets/images/llave inglesa.jpg',
      'price': '10.99',
      'description': 'Una herramienta versátil para trabajos de fontanería y mecánica.',
    },
    {
      'name': 'Destornillador Eléctrico',
      'image': 'assets/images/destornillador electrico.jpg',
      'price': '29.99',
      'description': 'Destornillador con motor eléctrico para facilitar el trabajo.',
    },
    {
      'name': 'Taladro Inalámbrico',
      'image': 'assets/images/taladro inalambrico.jpg',
      'price': '59.99',
      'description': 'Taladro inalámbrico de alta potencia para perforaciones precisas.',
    },
    {
      'name': 'Compresor de Aire',
      'image': 'assets/images/compresor de aire.jpg',
      'price': '99.99',
      'description': 'Compresor portátil ideal para inflar llantas y otros usos.',
    },
    {
      'name': 'Sierra Circular',
      'image': 'assets/images/sierra circular.jpg',
      'price': '79.99',
      'description': 'Sierra circular para cortar madera, metal y otros materiales.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Image.asset(
              products[index]['image']!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(
              products[index]['name']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${products[index]['price']}'),
                Text(
                  products[index]['description']!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Cart.addItem(products[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Producto agregado al carrito')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class Cart {
  static List<Map<String, String>> items = [];

  static void addItem(Map<String, String> item) {
    items.add(item);
  }

  static void removeItem(Map<String, String> item) {
    items.remove(item);
  }

  static List<Map<String, String>> getItems() {
    return items;
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  bool _isPaymentVisible = false;
  bool _paymentSuccess = false;

  void _showPaymentForm() {
    setState(() {
      _isPaymentVisible = true;
    });
  }

  void _pay() {
    if (_nameController.text.isNotEmpty && _cardController.text.isNotEmpty) {
      setState(() {
        _paymentSuccess = true;
        _isPaymentVisible = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese todos los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito de Compras')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Cart.getItems().length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Image.asset(
                        Cart.getItems()[index]['image']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(Cart.getItems()[index]['name']!),
                      subtitle: Text('\$${Cart.getItems()[index]['price']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          Cart.removeItem(Cart.getItems()[index]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Producto eliminado del carrito')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_paymentSuccess)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '¡Pago realizado con éxito!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            if (!_isPaymentVisible) ...[
              ElevatedButton(
                onPressed: _showPaymentForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Pagar'),
              ),
            ],
            if (_isPaymentVisible) ...[
              const SizedBox(height: 20),
              const Text(
                'Ingrese los detalles de pago:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cardController,
                decoration: const InputDecoration(labelText: 'Número de tarjeta de crédito'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Pagar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado correctamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de Nosotros')),
      body: const Center(child: Text('Aquí va la información sobre nosotros')),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Formulario de contacto',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Tu mensaje'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Enviar mensaje'),
            ),
          ],
        ),
      ),
    );
  }
}
