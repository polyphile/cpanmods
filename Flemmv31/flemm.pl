#!/usr/bin/env perl

###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du français à partir de # 
# corpus étiquetés - Version 3.1                                          #
# Copyright (C) 2004 (NAMER Fiammetta)                                    #
###########################################################################

# Programme d'initialisation du lemmatiseur
# Appelle le programme de preparation qui va:
# - appeller le lemmatiseur,
# - formater le contenu selon les notations de l'utilisateur

use lib 'lib';
use strict;
use warnings;
use utf8;

# Pour utiliser les options dans la commande perl
use Getopt::Long;

use Flemm;
use Flemm::Result;

use constant PROGRESS_CHAR => '|';
use constant PROGRESS_PACKET => 1000;
use constant PROGRESS_MAX_WIDTH => 80;

sub usage {
    my ($message)=@_;
    
    print STDERR "
Usage: perl flemm.pl       --entree fichier_en_entree
                          [--sortie fichier_en_sortie]
                          [--log]
                          [--logname prefixe_fichiers_log]
                          [--progess]
                          [--format (normal|xml)]
                          [--tagger (brill|treetagger)]
                          [--enc (utf8|ISO-8859-1|...)]

Les arguments notes entre [] sont optionnels.

Par defaut:

- en l'absence de --sortie, le résultat est affiche dans le
  fichier_en_entree.lemm

- en l'absence de --log, pas de fichier contenant la 
  correction des (eventuelles) erreurs d'etiquetage

- en l'absence de --tagger, l'etiqueteur par defaut est 
  \"treetagger\"
  
- en l'absence de --enc, l'encoding par defaut est \"utf8\".\n\n"; 

    print STDERR "$message\n\n" if (defined $message);

    exit(1);
}

# Programme principal

sub main {
    my ($infile,$outfile,$logprefix,$tagger,$format,$log,$encoding);
    my %params;
    my $lemm;
    my $progress;
    my $compteur=0;
    my $char_compteur=0;

    $|=1;

    GetOptions
        (
         "entree=s" => \$infile,    # nom du fichier d'entrée
         "sortie:s" => \$outfile,   # nom du fichier de sortie
         "logname:s" => \$logprefix,# prefixe des fichiers log
         "log!"   => \$log,         # 0 ou 1 (--log ou --nolog)
         "tagger:s" => \$tagger,    # Tagger utilisé (brill|treetagger)
         "format:s" => \$format,    # Format utilisé (normal|xml)
         "progress!" => \$progress, # Pour afficher ou non la progression 
         "enc=s"    => \$encoding     # Quelque nom recognisé par Encode::Supported
         );     
    
    if (!defined $infile) {
        &usage("L'option --entree est obligatoire");
    }

    if (defined $tagger) {
        $params{Tagger}=$tagger;
    }

    if ($log) {
        if (defined $logprefix) {
            $params{Logname}=$logprefix;
        }
        else {
            $params{Logname}=$infile;
        }
    }
    
	$encoding ||= 'utf8';
    $params{Encoding}=$encoding;

    $lemm=new Flemm(%params);
        
    if (!defined $outfile) {
        $outfile = $infile.".lemm";
    } 

    open(INPUT,"$infile") || die "pas possible d'ouvrir $infile";
    open(OUTPUT,">$outfile") || die "pas possible de créer $outfile";
    binmode( INPUT, ":encoding($encoding)" );
    binmode OUTPUT, ":encoding($encoding)";
 
    if ($format && $format eq "xml") {
    	my $xmlenc = $encoding eq 'utf8' ? 'utf-8' : $encoding;
        print OUTPUT "<?xml version='1.0' encoding='$xmlenc'?>\n\n";
        print OUTPUT "<FlemmResults>\n";
    }

    while (<INPUT>) {   

        chomp;
        
        my $res=$lemm->lemmatize($_);

        if ($progress) {
            $compteur++;
            if (($compteur % PROGRESS_PACKET)==0) {
                print PROGRESS_CHAR;
                $char_compteur++;
                if (($char_compteur % PROGRESS_MAX_WIDTH)==0) {
                    $char_compteur=0;
                    print "\n"; 
                    print $res->asXML;
                    print $res->getResult."\n";
                }
            } 
        }

        if ($format && $format eq "xml") {
            print OUTPUT $res->asXML."\n";
        }
        else {
            print OUTPUT $res->getResult."\n";
        }
    }

    if ($format && $format eq "xml") {
        print OUTPUT "</FlemmResults>\n";
    }

    if ($progress && $char_compteur!=0) {
        print "\n";
    }

    close(INPUT);
    close(OUTPUT);

    exit(0);
}

&main;
