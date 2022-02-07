// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:sary/Models/Transactions.dart';
import 'package:sary/Providers/Items_provider.dart';

class TransactionDetailsCard extends StatelessWidget {
  const TransactionDetailsCard({required this.transaction});

  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    String imagePath = context.read<Items>().items[transaction.itemId].image;
    String itemName = context.read<Items>().items[transaction.itemId].name;
    String itemSKU = context.read<Items>().items[transaction.itemId].sku;
    String itemDecreption =
        context.read<Items>().items[transaction.itemId].descriptoin;
    String itemPrice =
        context.read<Items>().items[transaction.itemId].price.toString();
    String transactionQuantity = transaction.quantity.toString();
    String transactionStackType =
        'Stock ${transaction.type == 'Inbound' ? 'In' : 'Out'}';
    String transactionInDate = transaction.inbound_at.substring(0, 10);
    String transactionInTime = transaction.inbound_at.substring(11);
    String transactionOutDate = transaction.outbound_at.substring(0, 10);
    String transactionOutTime = transaction.outbound_at.substring(11);
    var descriptionTextStyle = TextStyle(fontSize: 16);
    var dataTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    var sectionTextStyle = TextStyle(fontSize: 20);
    var itemTextStyle = TextStyle(fontSize: 16);
    return Container(
      height: 413,
      width: 374,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 73,
                width: 126,
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: itemTextStyle,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemSKU,
                        style: itemTextStyle,
                      ),
                      Text(
                        itemDecreption,
                        style: itemTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionQuantity,
                    style: dataTextStyle,
                  ),
                  Text("Quantity", style: descriptionTextStyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${itemPrice} SR',
                    style: dataTextStyle,
                  ),
                  Text("Price", style: descriptionTextStyle),
                ],
              ),
              Row(
                children: [
                  Text(
                    transactionStackType,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(transaction.type == 'Inbound'
                      ? 'assets/svg/downArrow.svg'
                      : 'assets/svg/upArrow.svg'),
                ],
              ),
            ],
          ),
          Text(
            'Inbound',
            style: sectionTextStyle,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionInDate,
                    style: dataTextStyle,
                  ),
                  Text("Date", style: descriptionTextStyle),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionInTime,
                    style: dataTextStyle,
                  ),
                  Text("Time", style: descriptionTextStyle),
                ],
              ),
            ],
          ),
          Text(
            'Outbound',
            style: sectionTextStyle,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionOutDate,
                    style: dataTextStyle,
                  ),
                  Text("Date", style: descriptionTextStyle),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactionOutTime,
                    style: dataTextStyle,
                  ),
                  Text("Time", style: descriptionTextStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
