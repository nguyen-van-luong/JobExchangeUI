import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/reference_person.dart';

Widget buildReferencePerson(List<ReferencePerson> referencePeople) {
  return Column(
    children: [
      for(var referencePerson in referencePeople)
        referencePersonItem(referencePerson),
    ],
  );
}

Widget referencePersonItem(ReferencePerson referencePerson) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('- ${referencePerson.name} - ${referencePerson.position}', style: TextStyle(color: Colors.grey[700],), softWrap: true,),
        Text('  ${referencePerson.company}', style: TextStyle(color: Colors.grey[700],), softWrap: true,),
        Text('  SĐT: ${referencePerson.phoneNumber}', style: TextStyle(color: Colors.grey[700],), softWrap: true,)
      ],
    ),
  );
}