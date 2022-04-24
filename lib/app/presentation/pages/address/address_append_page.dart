import 'package:contactlist01b4a/app/presentation/controllers/address/address_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/utils/part/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class AddressAppendPage extends StatefulWidget {
  final AddressController _addressController = Get.find();

  AddressAppendPage({Key? key}) : super(key: key);

  @override
  State<AddressAppendPage> createState() => _AddressAppendPageState();
}

class _AddressAppendPageState extends State<AddressAppendPage> {
  final _formKey = GlobalKey<FormState>();
  final _cepTEC = TextEditingController();
  final _descriptionTEC = TextEditingController();
  final _cityTEC = TextEditingController();
  final _stateTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cepTEC.text = widget._addressController.addressModel?.cep ?? "";
    _descriptionTEC.text =
        widget._addressController.addressModel?.description ?? "";
    _cityTEC.text = widget._addressController.addressModel?.city ?? "";
    _stateTEC.text = widget._addressController.addressModel?.state ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget._addressController.addressModel == null ? "Criar" : "Editar"} endereço'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'CEP',
                  controller: _cepTEC,
                  validator: Validatorless.required('CEP é obrigatório'),
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Descrição',
                  controller: _descriptionTEC,
                  validator: Validatorless.required('Descrição é obrigatória'),
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'Cidade',
                  controller: _cityTEC,
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  label: 'State',
                  controller: _stateTEC,
                ),
                Visibility(
                  visible: widget._addressController.addressModel != null,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                      onPressed: () {
                        widget._addressController.delete(
                            widget._addressController.addressModel!.id!);
                      },
                      label: const Text('Apagar este endereço'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: context.primaryColor,
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._addressController.append(
              cep: _cepTEC.text,
              description: _descriptionTEC.text,
              city: _cityTEC.text,
              state: _stateTEC.text,
            );
          }
        },
        label: const Text(
          'Salvar endereço',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
