#!/usr/bin/perl

use XML::Tidy;

for (@ARGV) {
    my $filename = $_;
    my $tidy_obj = XML::Tidy->new('filename' => $filename);

    # Tidy up the indenting
    $tidy_obj->tidy();

    # Write out changes
    $tidy_obj->write();
}
