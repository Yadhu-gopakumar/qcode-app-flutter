import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrgenerate extends StatefulWidget {
  const Qrgenerate({super.key});

  @override
  State<Qrgenerate> createState() => _QrgenerateState();
}

class _QrgenerateState extends State<Qrgenerate> {
  final TextEditingController tcontroller = TextEditingController();
  // final ScreenshotController scrnshotController = ScreenshotController();
  String _text = 'yadhu';
 

  @override
  void dispose() {
    tcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    generateqr(String Text) {
      setState(() {
        _text = Text;
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Create Qr Code',
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 200),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: QrImage(
                embeddedImageStyle:
                    QrEmbeddedImageStyle(size: const Size(35, 35)),
                embeddedImage: const AssetImage('asset/mount.png'),
                data: _text,
                errorStateBuilder: ((context, error) {
                  return const SnackBar(
                    content: Text('error while generating'),
                  );
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.tealAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextFormField(
                      controller: tcontroller,
                      cursorColor: Colors.tealAccent,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 2),
                          hintText: 'type something to create',
                          hintStyle: TextStyle(color: Colors.grey)),
                      style: const TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                      iconSize: 20,
                      onPressed: () {
                        var text = tcontroller.text;
                        if (text != "") {
                          generateqr(text.toString());
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.tealAccent,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
