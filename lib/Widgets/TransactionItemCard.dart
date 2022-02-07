// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:sary/Models/Transactions.dart';
import 'package:sary/Providers/Items_provider.dart';
import 'package:sary/Providers/Transactions_provider.dart';

class TransactionItemCard extends StatelessWidget {
  const TransactionItemCard(this.transaction);
  final Transaction? transaction;
  @override
  Widget build(BuildContext context) {
    String name = context.read<Items>().getItem(transaction!.itemId)!.name;
    String sku = context.read<Items>().getItem(transaction!.itemId)!.sku;
    String description =
        context.read<Items>().getItem(transaction!.itemId)!.descriptoin;
    String price =
        context.read<Items>().getItem(transaction!.itemId)!.price.toString();
    String date = transaction!.inbound_at;
    String type = transaction!.type;
    return Container(
      height: 122,
      width: 374,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Stock ${type == 'Inbound' ? 'In' : 'Out'}',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(transaction!.type == 'Inbound'
                      ? 'assets/svg/downArrow.svg'
                      : 'assets/svg/upArrow.svg'),
                ],
              ),
              Text(date.substring(0, 10)),
            ],
          )
        ],
      ),
    );
  }
}
