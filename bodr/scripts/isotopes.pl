#!/usr/bin/perl

# set up abundances first
open ABUNDANCE, "abundances.txt";
while (<ABUNDANCE>) {
    chomp;

    my @line = split; # let's just save the line items
    my $symbol = shift @line;
    next if ($symbol eq "#");

    my $isotope = shift @line;
    my $percent = shift @line;

    $abundance{$symbol}{$isotope} = $percent;
}
close ABUNDANCE;

#set up spin
open SPIN, "spin.txt";
while (<SPIN>) {
    chomp;
    
    my @line = split; #let's just save the line items
    my $symbol = shift @line;
    next if ($symbol eq "#");
    
    my $isotope = shift @line;
    my $spinparity = shift @line;
    
    $spin{$symbol}{$isotope} = $spinparity;
}
close SPIN;

#set up magnetic moment
open MAGMOMENT, "magmoment.txt";
while (<MAGMOMENT>) {
    chomp;
    
    my @line = split; #let's just save the line items
    my $symbol = shift @line;
    next if ($symbol eq "#");
    
    my $isotope = shift @line;
    my $moment = shift @line;
    
    $magmoment{$symbol}{$isotope} = $moment;
}
close HALFLIFE;

#set up halflife
open HALFLIFE, "halflife.txt";
while (<HALFLIFE>) {
    chomp;
    
    my @line = split; #let's just save the line items
    my $symbol = shift @line;
    next if ($symbol eq "#");
    
    my $isotope = shift @line;
    my $halflifeformat = shift @line;
    if ($halflifeformat eq "years"){
	$halflifeformat = "units:y"; }
	else {
	$halflifeformat = "siUnits:s";
}


    my $halflife = shift @line;
    
    $hlformat{$symbol}{$isotope} = $halflifeformat;
    $hl{$symbol}{$isotope} = $halflife
}
close HALFLIFE;

#set up decay
open DECAY, "decay.txt";
while (<DECAY>) {
    chomp;
    my @line = split "\t",$_; #let's just save the line items
    my $symbol = shift @line;


        next if ($symbol =~/^#/);    # only lines starting with # are to be removed


        my $isotope = (shift @line) + (shift @line);


     foreach my $pre (('alpha', 'betaplus', 'betaminus', 'ec')){    # the array to be created and filled
            foreach my $sur (('perc', 'dec')){
                ${$pre.$sur}{$symbol}{$isotope} = shift @line || undef;    # if empty field is in @line, set to undef
            }
        }

}
close DECAY;

# now read isotopes
open ISOTOPES, "isotopes.txt";

print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
print "<cml xmlns=\"http://www.xml-cml.org/schema\" convention=\"bodr:isotopes\"\n";
print "     xmlns:xml=\"http://www.w3.org/XML/1998/namespace\" \n";
print "     xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n";
print "     xmlns:bo=\"http://www.blueobelisk.org/dict/terminology\" \n";
print "     xmlns:boUnits=\"http://www.blueobelisk.org/dict/units\" \n";
print "     xmlns:units=\"http://www.xml-cml.org/units/units\" \n";
print "     xmlns:isUnits=\"http://www.xml-cml.org/units/siUnits\" \n";
print "     xmlns:bibx=\"http://bibtexml.sf.net/\" \n\n";
print "     xsi:schemaLocation=\"http://www.xml-cml.org/schema ../schemas/cml25.xsd\n";
print "                         http://bibtexml.sf.net/       ../schemas/bibtexml.xsd\"\n";
print "      id=\"isotopes\" \n";
print "      title=\"properties of the isotopes\">\n\n";
print "  <metadataList>\n";
print "    <!-- manually updated -->\n\n";
print "    <metadata name=\"dc:title\" content=\"Blue Obelisk Element Repository\" />\n";
print "    <metadata name=\"dc:creator\" content=\"The Blue Obelisk Movement\" />\n";
print "    <metadata name=\"dc:license\" content=\"The MIT License\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Geoffrey R. Hutchison\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Carsten Niehaus\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Egon Willighagen\" />\n";
print "	   <metadata name=\"dc:contributor\" content=\"Jörg Buchwald\" />\n";
print "	   <metadata name=\"dc:contributor\" content=\"Martin Pfeiffer\" />\n";
print "    <metadata name=\"dc:description\" content=\"Database of isotopes and isotopic properties (names, symbols, exact masses, spin, abundances, magnetic dipole moment, decay energy, etc)\" />\n";
print "  </metadataList>\n\n";

while (<ISOTOPES>) {
    chomp;

    my @line = split; # let's just save the line items
    my $symbol = shift @line;
    next if ($symbol eq "#");
    next if ($symbol eq "Xx");

    my $atomicNum = shift @line;
    
    print "<isotopeList id=\"$symbol\">\n";

    while ($isotope = shift @line) {
	$exactMass = shift @line;
	$error = shift @line;
	
	print "\t<isotope id=\"$symbol$isotope\" number=\"$isotope\" elementType=\"$symbol\">\n";

	if (exists $abundance{$symbol} && $abundance{$symbol}{$isotope}) {
	    print "\t\t<scalar dictRef=\"bo:relativeAbundance\">$abundance{$symbol}{$isotope}</scalar>\n";
	}

    print "\t\t<scalar dictRef=\"bo:exactMass\" errorValue=\"$error\">$exactMass</scalar>\n";

	if (exists $spin{$symbol} && $spin{$symbol}{$isotope}) {
	    print "\t\t<scalar dictRef=\"bo:spin\">$spin{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $magmoment{$symbol} && $magmoment{$symbol}{$isotope}) {
	    print "\t\t<scalar dictRef=\"bo:magneticMoment\">$magmoment{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $hl{$symbol} && $hl{$symbol}{$isotope}) {
	    print "\t\t<scalar dictRef=\"bo:halfLife\" units=\"$hlformat{$symbol}{$isotope}\">$hl{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $alphaperc{$symbol} && $alphaperc{$symbol}{$isotope}) {
	    print "\t\t<scalar dictRef=\"bo:alphaDecay\">$alphadec{$symbol}{$isotope}</scalar>\n";
        print "\t\t<scalar dictRef=\"bo:alphaDecayLikeliness\" units=\"bo:percentage\">$alphaperc{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $betaplusperc{$symbol} && $betaplusperc{$symbol}{$isotope}) {
        print "\t\t<scalar dictRef=\"bo:betaplusDecay\">$betaplusdec{$symbol}{$isotope}</scalar>\n";
        print "\t\t<scalar dictRef=\"bo:betaplusDecayLikeliness\" units=\"bo:percentage\">$betaplusperc{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $betaminusperc{$symbol} && $betaminusperc{$symbol}{$isotope}) {
        print "\t\t<scalar dictRef=\"bo:betaminusDecay\">$betaminusdec{$symbol}{$isotope}</scalar>\n";
        print "\t\t<scalar dictRef=\"bo:betaminusDecayLikeliness\" units=\"bo:percentage\">$betaminusperc{$symbol}{$isotope}</scalar>\n";
	}
	if (exists $ecperc{$symbol} && $ecperc{$symbol}{$isotope}) {
        print "\t\t<scalar dictRef=\"bo:ecDecay\">$ecdec{$symbol}{$isotope}</scalar>\n";
        print "\t\t<scalar dictRef=\"bo:ecDecayLikeliness\" units=\"bo:percentage\">$ecperc{$symbol}{$isotope}</scalar>\n";
	}
	print "\t\t<scalar dictRef=\"bo:atomicNumber\">$atomicNum</scalar>\n";
	print "\t</isotope>\n";
    }
    print "</isotopeList>\n";
}
close ISOTOPES;

print "</cml>\n";
