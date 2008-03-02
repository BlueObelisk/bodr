#!/usr/bin/perl
use strict;
use diagnostics;

my @elements;

# Read in the data
&readColors;
&readNamesAndSymbols;
&readAtomicMasses;
&readExactMasses;
&readIonization;
&readElectronAffinity;
&readEthymology;
&readPauling;
&readRadiiCovalent;
&readRadiiVanDerWaals;
&readDatesAndDiscoveres;
&readPeriods;
&readBlocks;
&readElectronicConfiguration;
&readMeltingpoint;
&readBoilingpoint;
&readGroups;
&readFamilies;
&readCountries;
&readDensity;

print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
print "<list id=\"chemicalElement\" convention=\"bodr:elements\"\n";
print "      title=\"properties of the elements\"\n\n";

print "      xmlns=\"http://www.xml-cml.org/schema\" \n";
print "      xmlns:xml=\"http://www.w3.org/XML/1998/namespace\" \n";
print "      xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n";
print "      xmlns:bo=\"http://www.blueobelisk.org/dict/terminology\" \n";
print "      xmlns:boUnits=\"http://www.blueobelisk.org/dict/units\" \n";
print "      xmlns:units=\"http://www.xml-cml.org/units/units\" \n";
print "      xmlns:siUnits=\"http://www.xml-cml.org/units/siUnits\" \n";
print "      xmlns:bibx=\"http://bibtexml.sf.net/\" \n\n";
print "      xsi:schemaLocation=\"http://www.xml-cml.org/schema ../schemas/cml25.xsd\n";
print "                           http://bibtexml.sf.net/       ../schemas/bibtexml.xsd\">\n\n";

print "  <metadataList>\n";
print "    <!-- manually updated -->\n\n";
print "    <metadata name=\"dc:title\" content=\"Blue Obelisk Element Repository\" />\n";
print "    <metadata name=\"dc:creator\" content=\"The Blue Obelisk Movement\" />\n";
print "    <metadata name=\"dc:license\" content=\"The MIT License\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Geoffrey R. Hutchison\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Carsten Niehaus\" />\n";
print "    <metadata name=\"dc:contributor\" content=\"Egon Willighagen\" />\n";
print "    <metadata name=\"dc:description\" content=\"Database of elements and elemental properties (names, symbols, masses, exact masses, van der Waals radii, ionization potential, electron affinity, electronegativity, etc.\" />\n";
print "  </metadataList>\n\n";

# Now write 'em out
my $atomicNum = 0;
for(@elements) {
    print "  <atom id=\"$elements[$atomicNum]{symbol}\">\n";
    print "    <scalar dataType=\"xsd:Integer\" dictRef=\"bo:atomicNumber\">$atomicNum</scalar>\n";

    # symbols and names
    print "    <label dictRef=\"bo:symbol\" value=\"$elements[$atomicNum]{symbol}\" />\n";
    print "    <label dictRef=\"bo:name\" xml:lang=\"en\" value=\"$elements[$atomicNum]{name}\" />\n";

    # masses and exact masses
    if ( exists $elements[$atomicNum]{mass} ) {
        print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:mass\" units=\"units:atmass\"";
        if (exists $elements[$atomicNum]{massError}) {
            print " errorValue=\"$elements[$atomicNum]{massError}\"";
        }
        print ">$elements[$atomicNum]{mass}</scalar>\n";
    }

    if ( exists $elements[$atomicNum]{exactMass} ) {
        print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:exactMass\" units=\"units:atmass\"";
        if (exists $elements[$atomicNum]{exactMassError}) {
            print " errorValue=\"$elements[$atomicNum]{exactMassError}\"";
        }
        print ">$elements[$atomicNum]{exactMass}</scalar>\n";
    }

    #Density
#    if (exists $elements[$atomicNum]{density}){
#	    print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:density\"";
#           if ( $elements[$atomicNum]{aggregation} eq "g") {
#		    print " units=\"g.l-1\"";
#	    }
#	    else{
#		    print " units=\"g.cm-3\"";
#	    }
#
#     print ">$elements[$atomicNum]{density}</scalar>\n";
#    }

    # ionization energies
    if (exists $elements[$atomicNum]{ionization} ) {
	print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:ionization\" units=\"units:ev\">$elements[$atomicNum]{ionization}</scalar>\n";
    }

    # electron affinity
    if (exists $elements[$atomicNum]{affinity} ) {
	print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:electronAffinity\" units=\"units:ev\"";
	if (exists $elements[$atomicNum]{eaError}) {
	    print " errorValue=\"$elements[$atomicNum]{eaError}\"";
	}
	print ">$elements[$atomicNum]{affinity}</scalar>\n";
    }

    # electronegativity (Pauling)
    if (exists $elements[$atomicNum]{pauling} ) {
	print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:electronegativityPauling\" units=\"boUnits:paulingScaleUnit\">$elements[$atomicNum]{pauling}</scalar>\n";
    }

	# ethymology
	if (exists $elements[$atomicNum]{nameOrigin} ) {
		print "    <scalar dataType=\"xsd:string\" dictRef=\"bo:nameOrigin\" xml:lang=\"en\">$elements[$atomicNum]{nameOrigin}</scalar>\n";
	}

    # covalent radii
    if (exists $elements[$atomicNum]{covalent} ) {
	print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:radiusCovalent\" units=\"units:ang\">$elements[$atomicNum]{covalent}</scalar>\n";
    }

    # vdW radii
    if (exists $elements[$atomicNum]{vdw} ) {
	print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:radiusVDW\" units=\"units:ang\">$elements[$atomicNum]{vdw}</scalar>\n";
    }

    # colors
    print "    <array title=\"color\" dictRef=\"bo:elementColor\" size=\"3\" dataType=\"xsd:float\">$elements[$atomicNum]{red} $elements[$atomicNum]{green} $elements[$atomicNum]{blue}</array>\n";

    # Boilingpoint
    if (exists $elements[$atomicNum]{boiling} ) {
        print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:boilingpoint\"  units=\"siUnits:kelvin\">$elements[$atomicNum]{boiling}</scalar>\n";
    }

    # Meltingpoint
    if (exists $elements[$atomicNum]{melting} ) {
        print "    <scalar dataType=\"xsd:float\" dictRef=\"bo:meltingpoint\"  units=\"siUnits:kelvin\">$elements[$atomicNum]{melting}</scalar>\n";
    }

    # Block 
    if (exists $elements[$atomicNum]{block} ) {
        print "    <scalar dataType=\"xsd:string\" dictRef=\"bo:periodTableBlock\">$elements[$atomicNum]{block}</scalar>\n";
    }
    
    # The country where the element has been discovered
    if (exists $elements[$atomicNum]{country} ) {
      print "    <array dataType=\"xsd:string\""; 

      my @count = split(',', $elements[$atomicNum]{country});
      # if there are more than one discoverer-countries. So this scripts has to
      # print the delim=";" size="2" xml as well. The size is the
      # number of names
      if (scalar(@count) > 1){
        print " delimiter=\",\" size=\"". scalar(@count) ."\"";
      }

      print " dictRef=\"bo:discoveryCountry\">$elements[$atomicNum]{country}</array>\n";
    }

    # Discovery 
    if (exists $elements[$atomicNum]{discoveryDate} ) {
        print "    <scalar dataType=\"xsd:date\" dictRef=\"bo:discoveryDate\">$elements[$atomicNum]{discoveryDate}</scalar>\n";
    }
    if (exists $elements[$atomicNum]{discoverers} ) {
        print "    <array dataType=\"xsd:string\"";
		my @count = split(';', $elements[$atomicNum]{discoverers});
		# if there are more than one discoverer. So this scripts has to
		# print the delim=";" size="2" xml as well. The size is the
		# number of names
		if (scalar(@count) > 1){
			print " delimiter=\";\" size=\"". scalar(@count) ."\"";
		}
		
		print " dictRef=\"bo:discoverers\">$elements[$atomicNum]{discoverers}</array>\n";
    }
    
	# Periods
    if (exists $elements[$atomicNum]{period} ) {
        print "    <scalar dataType=\"xsd:int\" dictRef=\"bo:period\">$elements[$atomicNum]{period}</scalar>\n";
    }
	
	# Acidicbehaviour
    if (exists $elements[$atomicNum]{acidicbehaviour} ) {
        print "    <scalar dataType=\"xsd:int\" dictRef=\"bo:acidicbehaviour\">$elements[$atomicNum]{acidicbehaviour}</scalar>\n";
    }
	
	# Group
    if (exists $elements[$atomicNum]{group} ) {
        print "    <scalar dataType=\"xsd:int\" dictRef=\"bo:group\">$elements[$atomicNum]{group}</scalar>\n";
    }
	
	# Electronic configuration
    if (exists $elements[$atomicNum]{electronicConfiguration} ) {
        print "    <scalar dataType=\"xsd:string\" dictRef=\"bo:electronicConfiguration\">$elements[$atomicNum]{electronicConfiguration}</scalar>\n";
    }
	
	# Family
    if (exists $elements[$atomicNum]{family} ) {
        print "    <scalar dataType=\"xsd:string\" dictRef=\"bo:family\">$elements[$atomicNum]{family}</scalar>\n";
    }

    print "  </atom>\n";
    $atomicNum++;
}

print "</list>\n";

exit(0);

sub readColors {
    die "Can't find colors.txt!\n" if (! -e "colors.txt");

    open COLORS, "<colors.txt";
    while (<COLORS>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split; # let's just save the line items
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{red} = shift @line;
	$elements[$atomicNum]{green} = shift @line;
	$elements[$atomicNum]{blue} = shift @line;
    }
    close COLORS;
}

sub readNamesAndSymbols {
    die "Can't find names.txt!\n" if (! -e "names.txt");

    open NAMES, "<names.txt";
    while (<NAMES>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{symbol} = shift @line;
	$elements[$atomicNum]{name} = shift @line;
    }
    close NAMES;
}


sub readAtomicMasses {
    die "Can't find mass.txt!\n" if (! -e "mass.txt");

open MASS, "<mass.txt";
while (<MASS>) {
    chomp;

    next if ($_ =~ m/^#/);
    my @line = split;
    my $atomicNum = shift @line;

    shift @line; # symbol
    $elements[$atomicNum]{mass} = shift @line;
    if (my $massError = shift @line) {
	$elements[$atomicNum]{massError} = $massError;
    }
}
close MASS;
}

sub readExactMasses {
    die "Can't find exact-masses.txt!\n" if (! -e "exact-masses.txt");

    open EXACTMASS, "<exact-masses.txt";
    while (<EXACTMASS>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	shift @line; # most common isotope
	$elements[$atomicNum]{exactMass} = shift @line;
	if (my $massError = shift @line) {
	    $elements[$atomicNum]{exactMassError} = $massError;
	}
    }
    close EXACTMASS;
}

sub readIonization {
    die "Can't find ionization.txt!\n" if (! -e "ionization.txt");

    open IONIZE, "<ionization.txt";
    while (<IONIZE>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	shift @line; # symbol
	$elements[$atomicNum]{ionization} = shift @line;
    }
    close IONIZE;
}

sub readElectronAffinity {
    die "Can't find electron-affinity.txt!\n" if (! -e "electron-affinity.txt");

    open EA, "<electron-affinity.txt";
    while (<EA>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{affinity} = shift @line;
	if (my $eaError = shift @line) {
	    $elements[$atomicNum]{eaError} = $eaError;
	}
    }
    close EA;
}

sub readPauling {
    die "Can't find electroneg-pauling.txt!\n" if (! -e "electroneg-pauling.txt");

    open PAULING, "<electroneg-pauling.txt";
    while (<PAULING>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{pauling} = shift @line;
    }
    close PAULING;
}

sub readEthymology {
	die "Can't find nameorigin.txt!\n" if (! -e "nameorigin.txt");

	open ORIGIN, "<nameorigin.txt";
	while (<ORIGIN>) {
		chomp;

		next if ($_ =~ m/^#/);
		if ($_ =~ m/^(\d*)\s*(.*)/) {
			$elements[$1]{nameOrigin} = $2;
		}
	}
	close ORIGIN;
}

sub readRadiiCovalent {
    die "Can't find radii-covalent.txt!\n" if (! -e "radii-covalent.txt");

    open COVALENT, "<radii-covalent.txt";
    while (<COVALENT>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{covalent} = shift @line;
    }
    close COVALENT;
}

sub readRadiiVanDerWaals {
    die "Can't find radii-vdw.txt!\n" if (! -e "radii-vdw.txt");

    open VDW, "<radii-vdw.txt";
    while (<VDW>) {
	chomp;
	
	next if ($_ =~ m/^#/);
	my @line = split;
	my $atomicNum = shift @line;
	
	$elements[$atomicNum]{vdw} = shift @line;
    }
    close VDW;
}

sub readBoilingpoint{
    die "Can't find boilingpoint.txt!\n" if (! -e "boilingpoint.txt");

    open BOILING, "<boilingpoint.txt";
    while (<BOILING>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{boiling} = shift @line;
    }
    close BOILING;
}

sub readMeltingpoint{
    die "Can't find meltingpoint.txt!\n" if (! -e "meltingpoint.txt");

    open MELTING, "<meltingpoint.txt";
    while (<MELTING>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{melting} = shift @line;
    }
    close MELTING;
}

sub readBlocks{
    die "Can't find blocks.txt!\n" if (! -e "blocks.txt");

    open BLOCKS, "<blocks.txt";
    while (<BLOCKS>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{block} = shift @line;
    }
    close BLOCKS;
}

sub readDatesAndDiscoveres {
    die "Can't find dates.txt!\n" if (! -e "dates.txt");

	open DATES, "<dates.txt";
	while (<DATES>){
		chomp;
		my @data = split(':', $_);

		next if ($_ =~ m/^#/);
		if (scalar(@data) == 2) {
			my $atomicNum = $data[0];
			$elements[$atomicNum]{discoveryDate} = $data[1];
		}
		elsif (scalar(@data) == 3) {
			my $atomicNum = $data[0];
			$elements[$atomicNum]{discoveryDate} = $data[1];
			$elements[$atomicNum]{discoverers} = $data[2];
		}
	}
	close DATES;
}

sub readPeriods{
    die "Can't find periods.txt!\n" if (! -e "periods.txt");

    open PERIODS, "<periods.txt";
    while (<PERIODS>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{period} = shift @line;
    }
    close PERIODS;
}


sub readElectronicConfiguration {
    die "Can't find electronic-configuration.txt!\n" if (! -e "electronic-configuration.txt");

	open ECONF, "<electronic-configuration.txt";
	while (<ECONF>) {
		chomp;

		next if ($_ =~ m/^#/);
		if ($_ =~ m/^(\d*)\s*(.*)/) {
			$elements[$1]{electronicConfiguration} = $2;
		}
	}
	close ECONF;
}

sub readAcidicbehaviour{
    die "Can't find acidicbehaviour.txt!\n" if (! -e "acidicbehaviour.txt");

    open PERIODS, "<acidicbehaviour.txt";
    while (<PERIODS>) {
        chomp;
		
	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{acidicbehaviour} = shift @line;
    }
    close PERIODS;
}
sub readGroups{
    die "Can't find groups.txt!\n" if (! -e "groups.txt");

    open GROUPS, "<groups.txt";
    while (<GROUPS>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{group} = shift @line;
    }
    close GROUPS;
}

sub readFamilies{
    die "Can't find family.txt!\n" if (! -e "family.txt");

    open FAMILIES, "<family.txt";
    while (<FAMILIES>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{family} = shift @line;
    }
    close FAMILIES;
}

sub readDensity{
    die "Can't find density.txt!\n" if (! -e "density.txt");

  open DENSITY, "<density.txt";
  while (<DENSITY>) {
    chomp;

    next if ($_ =~ m/^#/);
    my @line = split;
    my ($atomicNum, $density, $aggr, @restOfLine) = split;

    $elements[$atomicNum]{density} = $density;
    $elements[$atomicNum]{aggregation} = $aggr;
  }
  close DENSITY;
}

sub readCountries{
    die "Can't find discovery_countries.txt!\n" if (! -e "discovery_countries.txt");

    open COUNTRIES, "<discovery_countries.txt";
    while (<COUNTRIES>) {
        chomp;

	next if ($_ =~ m/^#/);
        my @line = split;
        my $atomicNum = shift @line;

        $elements[$atomicNum]{country} = shift @line;
    }
    close COUNTRIES;
}
