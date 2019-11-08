

import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/models/ContactDAO.dart';
import 'package:test/test.dart';

void main() {
  test('Saving contact should works', () async {
    final contact = Contact("Ricardo", "email", "234948294");
    final dao = ContactDAO();
    await dao.save(contact);

    expect(contact.id, 1);
  });
}