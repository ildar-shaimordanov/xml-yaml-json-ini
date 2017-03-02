#!/usr/bin/env perl

=head1 NAME

xc - cross-language converter for any of XML, YAML, JSON and INI formats.

=head1 SYNOPSIS

    jyx OPTIONS

=head1 DESCRIPTION

=head1 OPTIONS

=head1 SEE ALSO

L<JSON>, L<JSON::XS>, L<JSON::PP>

L<YAML::Tiny>

L<XML::Simple>

=head1 COPYRIGHT

Copyright 2017 Ildar Shaimordanov E<lt>F<ildar.shaimordanov@gmail.com>E<gt>

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

# =========================================================================

use XML::Simple;
$XML::Simple::PREFERRED_PARSER = 'XML::Parser';
use YAML::Tiny;
use JSON -support_by_pp;

use Data::Dumper;
use Pod::Usage;

use Getopt::Long;

use strict;
use warnings;

use utf8;

binmode(STDOUT,':utf8');

my $ME = $0;
$ME =~ s/.*[\\\/]//;

# =========================================================================

my %opts;

sub set_format {
	my ( $name, $k, $v ) = ( shift, shift, lc shift );
	die "$ME: Unknown $name: $v\n" 
		unless $v =~ m/^( xml | yaml | json $)/x;
	$opts{$k} = $v;
}

pod2usage unless GetOptions(
	'help|h' => sub {
		pod2usage({ -verbose => 2 });
	}, 

	'from|f|r=s' => sub {
		set_format "reader", @_;
	}, 
	'to|t|w=s' => sub {
		set_format "writer", @_;
	}, 

	'sort' => \$opts{sort}, 
	'indent' => \$opts{indent}, 
	'indent-size=i' => \$opts{indent_size}, 
	'attr-indent' => \$opts{attr_indent}, 
	'skip-empty' => \$opts{skip_empty}, 
	'raw' => \$opts{raw}, 
	'xml-decl:s' => sub {
		$opts{xml_decl} = $_[1] || 1;
	}, 
) 
and defined $opts{from} 
and defined $opts{to} 
;

# =========================================================================

my $in = join "", <>;

# =========================================================================

my $data;

for ( $opts{from} ) {
/xml/ and do {
	$data = XMLin($in, 
		KeepRoot => 1, 
		SuppressEmpty => $opts{skip_empty}, 
	);
	last;
};
/yaml/ and do {
	$data = Load($in);
	last;
};
/json/ and do {
	$data = from_json($in, {
		allow_barekey => $opts{raw}, 
		allow_singlequote => $opts{raw}, 
		relaxed => $opts{raw}, 
	});
	last;
};
}

# =========================================================================

my $out;

for ( $opts{to} ) {
/xml/ and do {
	$out = XMLout($data, 
		KeepRoot => 1, 
		NoSort => ! $opts{sort}, 
		NoIndent => ! $opts{indent}, 
		AttrIndent => $opts{attr_indent}, 
		SuppressEmpty => $opts{skip_empty}, 
		XMLDecl => $opts{xml_decl}, 
	);
	last;
};
/yaml/ and do {
	$out = Dump($data);
	last;
};
/json/ and do {
	$out = to_json($data, {
		pretty => $opts{indent}, 
		indent_length => $opts{indent_size} || 0, 
		canonical => $opts{sort}, 
	});
	last;
};
}

# =========================================================================

print $out;

# =========================================================================

# EOF
