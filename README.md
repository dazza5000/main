# main

This is the repo where we bring all the modules together into one app.

https://getcouragenow.org/

## Developer setup

You need to make sure you have all the dependencies setup first.

The [bootstrap](https://github.com/winwisely99/bootstrap) repo is for boot strapping your laptop.

Run the examples using the Makefile to ensure you have an environment that works.

## Working on an issue

The [roadmap](https://github.com/winwisely99/main/projects/1) should be looked at to work out what to work on.

Is you want to work on an issue, please first ensure that you understand the issue and the suggested approach .

When you take an issue, please assign yourself to it and et everyone know on the Telegram group called "winwisely-dev", so we everyone knows your taking it.

## Builds

Use the Makefiles and keep them working.

If you followed the Developer setup these make files will work on Windows, Mac and Linux.

If they do not work for you then raise an issue so that the bootstrap or Makefile can be fixed for everyone benefit.

## CI and CD

There is no CI / CD yet, but soon there will be.

For now just upload them here: https://drive.google.com/drive/folders/11R71oZGZiHWoYmex7jeSowZFcDxvxX5i



## Code generation

We make heavy use of code generation.

The grpc - protobuf parts of both client and server are heavy inspired by
https://github.com/amsokol/flutter-grpc-tutorial


## Docs

Functional Documentation for each module are here:
https://drive.google.com/drive/folders/1F2orl3P46MwAct9kyWSO8550Wn2es8RH

Its worth reading this to get an idea of what the system is intended to do.

## Plugins

This project is designed to run on Desktops and Mobiles.

This means that plugins must work on both and so when choosing a plugin we careful.

All plugins that use native code should live here.
https://github.com/winwisely99/plugins


## FAQ

If your curious about why this project exists or how to get involved, please see the following the [FAQ](FAQ.md)

## UAT ( User Acceptance Testing )

For those helping to test the apps please follow the [UAT Guidelines](UAT.md)

## Pair Programming

For those using VSCode this is an excellent way to code together:
https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare-pack

## Contributing

Please follow the [Contributing Guidelines](CONTRIBUTING.md)

## Code of Conduct

This project adheres to the Contributor Covenant code of conduct.

Please see the following the [Code of Conduct Guidelines](CODE_OF_CONDUCT.md)

By participating, you are expected to uphold this code.

---

Please report unacceptable behavior to winwisely99@gmail.com

## License

This project is open source software licensed under the [Apache LICENSE](LICENSE).
