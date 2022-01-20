// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticlesAdapter extends TypeAdapter<Articles> {
  @override
  final int typeId = 101;

  @override
  Articles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Articles(
      author: fields[0] as String,
      title: fields[1] as String,
      date: fields[4] as String,
      url: fields[7] as String,
      urlToImage: fields[3] as String,
      time: fields[5] as String,
      content: fields[6] as String,
      readmoreUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Articles obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.readmoreUrl)
      ..writeByte(3)
      ..write(obj.urlToImage)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
