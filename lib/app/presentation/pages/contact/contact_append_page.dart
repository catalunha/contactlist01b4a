import 'package:contactlist01b4a/app/presentation/controllers/contact/contact_controller.dart';
import 'package:contactlist01b4a/app/presentation/pages/contact/part/calendar_button.dart';
import 'package:contactlist01b4a/app/presentation/pages/contact/part/photo_button.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
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
                const SizedBox(height: 16),
                CalendarButton(),
                const SizedBox(height: 16),
                PhotoButton(),
                const SizedBox(height: 16),
                Visibility(
                  visible: widget._contactController.contactModel != null,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                      onPressed: () {
                        widget._contactController.delete(
                            widget._contactController.contactModel!.id!);
                      },
                      label: const Text('Apagar este contato'),
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
            await widget._contactController.append(name: _nameTEC.text);
            // await widget._contactController.append(_nameTEC.text, _xfile);
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

/*
 GestureDetector(
                child: _xfile != null
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)),
                        child: kIsWeb
                            ? Image.network(_xfile!.path)
                            : Image.file(File(_xfile!.path)))
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)),
                        child: const Center(
                          child: Text('Click here to pick image from Gallery'),
                        ),
                      ),
                onTap: () async {
                  final XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    setState(() {
                      _xfile = pickedFile;
                    });
                  }
                },
              ),
*/


// GestureDetector(
                //   child: _xfile != null
                //       ? Container(
                //           width: 100,
                //           height: 100,
                //           decoration: BoxDecoration(
                //               border: Border.all(color: Colors.blue)),
                //           child: kIsWeb
                //               ? Image.network(_xfile!.path)
                //               : Image.file(File(_xfile!.path)))
                //       : widget._contactController.contactModel?.photo == null
                //           ? Container(
                //               width: 100,
                //               height: 100,
                //               decoration: BoxDecoration(
                //                   border: Border.all(color: Colors.blue)),
                //               child: const Center(
                //                 child:
                //                     Text('Click aqui para buscar uma imagem'),
                //               ),
                //             )
                //           : ClipRRect(
                //               borderRadius: BorderRadius.circular(8.0),
                //               child:
                //                   // _homeController.userModel.photoUrl != null
                //                   //     ?
                //                   Image.network(
                //                 widget._contactController.contactModel!.photo!,
                //                 // loadingBuilder: (_, __, ___) {
                //                 //   return const Center(
                //                 //       child: CircularProgressIndicator());
                //                 // },
                //                 height: 100,
                //                 width: 100,
                //                 errorBuilder: (BuildContext context,
                //                     Object exception, StackTrace? stackTrace) {
                //                   return Container(
                //                     width: 100,
                //                     height: 100,
                //                     decoration: BoxDecoration(
                //                         border: Border.all(color: Colors.blue)),
                //                     child: const Center(
                //                       child: Text('Erro ao buscar esta imagem'),
                //                     ),
                //                   );
                //                 },
                //               ),
                //             ),
                //   onTap: () async {
                //     final XFile? pickedFile =
                //         await _picker.pickImage(source: ImageSource.gallery);

                //     if (pickedFile != null) {
                //       setState(() {
                //         _xfile = pickedFile;
                //       });
                //     }
                //   },
                // ),