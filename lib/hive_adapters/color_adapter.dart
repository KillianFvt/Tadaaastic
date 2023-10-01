import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

// Créer une classe adaptateur pour le type Color
class ColorAdapter extends TypeAdapter<Color> {
  @override
  final typeId = 0; // Choisir un identifiant unique pour le type

  @override
  Color read(BinaryReader reader) {
    // Lire la valeur entière de la couleur
    int value = reader.readInt();
    // Créer une couleur à partir de sa valeur
    return Color.fromARGB(
      (value >> 24) & 0xFF, // Extraire le canal alpha
      (value >> 16) & 0xFF, // Extraire le canal rouge
      (value >> 8) & 0xFF, // Extraire le canal vert
      value & 0xFF, // Extraire le canal bleu
    );
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    // Écrire la valeur entière de la couleur
    writer.writeInt(obj.value);
  }
}