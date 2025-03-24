import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  XFile? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _uploadImage() async {
    // Chamar seu servidor para obter a assinatura
    final signatureResponse = await http.get(Uri.parse('http://your-server-url/generate-signature'));

    if (signatureResponse.statusCode == 200) {
      final signatureData = jsonDecode(signatureResponse.body);
      final signature = signatureData['signature'];
      final timestamp = signatureData['timestamp'];

      // URL do Cloudinary
      final url = Uri.parse('https://api.cloudinary.com/v1_1/your-cloud-name/image/upload');

      // Preparar o arquivo para upload
      final request = http.MultipartRequest('POST', url)
        ..fields['api_key'] = 'your-api-key'
        ..fields['timestamp'] = timestamp.toString()
        ..fields['signature'] = signature
        ..files.add(await http.MultipartFile.fromPath('file', _image!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Imagem enviada com sucesso!');
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        print('Imagem URL: ${data['url']}');
      } else {
        print('Falha no upload');
      }
    } else {
      print('Erro ao obter a assinatura');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload de Imagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Escolher Imagem'),
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(File(_image!.path), height: 150, fit: BoxFit.cover)
                : Text('Nenhuma imagem selecionada'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Enviar para Cloudinary'),
            ),
          ],
        ),
      ),
    );
  }
}
