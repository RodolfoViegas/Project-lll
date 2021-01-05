import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/TurmasModel.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class CreateTurma extends StatefulWidget {
  List Turmas;


  CreateTurma(this.Turmas);


  @override
  _CreateTurmaState createState() => _CreateTurmaState();
}

class _CreateTurmaState extends State<CreateTurma> {

  List get Turmas => Turmas;

  final _formKey = GlobalKey<FormState>();
  List<String> Modalidades = ["","Teste1","Teste2","Teste3"];
  Map<String,String>turma_config = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "MyClass - Criar turma",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formTurma(),
    );
  }

  _formTurma(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Utils.spaceSmallHeight,
            Utils.Text_input(
                hintmensage: "Insira nome da turma *", labelmensage: "Nome da turma",
              onsaved: (newValue)  {
                turma_config["Nome"] = newValue;
              },),
            Utils.spaceSmallHeight,
            Utils.Text_input(
                hintmensage: "Descrição", labelmensage: "Descrição da turma",key_type: TextInputType.multiline,
              onsaved: (newValue)  {
                turma_config["descrição"] = newValue;
              },),
            Utils.spaceSmallHeight,
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Modalidade*'),
              items: Modalidades.map<DropdownMenuItem<String>>((modalidade) {
                return DropdownMenuItem<String>(
                  value: modalidade,
                  child: Text(modalidade),
                );
              }).toList(),
              value: "",
              onChanged: (value) {},
              onSaved: (newValue)  {
                turma_config["modalidade"] = newValue;
              },
            ),
            Utils.spaceBigHeight,
            Buttons_myclass.Button1(context,
                text: "Criar",
                function: (){
              _formKey.currentState.save();
              setState(() {
                Turmas.add(turma_config);
              });
              Nav.pop(context);
            }),
            Utils.spaceBigHeight,
          ],
        ),
      ),
    );
  }
}
