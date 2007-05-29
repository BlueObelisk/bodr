#!/usr/bin/perl

# Read in the data
&readColors;
&readNamesAndSymbols;
&readAtomicMasses;
&readExactMasses;
&readIonization;
&readElectronAffinity;
&readPauling;
&readRadiiCovalent;
&readRadiiVanDerWaals;
&readValence;

# Now write 'em out
$atomicNum = 0;
for(@elements) {
    print $atomicNum . "\t";
    print $elements[$atomicNum]{symbol} . "\t";

    if (exists $elements[$atomicNum]{covalent} ) {
	print $elements[$atomicNum]{covalent} . "\t";
    } else {
	print "1.6" . "\t";
    }

    # fake the bond-order radius (otherwise we totally confuse old code)
    if (exists $elements[$atomicNum]{covalent} ) {
	print $elements[$atomicNum]{covalent} . "\t";
    } else {
	print "1.6" . "\t";
    }

    if (exists $elements[$atomicNum]{vdw} ) {
	print $elements[$atomicNum]{vdw} . "\t";
    } else {
	print "2.0" . "\t";
    }
    if (exists $elements[$atomicNum]{valence} ) {
	print $elements[$atomicNum]{valence} . "\t";
    } else {
	print "6" . "\t";
    }
    
    print $elements[$atomicNum]{mass} . "\t";
    
    if (exists $elements[$atomicNum]{pauling} ) {
	print $elements[$atomicNum]{pauling} . "\t";
    } else {
	print "0.0" . "\t";
    }
    
    if (exists $elements[$atomicNum]{ionization} ) {
	print $elements[$atomicNum]{ionization} . "\t";
    } else {
	print "0.0" . "\t";
    }
    
    if (exists $elements[$atomicNum]{affinity} ) {
	print $elements[$atomicNum]{affinity} . "\t";
    } else {
	print "0.0" . "\t";
    }
    
    print $elements[$atomicNum]{red} . "\t";
    print $elements[$atomicNum]{green} . "\t";
    print $elements[$atomicNum]{blue} . "\t";

    print $elements[$atomicNum]{name} . "\n";

    $atomicNum++;
}



sub readColors {
    open COLORS, "colors.txt";
    while (<COLORS>) {
	chomp;
	
	my @line = split; # let's just save the line items
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{red} = shift @line;
	$elements[$atomicNum]{green} = shift @line;
	$elements[$atomicNum]{blue} = shift @line;
    }
    close COLORS;
}

sub readNamesAndSymbols {
    open NAMES, "names.txt";
    while (<NAMES>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{symbol} = shift @line;
	$elements[$atomicNum]{name} = shift @line;
    }
    close NAMES;
}


sub readAtomicMasses {

open MASS, "mass.txt";
while (<MASS>) {
    chomp;

    my @line = split;
    my $atomicNum = shift @line;
    next if ($atomicNum eq "#");

    shift @line; # symbol
    $elements[$atomicNum]{mass} = shift @line;
    if ($massError = shift @line) {
	$elements[$atomicNum]{massError} = $massError;
    }
}
close MASS;
}

sub readExactMasses {
    open EXACTMASS, "exact-masses.txt";
    while (<EXACTMASS>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	shift @line; # most common isotope
	$elements[$atomicNum]{exactMass} = shift @line;
	if ($massError = shift @line) {
	    $elements[$atomicNum]{exactMassError} = $massError;
	}
    }
    close EXACTMASS;
}

sub readIonization {
    open IONIZE, "ionization.txt";
    while (<IONIZE>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	shift @line; # symbol
	$elements[$atomicNum]{ionization} = shift @line;
    }
    close IONIZE;
}

sub readElectronAffinity {
    open EA, "electron-affinity.txt";
    while (<EA>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{affinity} = shift @line;
	if ($eaError = shift @line) {
	    $elements[$atomicNum]{eaError} = $eaError;
	}
    }
    close EA;
}

sub readPauling {
    open PAULING, "electroneg-pauling.txt";
    while (<PAULING>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{pauling} = shift @line;
    }
    close PAULING;
}

sub readRadiiCovalent {
    open COVALENT, "radii-covalent.txt";
    while (<COVALENT>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{covalent} = shift @line;
    }
    close COVALENT;
}

sub readRadiiVanDerWaals {
    open VDW, "radii-vdw.txt";
    while (<VDW>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{vdw} = shift @line;
    }
    close VDW;
}

sub readValence {
    open VALENCE, "valence.txt";
    while (<VALENCE>) {
	chomp;
	
	my @line = split;
	my $atomicNum = shift @line;
	next if ($atomicNum eq "#");
	
	$elements[$atomicNum]{valence} = shift @line;
    }
    close VALENCE;
}

