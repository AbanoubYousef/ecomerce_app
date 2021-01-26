import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/products.dart';
import 'package:ecommerce/constans.dart';
import 'package:ecommerce/screens/admins/order_detailes.dart';
class Store{

  Firestore _store = Firestore.instance;

  addProduct(Product product) {
    _store.collection(kProducts).add({
      kPname: product.pName,
      kPcategory: product.pCategory,
      kPDescription: product.pDescreption,
      kPprice: product.pPrice,
      kPquantity: product. pQuantity,
      kPimageLocation: product.pImageLocation,
    });
  }

  Stream<QuerySnapshot> loadProducts(){
    return _store.collection(kProducts).snapshots();
  }

  Stream<QuerySnapshot> loadOrders(){
    return _store.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> ordersDetailes(documentId){
    return _store.collection(kOrders).document(documentId).collection(kOrderDetailes).snapshots();
  }


  deleteProduct(String docId){
    _store.collection(kProducts).document(docId).delete();
  }
  
  editProduct(data, dId){
    _store.collection(kProducts).document(dId).updateData(data);
  }

  storeOrders(data,List<Product>products){
   var documentRef =  _store.collection(kOrders).document();
   documentRef.setData(data);
   for(var pdt in products){
     documentRef.collection(kOrderDetailes).document().setData({
     kPname :pdt.pName,
     kPprice :pdt.pPrice,
     kPquantity :pdt.pQuantity,
     kPimageLocation :pdt.pImageLocation,
   });}
  }


}