import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/TurmasTemplate.dart';
import 'package:myclass/pages/user_auth/LoginPage.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final atual_tile = [true, false, false, false, false];
  int index_atual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        bottom: PreferredSize(
          child: _SearchView(),
          preferredSize: Size(1, 80),
        ),
        title: Text(
          "MyClass",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: _DrawerUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlertDialog();
        },
        backgroundColor: Colors_myclass.main_color,
        child: Icon(Icons.add),
      ),
      body: _listviewTurmas(),
    );
  }

  _SearchView() {
    return Container(
      color: Colors_myclass.main_color,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery.of(context).size.height*0.125,
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: "Pesquisar turmas",
          labelStyle: TextStyle(color: Colors.grey,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  _DrawerUser() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Utils.text_style("Username"),
            accountEmail: Utils.text_style("Username@anyemail.com"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: Text("Alterar Perfil",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.person),
            onTap: () => Nav.pushname(context, "/profile"),
          ),
          ListTile(
            title: Text("Preencher dados socioeconômicos",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.accessibility),
            onTap: () {},
          ),
          ListTile(
            title: Text("Criar Turma",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.add_circle_outline),
            onTap: () {
              List<dynamic> Turmas = Nav.getRouteArgs(context);
              Nav.pushname(context, "/create-turma", arguments: Turmas);
            },
          ),
          Spacer(),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            title:
            Text("Logout", style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.logout),
            onTap: () {
              Nav.push(context, LoginPage());
            },
          ),
        ],
      ),
    );
  }

  _listviewTurmas() {
    List<dynamic> Turmas = Nav.getRouteArgs(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Turmas.length,
        itemBuilder: (context, index) {
          final Turma = Turmas[index];
          return Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                child: TurmasTemplate(Turma),
                onTap: () =>
                    Nav.pushname(context, "/turma-page"),
              ));
        });
  }

   _showAlertDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Digite o código da turma",
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
          content: TextFormField(
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
                hintText: "Insira código da turma",
                hintStyle: TextStyle(
                  fontSize: 18,
                ),
                labelText: "Código da turma",
                labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
          ),
          actions: [
            FlatButton(
              onPressed: () => Nav.pop(context),
              child: Text("Entrar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
   }
}