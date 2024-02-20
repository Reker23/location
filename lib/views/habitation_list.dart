
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/views/habitation_details.dart';
import 'package:location/views/share/habitation_feature_widget.dart';
import '../models/habitation.dart';


class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late List<Habitation> _habitations;
  final bool isHouseList;

  HabitationList(this.isHouseList, {Key? key})
      : super(key: key) {
    _habitations = isHouseList ?
      service.getMaisons() :
      service.getAppartements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
          Text("Liste des ${this.isHouseList ? 'maisons' : 'appartements'}"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _habitations.length,
          itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
          itemExtent: 285,
        ),
      ),
    );
  }
}


_buildRow(Habitation habitation, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(8.0), // Add margin for overall spacing
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitationDetails(habitation),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/images/locations/${habitation.image}',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(height: 8.0), // Add space between image and details
          _buildDetails(habitation, context), // Pass context
        ],
      ),
    ),
  );
}


_buildDetails(Habitation habitation, BuildContext context) {
  var format = NumberFormat("### €");
  return Container(
    margin: EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              habitation.libelle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              habitation.adresse,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      format.format(habitation.prixmois),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "${habitation.chambres} chambre(s) - ${habitation.salleBains} salle(s) de bain",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Surface: ${habitation.superficie} m²",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    HabitationFeaturesWidget(habitation),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/locations/${habitation.image}',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
