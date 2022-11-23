import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Authors: GABRIEL MACHADO VIOLANTE, ÉRIC CATARINA PARREIRAS, ULISSES DRUMOND ROSA
// Date: 21/11/2022
// Turma: 303

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nomeCampeao = TextEditingController();


  void _resetFields() {
    _formKey = GlobalKey<FormState>();
    nomeCampeao.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF23828C),
        title: Text('Champion Lore Searcher'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          ),
        ],
      ),
      body: Stack(children: [

        Opacity(
          opacity: 0.9,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://mobimg.b-cdn.net/v3/fetch/62/62e3ce60fc426fe6f475764cd99779b9.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Opacity(
          opacity: 0.4,
          child: Image.asset('assets/images/JinxPoro.png'),
        ),

        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 20, 10,10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/JinxPoro.png'),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Insira o nome do campeão',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20),
                        border: OutlineInputBorder(),
                      ),

                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      controller: nomeCampeao,
                      validator: (value) {
                        if (value == null) return "Insira um nome";
                        if (value.toString().isEmpty) return "Insira um nome";
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                              (context) => telaCampeao(nomeCampeao: nomeCampeao.text)),
                        );
                        if (_formKey.currentState!.validate());
                      },
                      child: Text('Procurar'),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF23828C),
                        foregroundColor: Colors.white,
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class telaCampeao extends StatefulWidget {
  final String nomeCampeao;
  const telaCampeao({Key? key, required this.nomeCampeao}) : super(key: key);

  @override
  State<telaCampeao> createState() => _telaCampeaoState();
}

class _telaCampeaoState extends State<telaCampeao> {
  @override

  Future<http.Response> fetchAlbum() async{
    http.Response response = await http.get(Uri.parse('http://ddragon.leagueoflegends.com/cdn/12.22.1/data/en_US/champion/${widget.nomeCampeao}.json'));
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {

    Future lore = fetchAlbum();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF23828C),
        title: Text(widget.nomeCampeao),
        centerTitle: true,
      ),
  //
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${widget.nomeCampeao}_0.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
