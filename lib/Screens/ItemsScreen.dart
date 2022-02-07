// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/Models/Item.dart';
import 'package:sary/Providers/Items_provider.dart';
import 'package:provider/provider.dart';
import 'package:sary/Widgets/ItemCard.dart';
import 'package:sary/Widgets/Toast.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    late FToast fToast = FToast();
    fToast.init(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text(
          'Items',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/svg/backArrow.svg',
            color: Colors.black,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context.watch<Items>().items.length,
                    itemBuilder: (context, int) {
                      return ItemCard(item: context.watch<Items>().items[int]);
                    },
                    separatorBuilder: (context, int) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
            Positioned(
                bottom: 25,
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          List<Item> itemList = context.read<Items>().items;
                          Item item = Item(
                              id: itemList.isEmpty ? 0 : itemList.last.id + 1,
                              name: 'name',
                              sku: 'sku',
                              descriptoin: 'descriptoin',
                              image:
                                  'assets/image/127674218c916081c8247c24b4bd34e3.png',
                              price: 0.0);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 350,
                                    width: 350,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Add Item',
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.cyan),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.5)),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                            hintText: "Name",
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          onChanged: (value) =>
                                              item.name = value,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.cyan),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.5)),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                            hintText: "Description",
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          onChanged: (value) =>
                                              item.descriptoin = value,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.cyan),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.5)),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                            hintText: "Price",
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                              item.price = double.parse(value),
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.cyan),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.5)),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                )),
                                            hintText: "SKU",
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          onChanged: (value) =>
                                              item.sku = value,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<Items>()
                                                  .addItem(item);
                                              Navigator.pop(context);
                                              fToast.showToast(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 12.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    color: Colors.greenAccent,
                                                  ),
                                                  child: Text(
                                                    'Item has Saved successfully',
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                  ),
                                                ),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    Duration(seconds: 2),
                                              );
                                            },
                                            style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 50)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff5044B8)),
                                            ),
                                            child: Text('Add'))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 375,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color(0xff5044B8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add Item",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
