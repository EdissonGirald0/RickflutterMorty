// Importaciones necesarias para trabajar con Flutter y realizar solicitudes HTTP
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'personaje.dart';

// Definición de la función asincrónica para obtener la lista de personajes
Future<List<Personaje>> fetchPersonajes() async {
  try {
    // Realiza una solicitud HTTP para obtener datos de la API de Rick and Morty
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    // Verifica si la respuesta del servidor es exitosa (código 200)
    if (response.statusCode == 200) {
      // Convierte la respuesta JSON en un mapa de Dart
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;

      // Extrae la lista de resultados del mapa JSON
      final List<dynamic> results = jsonResponse['results'];

      // Verifica si la lista de resultados no está vacía
      if (results.isNotEmpty) {
        // Mapea cada resultado a un objeto Personaje y devuelve la lista
        return results.map((result) => Personaje.fromJson(result)).toList();
      } else {
        // Si la lista está vacía, lanza una excepción
        throw Exception('No se encontraron personajes');
      }
    } else {
      // Si la respuesta del servidor no es exitosa, lanza una excepción con el código de estado
      throw Exception(
          'Fallo al cargar los personajes (${response.statusCode})');
    }
  } catch (e) {
    // Captura cualquier excepción durante el proceso y la lanza
    throw Exception('Error: $e');
  }
}

// Clase principal de la aplicación Flutter
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Estado de la aplicación
class _MyAppState extends State<MyApp> {
  // Variable que almacena el resultado futuro de la función fetchPersonajes
  late Future<List<Personaje>> futurePersonajes;

  @override
  void initState() {
    super.initState();
    // Inicializa la variable futurePersonajes con el resultado futuro de fetchPersonajes
    futurePersonajes = fetchPersonajes();
  }

  @override
  Widget build(BuildContext context) {
    // Estructura básica de la interfaz de la aplicación
    return MaterialApp(
      title: 'Fetchig a la api rickandMorty',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 56, 16, 126)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetching a la api RickAndMorty'),
        ),
        body: Center(
          // Construye la interfaz dependiendo del estado futuro de futurePersonajes
          child: FutureBuilder<List<Personaje>>(
            future: futurePersonajes,
            builder: (context, snapshot) {
              // Si se reciben datos exitosamente, muestra una lista de personajes
              if (snapshot.hasData) {
                return ListView.builder(
                  key:
                      UniqueKey(), // Añadir una clave única para actualizar la lista
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final personaje = snapshot.data![index];
                    return ListTile(
                      leading: Image.network("${personaje.image}"),
                      title: Text('${personaje.id} - ${personaje.name}'),
                      textColor: Color.fromARGB(255, 22, 1, 59),
                      subtitle: Text(
                          'Estado: ${personaje.status},\n Especie: ${personaje.species}, Tipo: ${personaje.type}, Genero: ${personaje.gender}'),
                    );
                  },
                );
              }
              // Si hay un error, muestra un mensaje de error
              else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // Si aún no se han recibido datos, muestra un indicador de carga
              else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

// Función principal que ejecuta la aplicación Flutter
void main() => runApp(const MyApp());
