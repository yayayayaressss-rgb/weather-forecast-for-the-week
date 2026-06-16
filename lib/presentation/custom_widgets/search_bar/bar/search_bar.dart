import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../state_management/bloc/bloc.dart';
import '../../../state_management/bloc/events/events.dart';
import '../../../state_management/cubit/network_check_cub/network_cubit.dart';
import 'bar_decoration.dart';
import 'bar_logic/validator_logic.dart';

class MySearchBar extends StatefulWidget {
  final bool isMetric;

  const MySearchBar({super.key, required this.isMetric});

  @override
  State<StatefulWidget> createState() => MySearchBarState();
}

class MySearchBarState extends State<MySearchBar> {
  late FocusNode focusNode;
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  late TextEditingController txtController;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    context.read<NetworkCubit>().check();
    focusNode = FocusNode();
    txtController = TextEditingController();
    txtController.addListener(() {
      if (_errorText != null) {
        setState(() {
          _errorText = null;
        });
      }
    });
  }

  @override
  void dispose() {
    txtController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _body(child: _buildForm());
  }

  Container _body({required Widget child}) {
    return Container(
      padding: EdgeInsetsGeometry.all(8.0),
      height: 100.0,
      width: double.infinity,
      child: child,
    );
  }

  Form _buildForm() {
    final style = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 16.0,
    );
    return Form(
      key: _validateKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        focusNode: focusNode,
        controller: txtController,
        onTapOutside: (_) {
          txtController.text = '';
          focusNode.unfocus();
          txtController.clear();
          setState(() {
            _errorText = null;
          });
          _validateKey.currentState?.reset();
        },
        onChanged: (value) {
          if (_errorText != null) {
            setState(() {
              _errorText = null;
            });
          }
        },
        onFieldSubmitted: (value) {
          if (_validateKey.currentState?.validate() ?? false) {
            context.read<MyBloc>().add(
              GetByNameEvent(params: value.trim(), isMetric: widget.isMetric),
            );
            focusNode.unfocus();
          } else {
            setState(() {
              _errorText = 'Некорректный ввод';
            });
          }
        },
        style: style,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: barDecor(
          txtController: txtController,
          context: context,
          action: () {
            focusNode.unfocus();
          },
          isMetric: widget.isMetric,
        ),
        validator: (value) {
          return validationLogic(value);
        },
      ),
    );
  }
}
