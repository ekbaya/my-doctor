class Transaction{
  String description, id, amount, date, refrence, userId;

  Transaction({this.description, this.id, this.amount, this.date, this.refrence, this.userId});

  factory Transaction.fromJson(Map<dynamic, dynamic> json)=> transactionFromJson(json);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
      'description': description,
      'userId': userId,
      'id':id,
      'amount':amount,
      'date':date,
      'refrence':refrence,
    };
}

Transaction transactionFromJson(Map<dynamic, dynamic> json){
  return Transaction(
    description: json['description'] as String,
    date: json['date'] as String,
    refrence: json['refrence'] as String,
    amount: json['amount'] as String,
    id: json['id'] as String,
    userId: json['userId'] as String,
  );
}