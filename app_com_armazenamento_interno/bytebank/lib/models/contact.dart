class Contact {
  final int id;
  final String name;
  final int accountNumber;

  //construtor
  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact{ID: $id, name: $name, accountNumber: $accountNumber }';
  }
}
