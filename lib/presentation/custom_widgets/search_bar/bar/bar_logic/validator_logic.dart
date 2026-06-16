String? validationLogic(String? value) {
  final trimmed = value?.trim();
  if (value == '') {
    return null;
  }
  if (trimmed == null) {
    return 'Поле не может быть пустым';
  }
  final RegExp regex = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s\-]+$');
  if (!regex.hasMatch(trimmed)) {
    return 'Используйте только буквы и дефис';
  }
  return null;
}
