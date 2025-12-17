// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignUpTypeAdapter extends TypeAdapter<SignUpType> {
  @override
  final int typeId = 0;

  @override
  SignUpType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SignUpType.email;
      case 1:
        return SignUpType.google;
      case 2:
        return SignUpType.apple;
      default:
        return SignUpType.email;
    }
  }

  @override
  void write(BinaryWriter writer, SignUpType obj) {
    switch (obj) {
      case SignUpType.email:
        writer.writeByte(0);
        break;
      case SignUpType.google:
        writer.writeByte(1);
        break;
      case SignUpType.apple:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
