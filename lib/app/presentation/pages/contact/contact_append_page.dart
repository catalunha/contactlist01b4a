import 'package:contactlist01b4a/app/presentation/controllers/contact/contact_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ContactAppendPage extends StatefulWidget {
  final ContactController _contactController = Get.find();

  ContactAppendPage({Key? key}) : super(key: key);

  @override
  State<ContactAppendPage> createState() => _ContactAppendPageState();
}

class _ContactAppendPageState extends State<ContactAppendPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget._contactController.contactModel?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget._contactController.contactModel == null ? "Criar" : "Editar"} contato'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppTextFormField(
                label: 'Nome',
                controller: _nameTEC,
                validator: Validatorless.required('Nome é obrigatório'),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: widget._contactController.contactModel != null,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                    onPressed: () {
                      widget._contactController
                          .delete(widget._contactController.contactModel!.id);
                    },
                    label: const Text('Apagar esta task'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: context.primaryColor,
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._contactController.append(_nameTEC.text);
            Get.back();
          }
        },
        label: const Text(
          'Salvar contato',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
