# xml-yaml-json-ini

cross-language converter for any of XML, YAML/YML, JSON and INI formats.

## Dependencies

* [Config::IniFiles](https://metacpan.org/pod/Config::IniFiles)
* [JSON](https://metacpan.org/pod/JSON)
* [XML::Simple](https://metacpan.org/pod/XML::Simple)
  * [XML::SAX](https://metacpan.org/pod/XML::SAX)
  * [XML::SAX::Base](https://metacpan.org/pod/XML::SAX::Base)
  * [XML::NamespaceSupport](https://metacpan.org/pod/XML::NamespaceSupport)
* [YAML::Tiny](https://metacpan.org/pod/YAML::Tiny)

## Presetting

`XML/SAX/ParserDetails.ini` is required (this example was found within `XML::SAX` itself):

```
[XML::SAX::PurePerl]
http://xml.org/sax/features/namespaces = 1
http://xml.org/sax/features/validation = 0
```

## Usage

```
NAME
    xc - cross-language converter for any of XML, YAML, JSON and INI
    formats.

SYNOPSIS
        xc OPTIONS

DESCRIPTION
    xc is a command line tool to convert data between XML, YAML, JSON and
    INI formats.

OPTIONS
    --help, -h
        Outputs this help page.

    --from=FORMAT, -f FORMAT, -r FORMAT
        Assumes the input file has the specified format.

    --to=FORMAT, -t FORMAT, -w FORMAT
        Assumes the output file has the specified format.

    --sort
        Sort output.

    --indent
        Indent output.

    --indent-size=SIZE
        Indentation size.

    --attr-indent
        Indent XML attributes.

    --skip-empty
        Skip empty fields.

    --raw
        Avoid formatting.

    --xml-decl[=DECL]
        Output XML declaration.

    --default=SECTION
        Specifies a section to be used for default values for parameters
        outside a section.

FORMATS
    ini
    json
    xml
    yaml, yml

SEE ALSO
    JSON, JSON::XS, JSON::PP

    YAML::Tiny

    XML::Simple

    Config::IniFiles

COPYRIGHT
    Copyright 2017, 2020 Ildar Shaimordanov <ildar.shaimordanov@gmail.com>

    This program is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.
```
