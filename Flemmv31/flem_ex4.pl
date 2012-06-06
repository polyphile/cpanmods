#!/usr/bin/env perl

###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1				          #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################

# Input (Brill) : 1 paragraphe par ligne
# Sortie souhait�e : XML

# perl flem_ex4.pl < tests/test_bll_1.input > tests/test_bll_1_4.xml
# perl flem_ex4.pl < tests/agatha.bll > tests/agatha_bll_4.xml

use Flemm;
use Flemm::Result;

my $lemm=new Flemm(
		   "Tagger" => "brill"
		   );

print "<?xml version='1.0' encoding='ISO-8859-1'?>\n\n";
print "<FlemmResults>\n";

while (<>) {
    chomp;
    
    foreach my $ff (split(/ /,$_)) {
	
	my $res = $lemm->lemmatize($ff);
	print $res->asXML."\n";
    }
}

print "</FlemmResults>\n";
