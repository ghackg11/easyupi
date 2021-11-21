class Person {
  String pId;
  String pName;
  String? pImage;
  String? upiId;
  String? phoneNum;

  @override
  bool operator ==(Object other) {
    return pId==(other as Person).pId;
  }

  Person(this.pId, this.pName, {this.pImage, this.upiId, this.phoneNum});


}
