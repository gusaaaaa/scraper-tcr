Tribunal de Cuentas: Resoluciones
=================================

Scraper for the website http://www.tcr.gub.uy/resoluciones.php made by [Gustavo Armagno](http://github.com/gusaaaaa/) using [EasyParser](http://github.com/gusaaaaa/easyparser).

Setup
=====

```
bundle install
```

To run
======

To list this week's normatives:

```
bundle exec ruby scraper.rb
```

To list normatives from a specific date until today:

```
bundle exec ruby scraper.rb 01/01/2014
```

(```01/01/2014``` should be replaced with a starting date in the format day/month/year)

To list normatives in a range:

```
bundle exec ruby scraper.rb 01/01/2014 10/04/2014
```


