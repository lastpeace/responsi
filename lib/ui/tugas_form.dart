import 'package:flutter/material.dart';
import 'package:responsi/bloc/tugas_bloc.dart';
import 'package:responsi/model/tugas.dart';
import 'package:responsi/ui/tugas_page.dart';

class TugasForm extends StatefulWidget {
  final Tugas? tugas;

  const TugasForm({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasFormState createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TUGAS";
  String tombolSubmit = "SIMPAN";

  final _kodeTugasTextboxController = TextEditingController();
  final _namaTugasTextboxController = TextEditingController();
  final _deadlineTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.tugas != null) {
      setState(() {
        judul = "UBAH TUGAS";
        tombolSubmit = "UBAH";
        _kodeTugasTextboxController.text = widget.tugas!.title!;
        _namaTugasTextboxController.text = widget.tugas!.description!;
        _deadlineTextboxController.text = widget.tugas!.deadline.toString();
      });
    } else {
      judul = "TAMBAH TUGAS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeTugasTextField(),
                _namaTugasTextField(),
                _deadlineTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Tugas"),
      keyboardType: TextInputType.text,
      controller: _kodeTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Tugas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Tugas"),
      keyboardType: TextInputType.text,
      controller: _namaTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Tugas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deadlineTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.text,
      controller: _deadlineTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deadline harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.tugas != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Tugas createTugas = Tugas(id: null);
    createTugas.title = _kodeTugasTextboxController.text;
    createTugas.description = _namaTugasTextboxController.text;
    createTugas.deadline = _deadlineTextboxController.text;
    TugasBloc.addTugas(tugas: createTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: const Text("Simpan gagal, silahkan coba lagi"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Tugas updateTugas = Tugas(id: widget.tugas!.id);
    updateTugas.title = _kodeTugasTextboxController.text;
    updateTugas.description = _namaTugasTextboxController.text;
    updateTugas.deadline = _deadlineTextboxController.text;
    TugasBloc.updateTugas(tugas: updateTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TugasPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: const Text("Permintaan ubah data gagal, silahkan coba lagi"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
