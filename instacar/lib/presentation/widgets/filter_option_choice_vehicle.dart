import 'package:flutter/material.dart';

class ChoiceChipWidgetVehicle extends StatefulWidget {
  const ChoiceChipWidgetVehicle({super.key});

  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidgetVehicle> {
  // Variável para armazenar o índice da opção selecionada
  int? _selectedIndex;

  final List<String> _optionsVehicle = [
    'Carro',
    'Moto'
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 15.0,
      children: List<Widget>.generate(
        _optionsVehicle.length,
        (int index) {
          return ChoiceChip(
            label: Text(_optionsVehicle[index]),
            selected: _selectedIndex == index,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedIndex = index; // Define o índice selecionado
                } else {
                  _selectedIndex = null; // Desmarcar a seleção
                }
              });
            },
            iconTheme: const IconThemeData(
              color: Colors.black,
              size: 20.0,
            ),
            selectedColor: Color.fromRGBO(100, 141, 219, 1),
            backgroundColor: Colors.grey[300],
            disabledColor: Colors.grey,
            labelStyle: TextStyle(
              color: _selectedIndex == index
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.transparent),
            ),
          );
        },
      ).toList(),
    );
  }
}

