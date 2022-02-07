// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sary/Models/Transactions.dart';
import 'package:sary/Providers/Items_provider.dart';
import 'package:sary/Providers/Transactions_provider.dart';
import 'package:sary/Screens/ItemsScreen.dart';
import 'package:sary/Screens/TransactionDetailsScreen.dart';
import 'package:sary/Widgets/ItemCard.dart';
import 'package:sary/Widgets/Toast.dart';
import 'package:sary/Widgets/TransactionItemCard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final Box<dynamic> items_db = await Hive.openBox('Items');
  final Box<dynamic> transactions_db = await Hive.openBox('Transactions');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Items(items_db)),
      ChangeNotifierProvider(create: (_) => Transactions(transactions_db)),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Futura'),
      home: TransactionsScreen(),
    );
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemsScreen()));
              },
              icon: SvgPicture.asset('assets/svg/addTransaction.svg'))
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 310,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 15),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.cyan),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.withOpacity(.5)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  width: 1,
                                )),
                            prefixIcon: SvgPicture.asset(
                              'assets/svg/search.svg',
                              fit: BoxFit.scaleDown,
                            ),
                            prefixIconColor: Colors.black,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(.5))),
                            child: SvgPicture.asset('assets/svg/filter.svg'),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context.read<Transactions>().transactions.length,
                    itemBuilder: (context, int) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionDetailsScreen(
                                        transaction: context
                                            .read<Transactions>()
                                            .transactions[int],
                                      )));
                        },
                        child: TransactionItemCard(
                            context.read<Transactions>().transactions[int]),
                      );
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
                          TransactionDialog(context, 'Outbound');
                          setState(() {});
                        },
                        child: Container(
                          width: 185,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color(0xff5044B8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/upArrow.svg',
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "SEND",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await TransactionDialog(context, 'Inbound');
                          setState(() {});
                        },
                        child: Container(
                          width: 185,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color(0xff5044B8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/downArrow.svg',
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "RECEIVE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> TransactionDialog(
      BuildContext context, String transactionType) {
    String type = transactionType;
    int selectedIndex = 0;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        List<Transaction> transactionList =
            context.read<Transactions>().transactions;
        Transaction transaction = Transaction(
            id: transactionList.isEmpty ? 0 : transactionList.last.id + 1,
            inbound_at: "2012-02-27 11:00:00",
            itemId: 0,
            outbound_at: "2012-02-28 21:00:00",
            quantity: 25,
            type: transactionType);

        return AlertDialog(
          content: Container(
            height: 450,
            width: 350,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New ${type} Transaction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.cyan),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              width: 1, color: Colors.grey.withOpacity(.5)),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        hintText: "Quantity",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          transaction.quantity = int.parse(value),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: context.read<Items>().items.length,
                        itemBuilder: (context, index) {
                          return FittedBox(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index + 1;
                                  transaction.itemId = context
                                      .read<Items>()
                                      .items[selectedIndex - 1]
                                      .id;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: selectedIndex == index + 1
                                            ? Colors.blue
                                            : Colors.transparent)),
                                child: ItemCard(
                                  item: context.read<Items>().items[index],
                                  deleteButton: false,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          late FToast fToast = FToast();
                          fToast.init(context);
                          selectedIndex == 0
                              ? fToast.showToast(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 12.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.redAccent,
                                    ),
                                    child: Text(
                                      'You need to choose Item',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 2),
                                )
                              : {
                                  context
                                      .read<Transactions>()
                                      .transactions
                                      .add(transaction),
                                  fToast.showToast(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.greenAccent,
                                      ),
                                      child: Text(
                                        'Transaction has Saved successfully',
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: Duration(seconds: 2),
                                  ),
                                  Navigator.pop(context),
                                };
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff5044B8)),
                        ),
                        child: Text('Submit'))
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
