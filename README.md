# xml-yaml-json-ini

cross-language converter for any of XML, YAML, JSON and INI formats.

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

    --sort    Sort output.

    --indent  Indent output.

    --indent-size=SIZE
              Indentation size.

    --attr-indent
              Indent XML attributes.

    --skip-empty
              Skip empty fields.

    --raw     Avoid formatting.

    --xml-decl[=DECL]
              Output XML declaration.

SEE ALSO
    JSON, JSON::XS, JSON::PP

    YAML::Tiny

    XML::Simple

COPYRIGHT
    Copyright 2017 Ildar Shaimordanov <ildar.shaimordanov@gmail.com>

    This program is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.

```
