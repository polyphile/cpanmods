###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1					  #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################
#
# $Id$
#

package Flemm;

use strict;

use Flemm::Brill;
use Flemm::TreeTagger;

#
# M�thodes publiques
#

# Constructeur
# Renvoie un objet de type Flemm::Brill ou Flemm::TreeTagger
# Lance une exception si le type de Tagger n'est pas pr�cis�
sub new {
    my $type=shift;
    my (%params)=@_;

    my $self=undef;
    my $tagger=undef;
    my %p;

    if (exists $params{Logname}) {
	$p{Logname}=$params{Logname};
    }
    
    if (exists $params{Format}) {
	$p{Format}=$params{Format};
    }
    
    if (exists $params{Tagger}) {
	$tagger=$params{Tagger};
	if ($tagger =~ /brill/i) {
	    $self=new Flemm::Brill(%p);
	}
	elsif ($tagger =~ /(treetagger|tt)/i) {
	    $self=new Flemm::TreeTagger(%p);
	}
	else {
	    die "Flemm::new(): $tagger n'est pas un �tiqueteur reconnu\n";
	}
    }
    else {
	$self=new Flemm::TreeTagger(%p);
    }
    
    return $self;
}

1;

__END__

=head1 NAME

Flemm - Lemmatisation du fran�ais � partir de corpus �tiquet�s

=head1 SYNOPSIS

=head2 Exemple1 (�tiquetage Brill, sortie lin�aire)

  use Flemm;
  use Flemm::Result;

  my $lemm=new Flemm(
                'Tagger' => 'Brill',
                'Logname' => '/tmp/log_errors'
               );
 

  while (<>) {
    chomp;
    my $res=$lemm->lemmatize($_);
    print $res->getResult;
}

echo 'fabriquera/VCJ:sg'|perl exemple1.pl > result_brill.txt
 
=head2 Exemple2 (�tiquetage Treetagger, sortie xml)

  use Flemm;
  use Flemm::Result;
  my $lemm=new Flemm(
                'Logname' => '/tmp/log_errors'
               );
 
 print "<?xml version='1.0' encoding='ISO-8859-1'?>\n\n";
 print "<FlemmResults>\n";
  while (<>) {
    chomp;
    my $res=$lemm->lemmatize($_);
    print $res->asXML;
 }
 print "</FlemmResults>\n";


echo 'g�n�ralisent	VER:pres	g�n�raliser'|perl exemple2.pl > result_tt.xml
 

=head1 DESCRIPTION

Flemm effectue l'analyse morpho-flexionnelle d'une forme fl�chie �tiquet�e.
Le r�sultat inclut le lemme (forme non fl�chie conventionnellement associ�e
� la forme analys�e) ainsi que l'ensemble des traits flexionnels calculables
hors contexte. 
La d�finition et la valeur de ces traits sont conformes aux normes d�finies dans
Multext (http://www.lpl.univ-aix.fr/projects/multext/). 
Le r�sultat peut �tre affich� au format xml. 
L'affichage du r�sultat n�cessite l'usage du module Flemm::Result;

Principales caract�ristiques:

=over 3

=item * Etiquetage de l'input : Brill entra�n� pour le fran�ais 
(http://www.atilf.fr) ou 
TreeTagger (http://www.ims.uni-stuttgart.de/projekte/corplex/TreeTagger/DecisionTreeTagger.html)

=item * bas� sur r�gles + liste d'exceptions

=item * contr�le et �ventuellement correction de l'�tiquetage d'origine, en fonction de 
la terminaison de la forme fl�chie

=back

=cut

=head1 METHODES

=over 3

=item new(%params)

La m�thode new permet de cr�er un objet de type Flemm::Brill ou de type Flemm::TreeTagger, 
en fonction de la valeur du param�tre tagger.

Les param�tres possibles, pass�s � new via un hashage sont les suivants:

=over 4

=item * Tagger = (Brill|TreeTagger) (par d�faut : TreeTagger)

=item * Logname = prefixe des fichiers log

=item * Format = (normal|xml), (par d�faut : normal)

=back

La m�thode de lemmatisation est appel�e par l'objet cr�e, selon son 
type (Flemm::Brill ou Flemm::Treetagger) dans le module appropri� 


=item Flemm::TreeTagger::lemmatize($input_string) /

=item Flemm::Brill::lemmatize($input_string)

Quel que soit son type, la m�thode lemmatize se charge de la 
lemmatisation � proprement parler de $input_string, c'est � dire :

=over 4

=item * identifie la forme fl�chie et la cat�gorie

=item * valide la cat�gorie et la corrige si n�cessaire

=item * appelle les fonctions de  calcul du lemme et des traits morpho-flexionnels

=item * produit un r�sultat de type Flemm::Result;

=item * lui applique les m�thodes qui identifie les diff�rentes parties de l'analyse r�sultante de la lemmatisation

=back

=cut

=head1 SEE ALSO

Flemm::TreeTagger, Flemm::Brill, Flemm::Result


=cut
