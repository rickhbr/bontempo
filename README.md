[![Codemagic build status](https://api.codemagic.io/apps/5e95b1150fc3d46383863b7b/5e95b1150fc3d46383863b7a/status_badge.svg)](https://codemagic.io/apps/5e95b1150fc3d46383863b7b/5e95b1150fc3d46383863b7a/latest_build)
# Bontempo

## Tabela de conteúdos
- [Flutter](#flutter)
    - [Instalação no Windows](#instalacao-no-windows)
    - [Instalação no macOS](#instalacao-no-macos)
- [Debugando o app](#debugando-o-app)
- [Enviando para as lojas](#enviando-para-as-lojas)
    - [Deploy Automático](#deploy-automatico)
    - [Deploy Manual Android](#deploy-manual-android)

## Flutter

O App da Bontempo é desenvolvido em [Flutter](https://flutter.dev/) e é necessário instalar e configurá-lo em seu sistema operacional.

### Instalação no Windows
Baixe o [Flutter para Windows](https://flutter.dev/docs/get-started/install/windows), descompacte a pasta flutter diretamente na pasta `C:\`. Em seguida adicione o caminho `C:\flutter\bin` aos Paths das suas variáveis de ambiente. Agora abra o terminal e digite:

```bash
flutter doctor
```

Resolva as pendências apontadas quanto a Licenças e Plugins do VSCode.

### Instalação no macOS
Baixe o [Flutter para macOS](https://flutter.dev/docs/get-started/install/macos), descompacte a pasta flutter no diretório de sua preferência. Em seguida adicione o PATH para a pasta `flutter\bin` no seu bash. Para isso, edite o arquivo `$HOME/.bashrc` e adicione a seguinte linha ao final deste arquivo, substituindo pelo devido caminho.

```bash
export PATH="$PATH:[CAMINHO_DO_DIRETORIO_ONDE_FOI_EXTRAIDO_O_FLUTTER]/flutter/bin"
```

Após salvar, feche o arquivo e execute:

```bash
source $HOME/.bashrc
```

Agora execute o comando a seguir para conferir se o flutter foi instalado corretamente:

```bash
flutter doctor
```

Resolva as pendências apontadas quanto a Plugins do VSCode.


## Debugando o app

Clone o repositório e execute o seguinte comando para baixar os pacotes de dependência do projeto:

```bash
flutter packages get
```

Caso você tenha instalado as extensões do flutter para VSCode, ao abrir o projeto uma janela se abrirá no canto inferior direito pedindo para executar esse mesmo comando. Outra forma de fazer o mesmo, é clicando com o botão direito sobre o arquivo `pubspec.yaml` e selecionando a opção *Get Packages*

Agora para rodar o app basta abrir qualquer arquivo com a extensão`.dart` e dar um `crtl+f5` com um dispositivo Android conectado. Ao salvar qualquer arquivo, o app fará hotreload, porém algumas alterações talvez precisem que o app seja reiniciado. Para reiniciá-lo de maneira rápida basta apertar `crtl+shift+f5`.

Para instalar uma versão de *release*(produção) ou de *profile* diretamente em um dispositivo, conecte-o ao seu computador e execute o seguinte comando:

```bash
flutter run --release
```


## Enviando para as lojas

Para fazer o deploy do app, você precisa invariavlemente incrementar a versão do app no arquivo `pubspec.yaml` na linha 14. A versão deve ser sempre seguida de um `+` com a versão incremental de compilação como por exemplo: `0.1.0+3`. No caso de lançarmos uma nova versão, deveremos alterar para `0.1.1+4`, `0.2.0+4` ou `1.0.0+4`.

### Deploy automático

Este repositório está vinculado com o [Codemagic](https://codemagic.io) que está configurado já com as chaves da Play Store e os certificados necessários para a App Store. O Codemagic está configurado para efetuar o deploy quando uma nova tag de release for enviada para o **branch master**, demarcando uma versão estável de release para o app. Para efetuar o release, mergeie a versão desejada do app no **branch master** e crie uma nova tag com o seguinte comando, substituindo o numero da versao pela mesma informada no `pubspec.yaml`:

```bash
git tag v0.1.0
```

Após a criação da tag, envie-a ao repositório, dando início ao processo de deploy que pode ser acompanhado no painel do Codemagic.

```bash
git push origin v0.1.0
```

Um ícone aparecerá ao lado do último commit junto com a tag marcando a versão da nova release. Este ícone dará informações sobre o status do deploy.
O deploy está configurado para subir o app como **Teste Interno** na Play Store. Então será necessário acessar o console da play store para enviá-lo para produção manualmente após os devidos testes. Já na App Store, será necessário criar a versão manualmente e selecionar a build correspondente.

Caso o deploy falhe, remova a tag criada, faça os devidos fixes e repita os passos acima:

```bash
git push --delete origin v0.1.0
git tag -d v0.1.0
```

### Deploy manual Android

**App Bundle** (recomendado):

Execute o seguinte comando:

```bash
flutter build appbundle
```

Após todo processo de build, se tudo ocorreu corretamente será gerado o bundle em `/build/app/outputs/bundle/release/app.aab`. Suba este arquivo na Play Store fazendo todo processo normal de publicação.

**APK divida por ABIs**

Este processo gera duas APK's com tamanho reduzido para dois tipos de dispositivos Android.

```bash
flutter build apk --split-per-abi
```

Após todo processo de build, se tudo ocorreu corretamente serão geradas duas apks em `/build/app/outputs/apk/release/app-arm64-v8a-release.apk` e `/build/app/outputs/apk/release/app-armeabi-v7a-release.apk`. Suba estes dois arquivo na Play Store fazendo todo processo normal de publicação.

**APK**

Para gerar uma APK universal, rode o seguinte comando:
*De preferência ao métodos anteriores para publicação na loja para otimização. A APK universal costuma ser muito mais pesada.*

```bash
flutter build apk
```

Após todo processo de build, se tudo ocorreu corretamente será gerada a apk em `/build/app/outputs/apk/release/app-release.apk`. Suba este arquivo na Play Store fazendo todo processo normal de publicação.