
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResaLocation extends StatefulWidget {
  @override
  _ResaLocationState createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];
  var format = NumberFormat("### €");

  @override
  Widget build(BuildContext context) {
    _loadOptionPayantes();
    return Scaffold(
      appBar: AppBar(
        title: Text('Réservation'),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(prixTotal),
          _buildRentButton(),
        ],
      ),
    );
  }

  Widget _buildResume() {
    // Implement _buildResume widget
  }

  Widget _buildDates() {
    // Implement _buildDates widget
  }

  Widget _buildNbPersonnes() {
    // Implement _buildNbPersonnes widget
  }

  Widget _buildOptionsPayantes(BuildContext context) {
    // Implement _buildOptionsPayantes widget
  }

  Widget _buildRentButton() {
    // Implement _buildRentButton widget
  }

  void _loadOptionPayantes() {
    // Implement _loadOptionPayantes
  }

  double get prixTotal {
    // Implement logic to calculate total price
    return 0.0;
  }
}

class TotalWidget extends StatelessWidget {
  final double prixTotal;

  TotalWidget(this.prixTotal);

  @override
  Widget build(BuildContext context) {
    // Implement TotalWidget UI
  }
}

