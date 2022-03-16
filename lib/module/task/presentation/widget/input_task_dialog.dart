import 'package:flutter/material.dart';
import 'package:tasking/module/shared/domain/exception.dart';
import 'package:tasking/module/shared/presentation/validator/validator.dart';
import 'package:tasking/module/shared/presentation/widget/error_dialog.dart';

typedef SaveCallback = Future<void> Function(String);

class ContentEditingController = TextEditingController with Type;

class InputTaskDialog extends StatelessWidget {
  final BuildContext _context;
  final String heading;
  final SaveCallback onSave;
  final ContentEditingController _contentController;

  final _formKey = GlobalKey<FormState>();

  InputTaskDialog({
    required BuildContext context,
    required this.heading,
    required this.onSave,
    String name = '',
    Key? key,
  })  : _context = context,
        _contentController = ContentEditingController()..text = name,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: AlertDialog(
            title: Text(heading),
            content: Column(
              children: <Widget>[
                TextFormField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'タスク内容',
                    hintText: 'タスクの簡単な内容',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.to([
                    NameValidator(name: 'タスク内容', max: 120),
                  ]),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('キャンセル'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('保存'),
                onPressed: () async => _onPressed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void show() {
    showDialog<void>(
      context: _context,
      builder: build,
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await onSave(
          _contentController.text,
        );
        Navigator.of(context).pop();
      } on DomainException catch (e) {
        Navigator.of(context).pop();
        ErrorDialog(
          context: _context,
          message: e.toJP(),
          onConfirm: show,
        ).show();
      }
    }
  }
}
