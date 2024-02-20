import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/views/share/habitation_feature_widget.dart';
import '../models/habitation.dart';
import '../share/location_style.dart';
import '../share/location_text_style.dart';


class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;

  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          _buildItems(),
          _buildOptionsPayantes(),
          _buildRentButton(),
        ],

      ),

    );
  }


  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Louer habitation');
              },
              child: Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }

  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: widget._habitation.options.map(
            (option) => Container(
          margin: EdgeInsets.all(2.0),
          padding: EdgeInsets.only(left: 15.0),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Row(
                children: [
                  Text("Inclus"),
                  Divider(
                    thickness: 20,
                    color: Colors.black,
                  ),
                ],
              ),

              Text(
                option.libelle,
                style: LocationTextStyle.regularGreyTextStyle,
              ),

                Text(
                  option.description,
                  style: LocationTextStyle.regularGreyTextStyle,
                ),

            ],
          ),
        ),
      ).toList(),
    );
  }


  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: widget._habitation.optionpayantes.map(
            (optionPayante) => Container(
          margin: EdgeInsets.all(2.0),
          padding: EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                optionPayante.libelle,
                style: LocationTextStyle.regularGreyTextStyle,
              ),
              Text(
                'Prix: ${optionPayante.prix}', // Assuming you want to display the price
                style: LocationTextStyle.regularGreyTextStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }


}
