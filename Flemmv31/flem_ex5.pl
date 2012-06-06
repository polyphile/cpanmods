#!/usr/bin/env perl

###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1				          #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################

# Input (Treetagger) : 1 occurrence �tiquet�e par ligne
# Sortie souhait�e : plate
# Logfile 

# perl flem_ex5.pl < tests/test_tt_1.input > tests/test_tt_15.plat 
# perl flem_ex5.pl < tests/pls.tt > tests/pls_5.plat

use Flemm;
use Flemm::Result;

my $lemm=new Flemm(
		   "Tagger" => "Treetagger",
		   "Logname" => "/tmp/log_errors"
		   );

while (<>) {
    chomp;
    
    my $res = $lemm->lemmatize($_);
    print $res->getResult."\n";
    
}


