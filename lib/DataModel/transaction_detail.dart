//this is the data model of a transaction detail

class TransactionDetail {
  String recipientName;
  String phoneNumber;
  int transactionAmount;
  String applicationUsed;
  String transactionID;
  String dateTime;

  TransactionDetail(this.recipientName, this.phoneNumber, this.transactionAmount,
      this.applicationUsed, this.transactionID, this.dateTime);
}
