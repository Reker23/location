
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
            SizedBox(height: 20),
            _buildHabitationsList(context),
          ],
        ),
      ),
    );
  }

  _buildHabitationsList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _habitations.length,
        itemBuilder: (context, index) {
          return _buildRow(_habitations[index], context);
        },
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
      margin: EdgeInsets.all(8.0), // Add margins
      padding: EdgeInsets.all(8.0), // Add padding for content separation
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners for the container
        border: Border.all(color: Colors.grey), // Add border for visual separation
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners for the image
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
              width: double.infinity, // Make the image take the full width
            ),
          ),
          SizedBox(height: 8.0), // Add spacing between image and text
          Text(
            habitation.libelle,
            style: LocationTextStyle.regularGreyTextStyle.copyWith(fontSize: 16.0),
            textAlign: TextAlign.left, // Align text to the left
          ),
          SizedBox(height: 4.0), // Add spacing between text and icon
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              SizedBox(width: 4.0), // Add spacing between icon and text
              Text(
                habitation.adresse,
                style: LocationTextStyle.regularGreyTextStyle.copyWith(fontSize: 14.0),
                textAlign: TextAlign.left, // Align text to the left
              ),
            ],
          ),
          SizedBox(height: 4.0), // Add spacing between text and price
          Text(
            '${habitation.prixmois.toString()}€', // Format the amount in euros
            style: LocationTextStyle.boldTextStyle.copyWith(fontSize: 18.0),
            textAlign: TextAlign.left, // Align text to the left
          ),
        ],
      ),
    );
  }


}