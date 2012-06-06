###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1					  #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################
#
# $Id$
#

package Flemm::Features;

use strict;

use Flemm::Utils::List;

our @ISA=qw(Flemm::Utils::List);

1;

__END__

=head1 NAME

Flemm::Result - Lemmatisation du fran�ais � partir de corpus 
�tiquet�s.
Gestion des analyses ambigu�s

=head1 SYNOPSIS

 use Flemm::Features;
 $features=new Flemm::Features;

=head1 DESCRIPTION

L'objet de type Flemm::Features est un sous type de Flemm::Utils::List.
Cet objet permet d'appliquer � l'ensemble des traits caract�risant une analyse
d'une forme fl�chie 
les m�thodes appropri�es pour leur construction, modification, destruction
 et d'acc�s.  

=head1 SEE ALSO

Flemm::Utils::List;


=cut
