/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Reports type in your schema. */
@immutable
class Reports extends Model {
  static const classType = const _ReportsModelType();
  final String id;
  final String? _category;
  final String? _description;
  final String? _firstname;
  final String? _lastname;
  final double? _latitude;
  final double? _longitude;
  final String? _reference;
  final String? _uid;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get category {
    return _category;
  }
  
  String? get description {
    return _description;
  }
  
  String? get firstname {
    return _firstname;
  }
  
  String? get lastname {
    return _lastname;
  }
  
  double? get latitude {
    return _latitude;
  }
  
  double? get longitude {
    return _longitude;
  }
  
  String? get reference {
    return _reference;
  }
  
  String? get uid {
    return _uid;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Reports._internal({required this.id, category, description, firstname, lastname, latitude, longitude, reference, uid, createdAt, updatedAt}): _category = category, _description = description, _firstname = firstname, _lastname = lastname, _latitude = latitude, _longitude = longitude, _reference = reference, _uid = uid, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Reports({String? id, String? category, String? description, String? firstname, String? lastname, double? latitude, double? longitude, String? reference, String? uid}) {
    return Reports._internal(
      id: id == null ? UUID.getUUID() : id,
      category: category,
      description: description,
      firstname: firstname,
      lastname: lastname,
      latitude: latitude,
      longitude: longitude,
      reference: reference,
      uid: uid);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Reports &&
      id == other.id &&
      _category == other._category &&
      _description == other._description &&
      _firstname == other._firstname &&
      _lastname == other._lastname &&
      _latitude == other._latitude &&
      _longitude == other._longitude &&
      _reference == other._reference &&
      _uid == other._uid;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Reports {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("category=" + "$_category" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("firstname=" + "$_firstname" + ", ");
    buffer.write("lastname=" + "$_lastname" + ", ");
    buffer.write("latitude=" + (_latitude != null ? _latitude!.toString() : "null") + ", ");
    buffer.write("longitude=" + (_longitude != null ? _longitude!.toString() : "null") + ", ");
    buffer.write("reference=" + "$_reference" + ", ");
    buffer.write("uid=" + "$_uid" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Reports copyWith({String? id, String? category, String? description, String? firstname, String? lastname, double? latitude, double? longitude, String? reference, String? uid}) {
    return Reports._internal(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      reference: reference ?? this.reference,
      uid: uid ?? this.uid);
  }
  
  Reports.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _category = json['category'],
      _description = json['description'],
      _firstname = json['firstname'],
      _lastname = json['lastname'],
      _latitude = (json['latitude'] as num?)?.toDouble(),
      _longitude = (json['longitude'] as num?)?.toDouble(),
      _reference = json['reference'],
      _uid = json['uid'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'category': _category, 'description': _description, 'firstname': _firstname, 'lastname': _lastname, 'latitude': _latitude, 'longitude': _longitude, 'reference': _reference, 'uid': _uid, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstname");
  static final QueryField LASTNAME = QueryField(fieldName: "lastname");
  static final QueryField LATITUDE = QueryField(fieldName: "latitude");
  static final QueryField LONGITUDE = QueryField(fieldName: "longitude");
  static final QueryField REFERENCE = QueryField(fieldName: "reference");
  static final QueryField UID = QueryField(fieldName: "uid");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Reports";
    modelSchemaDefinition.pluralName = "Reports";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.CATEGORY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.FIRSTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.LASTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.LATITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.LONGITUDE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.REFERENCE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Reports.UID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ReportsModelType extends ModelType<Reports> {
  const _ReportsModelType();
  
  @override
  Reports fromJson(Map<String, dynamic> jsonData) {
    return Reports.fromJson(jsonData);
  }
}