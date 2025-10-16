import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Визначення типів поля для універсальності
enum InputType { email, password }

class YumPlansInput extends StatefulWidget {
  final InputType inputType;
  final String hintText;

  const YumPlansInput({
    super.key,
    required this.inputType,
    required this.hintText,
  });

  @override
  State<YumPlansInput> createState() => _YumPlansInputState();
}

class _YumPlansInputState extends State<YumPlansInput> {
  // Стан для керування видимістю пароля (Вимога 4)
  late bool _isPasswordHidden;

  @override
  void initState() {
    super.initState();
    // Пароль приховується, тільки якщо це поле для пароля
    _isPasswordHidden = widget.inputType == InputType.password;
  }

  // Створюємо іконку-префікс (Вимога 1)
  Widget _buildPrefixIcon() {
    final iconPath = widget.inputType == InputType.email
        ? 'assets/images/mail.svg'
        : 'assets/images/lock.svg';

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 10.0), // Додатковий відступ
      child: SvgPicture.asset(
        iconPath,
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(Color(0xFFDF6149), BlendMode.srcIn), // Колір іконки
      ),
    );
  }

  // Створюємо іконку-суфікс для пароля (Вимога 4)
  Widget? _buildSuffixIcon() {
    if (widget.inputType != InputType.password) {
      return null;
    }

    final iconPath = _isPasswordHidden
        ? 'assets/images/eye_off.svg'
        : 'assets/images/eye_on.svg'; // assets/images/eye_on.svg - припустимо, ви створите цю іконку

    return IconButton(
      icon: SvgPicture.asset(
        iconPath,
        width: 22,
        height: 20,
        colorFilter: const ColorFilter.mode(Color(0x99DF6149), BlendMode.srcIn), // Колір іконки
      ),
      onPressed: () {
        // Перемикання стану видимості
        setState(() {
          _isPasswordHidden = !_isPasswordHidden;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Фіксована висота контейнера (Вимога 5)
      child: TextField(
        // Властивості для пароля (Вимога 4)
        obscureText: _isPasswordHidden,
        keyboardType: widget.inputType == InputType.email
            ? TextInputType.emailAddress
            : TextInputType.text,

        // Стилізація, що імітує ваш Container (Вимога 5)
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF7F7F7), // Колір фону контейнера
          hintText: widget.hintText, // Текст зникає при введенні (Вимога 2)
          hintStyle: const TextStyle(
            color: Color(0xFF959595),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),

          // Видаляємо внутрішній відступ, щоб текст починався з початку
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),

          // Стилізація рамки та кутів
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0x59DF6149),
            ),
          ),
          // Забезпечуємо, щоб не було тіні при фокусі
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xFFDF6149),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0x59DF6149),
            ),
          ),

          // Іконки
          prefixIcon: _buildPrefixIcon(),
          suffixIcon: _buildSuffixIcon(),
          prefixIconConstraints: const BoxConstraints(minWidth: 40), // Відступи для іконки
        ),
      ),
    );
  }
}
