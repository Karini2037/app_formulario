import 'package:flutter/material.dart';

void main() { //inicialização da aplicação (MyApp)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulários ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {

final _formKey = GlobalKey<FormState>();

//controladores para os campos de entrada
final _nomeController = TextEditingController();
final _emailController = TextEditingController();

//funcao validação do formulário
void _submitForm(){
  if(_formKey.currentState?.validate()??false){
    // ScaffoldMessenger.of(context.showSnackBar(const SnackBar(content: Text('Enviado com Sucesso! '))));
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoPage(
          nome: _nomeController.text,
          email: _emailController.text,

        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //campo nome 
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'NOME:' 
                ),
                //validação do campo 
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox( height: 16,),

              //campo Email 
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E_MAIL:' 
                ),
                keyboardType: TextInputType.emailAddress,
                //validação do campo
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                    return'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
               const SizedBox( height: 16,),
               //botão enviar
               ElevatedButton(
                onPressed: _submitForm,
                child: const Text('ENVIAR'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

//PÁGINA RESULTADO
// Nova página de resultado com Card, imagem e ícones
class ResultadoPage extends StatelessWidget {
  final String nome;
  final String email;

  // Construtor da página, recebendo nome e email
  const ResultadoPage({super.key, required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Imagem no topo do card
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.network(
                  'https://m.media-amazon.com/images/I/619QaGrReCL._AC_SL1000_.jpg', // Substitua por sua própria imagem
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.email, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}