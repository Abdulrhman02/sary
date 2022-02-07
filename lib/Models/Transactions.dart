class Transaction {
  int id;
  int itemId;
  int quantity;
  String type;
  String inbound_at;
  String outbound_at;
  Transaction({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.type,
    required this.inbound_at,
    required this.outbound_at,
  });
}
