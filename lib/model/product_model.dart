import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.productName,
    this.companyName,
    this.batch,
    this.datetime,

    this.mfgDate,
    this.expireDate,

    this.quantity,
    this.tPRate,
    this.packValue,
    this.packDisc,
    this.netTotal,

  });
  String id;
  String productName;
  String companyName;
  String batch;
  String datetime;

  String mfgDate;
  String expireDate;

  String quantity;
  String tPRate;
  String packValue;
  String packDisc;
  String netTotal;

  ProductModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    productName = doc["productName"];
    companyName = doc["companyName"];
    batch = doc["batch"];
    datetime = doc["datetime"];

    mfgDate = doc["mfgDate"];
    expireDate = doc["expireDate"];

    quantity = doc["quantity"];
    tPRate = doc["tPRate"];
    packValue = doc["packValue"];
    packDisc = doc["packDisc"];
    netTotal = doc["netTotal"];

  }

}