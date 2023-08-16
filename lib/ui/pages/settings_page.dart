import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oauth2example/helpers/engine.dart';
import 'package:oauth2example/helpers/env.dart';
import 'package:oauth2example/helpers/utils.dart';
import 'package:oauth2example/model/config_model.dart';
import 'package:oauth2example/services/get_storage_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _viewSecret = true;
  var _viewClientID = true;

  TextEditingController clientIdController = TextEditingController();
  TextEditingController discoverURLController = TextEditingController();
  TextEditingController clientSecretController = TextEditingController();
  TextEditingController userInfoURLController = TextEditingController();

  final configData = GetStorageHelper.getConfiguration();

  @override
  Widget build(BuildContext context) {
    if (clientIdController.text == "") {
      clientIdController.text = configData?.clientId ?? '';
    }
    if (clientSecretController.text == "") {
      clientSecretController.text = configData?.clientSecret ?? '';
    }
    if (userInfoURLController.text == "") {
      userInfoURLController.text = (configData?.userInfoEndpoint ?? '') == ""
          ? Env.USERINFO_ENDPOINT
          : configData?.userInfoEndpoint ?? '';
    }
    if (discoverURLController.text == "") {
      discoverURLController.text = (configData?.discoverURL ?? '') == ""
          ? Env.DISCOVER_URL
          : configData?.discoverURL ?? '';
    }
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.purple.shade100)),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: const Text(
                'Read this Helper 👇',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tilePadding: const EdgeInsets.only(left: 8),
              backgroundColor: Colors.purple.withOpacity(.05),
              shape: Border.all(
                style: BorderStyle.none,
              ),
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(
                          text: 'Este DEMO utiliza a plataforma ',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: 'AUTENTIKA.GOV.CV',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple.shade900)),
                            const TextSpan(
                                text:
                                    ' como o exemplo, no entanto, pode-se utilizar qualquer outra plataforma, que utiliza o mesmo padrão de autorização e autenticação ('),
                            const TextSpan(
                                text: 'OAuth 2.0',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(text: ').'),
                            const TextSpan(text: '\n\n'),
                            TextSpan(
                                text: 'IMPORTANTE:\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple.shade900)),
                            const TextSpan(text: 'Registar o seguinte '),
                            const TextSpan(
                                text: 'redirect_uri',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(
                                text:
                                    ' na plataforma Auth0 e no caso da AUTENTIKA.GOV.CV, enviar esta informa ao gestor da plataforma:'),
                            TextSpan(
                                text: '\n\n${Env.REDIRECT_URL}\n',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                onEnter: (event) {
                                  Utils.logger.i(event);
                                }),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      child: IconButton.filledTonal(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.grey.withOpacity(.1))),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: Env.REDIRECT_URL));
                            Engine.showSnackbar(context,
                                message: 'REDIRECT_URI copied to clipboard.');
                          },
                          icon: const Icon(Icons.copy)),
                    )
                  ],
                ),
              ],
            ),
          ),
          TextField(
              controller: clientIdController,
              obscureText: _viewClientID,
              decoration: InputDecoration(
                labelText: "Client ID", //babel text
                hintText: "Enter Client ID Configuration", //hint text
                suffix: GestureDetector(
                    child: Icon(_viewClientID
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onTap: () => setState(() {
                          _viewClientID = !_viewClientID;
                        })),
                hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400), //hint text style
                labelStyle: const TextStyle(
                    fontSize: 13, color: Colors.deepPurpleAccent), //label style
              )),

          const SizedBox(height: 20), //space between text field

          TextField(
            controller: clientSecretController,
            obscureText: _viewSecret,
            decoration: InputDecoration(
              suffix: GestureDetector(
                  child: Icon(
                      _viewSecret ? Icons.visibility : Icons.visibility_off),
                  onTap: () => setState(() {
                        _viewSecret = !_viewSecret;
                      })),
              labelText: "Client Secret",
              hintText: "Enter Client Secret Configuration",
              hintStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              labelStyle:
                  const TextStyle(fontSize: 13, color: Colors.deepPurpleAccent),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
              controller: discoverURLController,
              decoration: const InputDecoration(
                labelText: "Discover URL", //babel text
                hintText: "Enter Discover URL Configuration", //hint text
                hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400), //hint text style
                labelStyle: TextStyle(
                    fontSize: 13, color: Colors.deepPurpleAccent), //label style
              )),

          const SizedBox(height: 20),

          TextField(
              controller: userInfoURLController,
              decoration: const InputDecoration(
                labelText: "UserInfo Endpoint", //babel text
                hintText: "Enter UserInfo Endpoint Configuration", //hint text
                hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400), //hint text style
                labelStyle: TextStyle(
                    fontSize: 13, color: Colors.deepPurpleAccent), //label style
              )),

          const SizedBox(height: 40),
          SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.purple.shade50),
                  iconColor: MaterialStatePropertyAll(Colors.purple.shade900),
                  foregroundColor:
                      MaterialStatePropertyAll(Colors.purple.shade900),
                  overlayColor:
                      MaterialStatePropertyAll(Colors.purple.shade100)),
              onPressed: () async {
                GetStorageHelper.addConfiguration(
                    configuration: ConfigModel(
                        clientId: clientIdController.text,
                        clientSecret: clientSecretController.text,
                        discoverURL: discoverURLController.text,
                        userInfoEndpoint: userInfoURLController.text));

                Engine.showSnackbar(context,
                    message: 'OAuth 2.0 Configuration Saved.');
              },
              icon: const Icon(Icons.save_sharp),
              label: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
