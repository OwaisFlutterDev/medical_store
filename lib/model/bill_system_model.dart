import 'package:cloud_firestore/cloud_firestore.dart';

class BillSystemModel {
  BillSystemModel({
    this.id,
    this.productName,
    this.prodId,
    this.productPrice,
    this.datetime,
    this.month,
    this.day,
    this.quantity,
    this.totalBill,
    this.year
  });

  String id;
  String productName;
  String productPrice;
  String prodId;
  String datetime;
  String month;
  String day;
  String quantity;
  String year;
  String totalBill;

  BillSystemModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    productName = doc["productName"];
    prodId = doc["prodId"];
    productPrice = doc["productPrice"];
    datetime = doc["datetime"];
    month = doc["month"];
    day = doc["day"];
    quantity = doc["quantity"];
    totalBill = doc["totalBill"];
    year = doc["year"];
  }

}