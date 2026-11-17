# Flutter Calculator

[![Language: Dart](https://img.shields.io/badge/Language-Dart-0175C2)](https://github.com/kleberandrade/calculadora-flutter/blob/master/pubspec.yaml)
[![Framework: Flutter](https://img.shields.io/badge/Framework-Flutter-02569B)](https://github.com/kleberandrade/calculadora-flutter/blob/master/pubspec.yaml)

Simple Flutter calculator developed as a mobile-programming classroom example.

## Getting started

- Select a Flutter release whose bundled Dart SDK satisfies the manifest constraint, then run the commands below from the repository root.

```sh
flutter pub get
flutter run
```

- If the app depends on Firebase or another external service, configure your own service project using the dependencies and original notes; credentials are not supplied by this guide.

## Recorded requirements

- Dart SDK constraint from [`pubspec.yaml`](https://github.com/kleberandrade/calculadora-flutter/blob/master/pubspec.yaml): `>=2.1.0 <3.0.0`.

## Repository map

- [lib](https://github.com/kleberandrade/calculadora-flutter/tree/master/lib)
- [test](https://github.com/kleberandrade/calculadora-flutter/tree/master/test)
- [android](https://github.com/kleberandrade/calculadora-flutter/tree/master/android)
- [ios](https://github.com/kleberandrade/calculadora-flutter/tree/master/ios)

## Validation status

This update documents the tracked source and project metadata. It does not certify a successful build, device test or compatibility with a current toolchain. Follow any project-specific validation instructions in the original material.

## License and attribution

No standalone repository-wide license file was identified in this review. Preserve the original credits and any component-specific licenses; this documentation update grants no additional rights.

---

## Original project material

# Calculadora

Aplicativo de uma calculadora simples para disciplina de Programação Mobile, criado por Kleber de Oliveira Andrade

Tutorial de criação deste app: http://bit.ly/3amM3EK

<p align="center">
    <img src="https://miro.medium.com/max/1188/1*lmJYUZewi8iDqJxplhsB5A.png" width="250"/>
    <img src="https://miro.medium.com/max/1188/1*wd0_FiEC_XbBAu_FjeUBVA.png" width="250"/>
    <img src="https://miro.medium.com/max/1188/1*28KOKtKidXh0KN3TmVpoCw.png" width="250"/>
</p>

## Como clonar e importar

*   Faça um fork do projeto (precisa ter uma conta no github)
*   Abra o terminal do Visual Studio Code
*   Acesse a pasta onde deseja salvar o aplicativo e digite: git clone *link_do_projeto_no_seu_github* **calculadora**
*   Clique em File --> Open e abra o projeto
*   Não se esqueça de abrir o arquivo pubspec.yaml e salvar (CTRL + S) o arquivo para que os plugins sejam baixados

## Desafio para aula

*   [ ] Trocar a fonte do resultado ([tutorial](https://flutter.dev/docs/cookbook/design/fonts) e [fonte](https://www.dafont.com/pt/calculator.font))
*   [ ] Criar um icone para o aplicativo ([plugin flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [tutorial](https://medium.com/@psyanite/how-to-add-app-launcher-icons-in-flutter-bd92b0e0873a), [gerador de icone](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html))
*   [ ] Criar uma tela de splash ([tutorial](https://morioh.com/p/98894cc3a48d))
*   [ ] Adicionar um botão na AppBar para compartilhar o aplicativo ([IconButton](https://medium.com/@mirmahfuz/playing-with-flutter-appbar-a5362428d13d), [plugin share](https://pub.dev/packages/share))
*   [ ] Criar um [Text](https://api.flutter.dev/flutter/widgets/Text-class.html) em cima do resultado para exibir todas as operações realizadas (10 + 30 + 20 x 10) 

## Licença

    Copyright 2020 Kleber de Oliveira Andrade
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
