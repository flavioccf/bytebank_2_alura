class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(this.name, this.accountNumber, {this.id});

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber, id: $id}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        accountNumber = json['accountNumber'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          other.name == name &&
          other.accountNumber == accountNumber;

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;
}
