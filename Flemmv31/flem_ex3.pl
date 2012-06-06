#!/usr/bin/env perl

###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1				          #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################

# Input (Brill) : 1 paragraphe par ligne
# Sortie souhait�e : plate, 1 paragraphe par ligne


# perl flem_ex3.pl < tests/test_bll_1.input > tests/test_bll_1_3.plat
# perl flem_ex3.pl < tests/agatha.bll > tests/agatha_bll_3.plat

use Flemm;
use Flemm::Result;
 my $lemm=new Flemm(
                'Tagger' => 'Brill'
               );
 
 while (<>) {
    chomp;  

    my $res=$lemm->lemmatize($_);
    print $res->getResult."\n";
       
}



