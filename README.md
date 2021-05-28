# xml-yaml-json-ini

cross format converter for any of XML, YAML/YML, JSON and INI formats.

## Dependencies

* [Config::IniFiles](https://metacpan.org/pod/Config::IniFiles)
  * [IO::Scalar from IO-Stringy](https://metacpan.org/pod/IO::Stringy)
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
    xc - cross format converter for any of XML, YAML, JSON and INI formats.

SYNOPSIS
        xc -f FORMAT -t FORMAT [OPTIONS]
        xc -r FORMAT -w FORMAT [OPTIONS]
        xc --from=FORMAT --to=FORMAT [OPTIONS]

DESCRIPTION
    xc is a naive command line tool to convert data between XML, YAML, JSON
    and INI formats.

OPTIONS
    -h, --help
        Outputs this help page.

    -r FORMAT, -f FORMAT, --from=FORMAT
        The mandatory option assumes the input file has the specified
        format.

    -w FORMAT, -t FORMAT, --to=FORMAT
        The mandatory option assumes the output file has the specified
        format.

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
    The following formats are supported:

    INI
    JSON
    XML
    YAML (YML is allowed as shortcut)

SEE ALSO
    JSON, JSON::XS, JSON::PP

    YAML::Tiny

    XML::Simple

    Config::IniFiles

COPYRIGHT
    Copyright 2017, 2020, 2021 Ildar Shaimordanov
    <ildar.shaimordanov@gmail.com>

    This program is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.

```
