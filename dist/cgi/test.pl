#!/usr/bin/perl -w
## Programmer : Nathan A. Mourey II <nmoureyii@ne.rr.com>
## Date       : 4-2-2010
##

use CGI;

$q = new CGI;

print $q->header();
print $q->start_html(	-title => "Using the CGI module in Perl.",
			-BGCOLOR => 'blue');

print	$q->center( $q->h3("Perl CGI Test.") );

## End the html document.
print $q->end_html;
