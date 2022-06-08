class Contact {
  final int id;
  final String name;
  final int accountNumber;

  //construtor
  Contact(this.id, this.name, this.accountNumber);

  //se id for null substitui com 0
  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  String toString() {
    return 'Contact{ID: $id, name: $name, accountNumber: $accountNumber }';
  }
}
