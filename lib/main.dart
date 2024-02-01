import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/habitation_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mes locations'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typeHabitats;
  late List<Habitation> _habitations;
  MyHomePage({required this.title, Key? key}) : super(key: key) {
    _habitations = service.getHabitationsTop10();
    _typeHabitats = service.getTypeHabitats();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          _buildTypeHabitat(context),
        ],
      ),
    ),
  );
}

_buildTypeHabitat(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(6.0),
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        _typeHabitats.length,
            (index) => _buildHabitat(context, _typeHabitats[index]),
      ),
    ),
  );
}

_buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
  var icon = Icons.house;

  switch (typeHabitat.id) {
    case 2:
      icon = Icons.apartment;
      break;

    default:
      icon = Icons.home;
  }
  return Expanded(
    child: Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HabitationList(typeHabitat.id == 1),
              ));
        },


        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue,),
            SizedBox(width: 5),
            Text(
              typeHabitat.libelle,
              style: LocationTextStyle.regularGreyTextStyle,
            )
          ],
        ),
      ),
    ),
  );
}

_buildRow(Habitation habitation, BuildContext context) {
  return Container(
    width: 240,
    margin: EdgeInsets.all(4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'assets/images/locations/${habitation.image}',
            fit: BoxFit.fitWidth,
          ),
        ),

        Text(
            habitation.libelle,
            style: LocationTextStyle.regularGreyTextStyle),
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            Text(
              habitation.adresse, style: LocationTextStyle.regularGreyTextStyle,),
          ],
        ),
        Text(habitation.prixmois.toString(),
          style: LocationTextStyle.boldTextStyle,),
      ],
    ),
  );
}

}