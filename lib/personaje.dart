// Clase que representa un personaje obtenido de la API de Rick and Morty
class Personaje {
  // Atributos que representan las propiedades del personaje
  final int id; // Identificador único del personaje
  final String name; // Nombre del personaje
  final String status; // Estado del personaje (vivo, muerto, etc.)
  final String species; // Especie del personaje
  final String type; // Tipo del personaje (puede ser una cadena vacía)
  final String gender; // Género del personaje
  final String image;

  // Constructor que inicializa los atributos obligatorios
  Personaje({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
  });

  // Constructor de fábrica que convierte un mapa JSON en una instancia de Personaje
  factory Personaje.fromJson(Map<String, dynamic> json) {
    // Crea y devuelve una nueva instancia de Personaje con los valores del mapa JSON
    return Personaje(
      id: json['id'] as int ??
          0, // Obtiene el id del JSON o utiliza 0 si es nulo
      name: json['name'] as String ??
          "", // Obtiene el nombre del JSON o utiliza una cadena vacía si es nulo
      status: json['status'] as String ??
          "", // Obtiene el estado del JSON o utiliza una cadena vacía si es nulo
      species: json['species'] as String ??
          "", // Obtiene la especie del JSON o utiliza una cadena vacía si es nulo
      type: json['type'] as String ??
          "Normal", // Obtiene el tipo del JSON o utiliza "Normal" si es nulo
      gender: json['gender'] as String ??
          "", // Obtiene el género del JSON o utiliza una cadena vacía si es nulo
      image: json['image'] as String ?? "",
    );
  }
}
