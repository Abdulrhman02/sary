// ignore_for_file: file_names, implementation_imports, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sary/Models/Item.dart';
import 'package:sary/Providers/Items_provider.dart';
import 'package:sary/Widgets/Toast.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({required this.item, this.deleteButton = true});

  final Item item;
  final bool deleteButton;

  @override
  Widget build(BuildContext context) {
    String name = item.name;
    String sku = item.sku;
    String description = item.descriptoin;
    String image = item.image;
    String price = item.price.toString();
    return Container(
      height: 122,
      width: 374,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 73,
                width: 126,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sku,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      //?There is no variable to indicate there are descount
                      // Text(
                      //   '12.13 SR',
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     decoration: TextDecoration.lineThrough,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              )
            ],
          ),
          deleteButton
              ? Positioned(
                  bottom: 1,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      late FToast fToast = FToast();
                      fToast.init(context);
                      context.read<Items>().deleteItem(item);
                      fToast.showToast(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.redAccent,
                          ),
                          child: Text(
                            'Item has been deleted',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 2),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
