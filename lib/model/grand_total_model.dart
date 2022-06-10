import 'package:cloud_firestore/cloud_firestore.dart';

class GrandTotalModel {
  String id;
  String subTotal;
  String disc;
  String grandTotal;
  String day;
  String month;
  String year;

  GrandTotalModel(this.id,this.subTotal, this.disc, this.grandTotal, this.day,this.month,this.year);

  GrandTotalModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    subTotal = doc["subTotal"];
    disc = doc["disc"];
    grandTotal = doc["grandTotal"];
    day = doc["day"];
    month = doc["month"];
    year = doc["year"];
  }
}