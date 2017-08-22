# Outside–in Test Suite

Outside–in test suite for use locally or on [Jenkins](https://jenkins.io) [CI](https://www.thoughtworks.com/continuous-integration) environment. Feel free to improve on what's there, tear it apart or start again.

The suite depends on the following support:

>[..] helps you test web applications by simulating how a real user would interact with your app.
> - https://github.com/teamcapybara/capybara

>[..] a tool for running automated tests written in plain language.
> - https://github.com/cucumber/cucumber-ruby

>[..] browser automation framework and ecosystem.
> - https://github.com/SeleniumHQ/selenium

>[..] a driver for Capybara. It allows you to run your Capybara tests on a headless WebKit browser
> - https://github.com/teampoltergeist/poltergeist

>[..] a headless WebKit scriptable with a JavaScript API.
> - http://phantomjs.org/

## Introduction

The suite allows authors to execute features on a per-project basis. At the time or writing it was aimed at multiple stand alone projects of small to medium size. To illustrate this point the suite includes two projects:

- [features/project-one](./features/project-one): A project, developed previously, with a few 'real-life' features and supporting step defintions. To see how this behaves, please run the following command:

```
$ cucumber.run features/project-one
```

- [features/project-two](./features/project-two) - An example project with one example feature, minus any step defintions. To see how this behaves, please run the following command:

```
$ cucumber.run features/project-two
```

- To run all the projects in series please enter the following command. Please note it's worth making sure that the projects listed in [lib/endpoints.json](./lib/endpoints.json) correspond with those that are listed in the [features](./features) directory.

```
$ cucumber.run
```

During step definition creation authors may find themselves incountering the [Rule of Three](http://blog.adrianbolboaca.ro/2015/02/refactoring-rule-of-three/). To support this the contents of [features/global_definitions](./features/global_definitions) has been added to the scope of each project run, it's been stated via the [cucumber.run](./cucumber.run) file.

## Quick Start

Run the following commands to get started.

```
$ git clone git@github.com:dataday/ruby-test-suite.git ruby-test-suite
$ cd ruby-test-suite
$ brew install phantomjs
$ bundle install
$ cucumber.run features/project-one
```

## Extras

```
$ rubocop # to analyse the code
$ yardoc # to publish documentation
```

A related development to manage feature files across build and test projects also exists. More information can be found via: [dataday/ruby-features-packager](dataday/ruby-features-packager).

## History

Some context to the development process which led to the development of this suite:

- I was developing various public facing PHP applications and modules using s/[Zend framework](https://framework.zend.com)/[PHP Symfony](https://symfony.com)/.
- Outside–in software development, [Behavior Driven Development (BDD)](https://www.agilealliance.org/glossary/bdd), using [cucumber](https://cucumber.io) was core to gathering business requirements, producing [features](https://github.com/cucumber/cucumber/wiki/Gherkin) and validating outcomes.
- Continuous integration practices and automated build, test and release software like s/[Hudson](http://hudson-ci.org)/[Jenkins](https://jenkins.io)/ were used wholesale.

Author: [dataday](http://github.com/dataday)
