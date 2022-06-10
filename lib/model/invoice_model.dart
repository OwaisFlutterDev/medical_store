import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceModel {
  String id;
  String prodName;
  String prodId;
  String prodPrice;
  String qty;
  String totalPrice;

  InvoiceModel(
      this.id,
      this.prodName,
      this.prodId,
      this.prodPrice,
      this.qty,
      this.totalPrice
      );

  InvoiceModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    prodName = doc["prodName"];
    prodPrice = doc["prodPrice"];
    prodId = doc["prodId"];
    qty = doc["qty"];
    totalPrice = doc["totalPrice"];
  }
}