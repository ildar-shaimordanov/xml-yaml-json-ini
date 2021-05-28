#!/usr/bin/env perl

=head1 NAME

xc - cross format converter for any of XML, YAML, JSON and INI formats.

=head1 SYNOPSIS

    xc -f FORMAT -t FORMAT [OPTIONS]
    xc -r FORMAT -w FORMAT [OPTIONS]
    xc --from=FORMAT --to=FORMAT [OPTIONS]

=head1 DESCRIPTION

xc is a naive command line tool to convert data between XML, YAML, JSON and INI formats.

=head1 OPTIONS

=over 4

=item B<-h>, B<--help>

Outputs this help page.

=item B<-r FORMAT>, B<-f FORMAT>, B<--from=FORMAT>

The mandatory option assumes the input file has the specified format.

=item B<-w FORMAT>, B<-t FORMAT>, B<--to=FORMAT>

The mandatory option assumes the output file has the specified format.

=item B<--sort>

Sort output.

=item B<--indent>

Indent output.

=item B<--indent-size=SIZE>

Indentation size.

=item B<--attr-indent>

Indent XML attributes.

=item B<--skip-empty>

Skip empty fields.

=item B<--raw>

Avoid formatting.

=item B<--xml-decl[=DECL]>

Output XML declaration.

=item B<--default=SECTION>

Specifies a section to be used for default values for parameters outside a section.

=back

=head1 FORMATS

The following formats are supported:

=over 4

=item B<INI>

=item B<JSON>

=item B<XML>

=item B<YAML> (B<YML> is allowed as shortcut)

=back

=head1 SEE ALSO

L<JSON>, L<JSON::XS>, L<JSON::PP>

L<YAML::Tiny>

L<XML::Simple>

L<Config::IniFiles>

=head1 COPYRIGHT

Copyright 2017, 2020, 2021 Ildar Shaimordanov E<lt>F<ildar.shaimordanov@gmail.com>E<gt>

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

# =========================================================================

use strict;
use warnings;

use utf8;

use Pod::Usage;
use Getopt::Long;

use XML::Simple;
$XML::Simple::PREFERRED_PARSER = 'XML::SAX::PurePerl';
#$XML::Simple::PREFERRED_PARSER = 'XML::Parser';

use YAML::Tiny;

use JSON -support_by_pp;

use Config::IniFiles;

use Data::Dumper;
$Data::Dumper::Indent = 1;

binmode(STDOUT, ':utf8');

my $ME = $0;
$ME =~ s/.*[\\\/]//;

# =========================================================================

my %opts;

sub set_format {
	my ( $name, $k, $v ) = ( shift, shift, lc shift );
	die "$ME: Unknown $name: $v\n"
		unless $v =~ m/^( xml | ya?ml | json | ini )$/x;
	$opts{$k} = $v;
}

pod2usage unless GetOptions(
	'help|h' => sub { pod2usage({ -verbose => 2, -noperldoc => 1 }); },

	'from|f|r=s'	=> sub { set_format 'reader', @_; },
	'to|t|w=s'	=> sub { set_format 'writer', @_; },

	'sort'		=> \$opts{sort},
	'indent'	=> \$opts{indent},
	'indent-size=i'	=> \$opts{indent_size},
	'attr-indent'	=> \$opts{attr_indent},
	'skip-empty'	=> \$opts{skip_empty},
	'raw'		=> \$opts{raw},
	'xml-decl:s'	=> sub { $opts{xml_decl} = $_[1] || 1; },
	'default=s'	=> \$opts{default},
) 
and defined $opts{from} 
and defined $opts{to} 
;

# =========================================================================

my $text;
my $data;

# =========================================================================

$text = do { undef $/; <> };

# =========================================================================

for ( $opts{from} ) {
/xml/ and do {
	$data = XMLin($text,
		KeepRoot	=> 1,
		SuppressEmpty	=> $opts{skip_empty},
	);
	last;
};
/ya?ml/ and do {
	$data = Load($text);
	last;
};
/json/ and do {
	$data = from_json($text, {
		allow_barekey	=> $opts{raw},
		allow_singlequote => $opts{raw},
		relaxed		=> $opts{raw},
	});
	last;
};
/ini/ and do {
	tie my %ini, 'Config::IniFiles', (
		-file		=> \$text,
		-default	=> $opts{default},
		-fallback	=> $opts{default},
		-nocase		=> 0,
		-allowcontinue	=> 0,
		-allowempty	=> 0,
		-reloadwarn	=> 0,
		-nomultiline	=> 1,
		-handle_trailing_comment => 0,
	);
	$data = \%ini;
	last;
}
}

# =========================================================================

for ( $opts{to} ) {
/xml/ and do {
	$text = XMLout($data,
		KeepRoot	=> 1,
		NoSort		=> ! $opts{sort},
		NoIndent	=> ! $opts{indent},
		AttrIndent	=> $opts{attr_indent},
		SuppressEmpty	=> $opts{skip_empty},
		XMLDecl		=> $opts{xml_decl},
	);
	last;
};
/ya?ml/ and do {
	$text = Dump($data);
	last;
};
/json/ and do {
	$text = to_json($data, {
		pretty		=> $opts{indent},
		indent_length	=> $opts{indent_size} || 2,
		canonical	=> $opts{sort},
	});
	last;
};
/ini/ and do {
	tie my %ini, 'Config::IniFiles', (
		-default	=> $opts{default},
		-fallback	=> $opts{default},
		-nocase		=> 0,
		-allowcontinue	=> 0,
		-allowempty	=> 0,
		-reloadwarn	=> 0,
		-nomultiline	=> 1,
		-handle_trailing_comment => 0,
	);
	%ini = %{ $data };
	tied( %ini )->OutputConfig();
	last;
}
}

# =========================================================================

print $text unless $opts{to} eq 'ini';

# =========================================================================

# EOF
