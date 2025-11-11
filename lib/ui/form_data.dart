import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/tampil_data.dart';

class FormData extends StatefulWidget {
  const FormData({Key? key}) : super(key: key);

  @override
  State<FormData> createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tahunLahirController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _tahunLahirController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final String nama = _namaController.text.trim();
    final String nim = _nimController.text.trim();
    final int tahunLahir = int.parse(_tahunLahirController.text.trim());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TampilData(
          nama: nama,
          nim: nim,
          tahunLahir: tahunLahir,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _namaController,
                hint: 'Nama',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _nimController,
                hint: 'NIM',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'NIM wajib diisi';
                  }
                  if (value.trim().length < 5) {
                    return 'NIM tidak valid';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _tahunLahirController,
                hint: 'Tahun Lahir',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tahun lahir wajib diisi';
                  }
                  final int? tahun = int.tryParse(value.trim());
                  final int now = DateTime.now().year;
                  if (tahun == null) {
                    return 'Harus berupa angka';
                  }
                  if (tahun < 1900 || tahun > now) {
                    return 'Tahun lahir tidak masuk akal';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}


