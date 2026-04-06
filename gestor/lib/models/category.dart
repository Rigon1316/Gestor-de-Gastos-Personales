import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CatInfo {
  final String nombre;
  final IconData icono;
  final Color color;
  const CatInfo(this.nombre, this.icono, this.color);
}

const categorias = [
  CatInfo('Comida', LineAwesomeIcons.hamburger_solid, Color(0xFFFF6B6B)),
  CatInfo('Transporte', LineAwesomeIcons.car_solid, Color(0xFF4ECDC4)),
  CatInfo('Entretenimiento', LineAwesomeIcons.film_solid, Color(0xFFFFE66D)),
  CatInfo('Salud', LineAwesomeIcons.heart_solid, Color(0xFFA29BFE)),
  CatInfo('Compras', LineAwesomeIcons.shopping_bag_solid, Color(0xFFFF9FF3)),
  CatInfo('Educación', LineAwesomeIcons.graduation_cap_solid, Color(0xFF54A0FF)),
  CatInfo('Servicios', LineAwesomeIcons.home_solid, Color(0xFF5F27CD)),
  CatInfo('Otros', LineAwesomeIcons.ellipsis_h_solid, Color(0xFF636E72)),
];

CatInfo catInfo(String nombre) => categorias.firstWhere(
  (c) => c.nombre == nombre,
  orElse: () => categorias.last,
);
