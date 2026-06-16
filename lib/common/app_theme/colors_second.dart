import 'package:flutter/material.dart';

class ColorSystemForestRain {
  // ==================== ОСНОВНЫЕ ЦВЕТА ====================

  // Верхняя панель приложения (AppBar, SliverAppBar)
  static const Color COLOR_APPBAR = Color(0xFF2D6A4F);

  // Текст AppBar
  static const Color COLOR_APPBAR_TXT = Color(0xFFCCA674);

  // Основной фон экрана (Scaffold, Container основной)
  static const Color COLOR_BACKGROUND = Color(0xFFF0F7F4);

  // Фон карточек и панелей (Card, Dialog, BottomSheet)
  static const Color COLOR_SURFACE = Color(0xFFFDF5E6);

  // Основной цвет приложения (Кнопки, иконки, акценты, FloatingActionButton)
  static const Color COLOR_PRIMARY = Color(0xFF40916C);

  // Вторичный цвет (Второстепенные кнопки, рамки, индикаторы)
  static const Color COLOR_SECONDARY = Color(0xFF52B788);

  // Акцентный цвет (Выделение важных элементов, переключатели, чекбоксы)
  static const Color COLOR_ACCENT = Color(0xFFFFB703);

  // Основной текст (Заголовки, основной текст, лейблы)
  static const Color COLOR_TEXT_PRIMARY = Color(0xFF1B4332);

  // Второстепенный текст (Подписи, описания, дополнительная информация)
  static const Color COLOR_TEXT_SECONDARY = Color(0xFF52796F);

  // Фон карточки (Карточки прогнозов, списки)
  static const Color COLOR_CARD = Colors.white;

  // Цвет тени (Тени карточек, кнопок, модальных окон)
  static const Color COLOR_SHADOW = Color(0x1A2D6A4F);

  // ==================== ДОПОЛНИТЕЛЬНЫЕ ЦВЕТА ====================

  // COLOR_ERROR - Цвет ошибки (красный/лесной ягодный)
  // Используется для: сообщений об ошибках, валидации, некорректного ввода
  static const Color COLOR_ERROR = Color(0xFFD32F2F); // Лесная ягода - красный

  // COLOR_SUCCESS - Цвет успеха (зеленый/мшистый)
  // Используется для: успешных операций, подтверждений, завершенных задач
  static const Color COLOR_SUCCESS = Color(
    0xFF2E7D32,
  ); // Лесной мох - темно-зеленый

  // COLOR_WARNING - Цвет предупреждения (желтый/осенний лист)
  static const Color COLOR_WARNING = Color(
    0xFFFFB300,
  ); // Осенний лист - золотистый

  // COLOR_DIVIDER - Цвет разделителя (светло-зеленый/травяной)
  static const Color COLOR_DIVIDER = Color(
    0xFFC8E6C9,
  ); // Свежая трава - светло-зеленый

  // COLOR_DISABLED - Цвет неактивных элементов (приглушенный серо-зеленый)
  static const Color COLOR_DISABLED = Color(
    0xFFA5D6A7,
  ); // Выцветшая листва - бледно-зеленый
  // Цвет для фона градиента (небо сквозь листву)
  static const Color COLOR_GRADIENT_START = Color(0xFFE8F5E9);
  static const Color COLOR_GRADIENT_END = Color(0xFFC8E6C9);

  // Цвет для иконок погоды
  static const Color COLOR_WEATHER_ICON = Color(0xFF2D6A4F);

  // Цвет для выделения температуры
  static const Color COLOR_TEMPERATURE_HIGH = Color(0xFFFFB703);
  static const Color COLOR_TEMPERATURE_LOW = Color(0xFF52B788);
}
