###########################################################################
# FLEMM-v3.1 -- French Lemmatizer : Lemmatisation du fran�ais � partir de # 
# corpus �tiquet�s - Version 3.1					  #
# Copyright (C) 2004 (NAMER Fiammetta)					  #
###########################################################################
#
# $Id$
#

package Flemm::Utils::List;

use strict;

use constant LIST_EMPTY => -1;

sub new {
    my $this = shift;
    my $class = ref($this) || $this;
    my $self = {};
    bless $self, $class;

    $self->{list}=();
    $self->{current}=LIST_EMPTY;

    return $self;
}

sub reset {
    my $self=shift;
    
    if (@{$self->{list}}==0) {
	$self->{current}=LIST_EMPTY;
    }
    else {
	$self->{current}=0;
    }
}

sub next {
    my $self=shift;

    return undef if ($self->{current}==LIST_EMPTY);

    if ($self->{current}<@{$self->{list}}) {
	return ${$self->{list}}[$self->{current}++];
    }
    else {
	$self->reset;
	return undef;
    }
}

sub add {
    my $self=shift;
    my ($ref)=@_;
    
    if ($self->{current}==LIST_EMPTY) {
	$self->{current}=0;
    }

    push @{$self->{list}},$ref;
}

sub size {
    my $self=shift;

    return scalar(@{$self->{list}}); 
}

1;

__END__


=head1 NAME

Flemm::Utils::List - Lemmatisation du fran�ais � partir de corpus 
�tiquet�s.
gestion des �l�ments de type liste. Type h�rit� par 
Flemm::Analyses et Flemm::Features

=head1 SYNOPSIS

 use Flemm::Utils::List; 
 our @ISA=qw(Flemm::Utils::List);

=head1 DESCRIPTION

Un objet de type Flemm::Utils::List est constitu� de :


=over 3

=item * une liste

=item * l'indicateur du rang de son dernier �l�ment

=back

=cut

=head1 METHODES

=over 3

=item new()

La m�thode new permet de cr�er un objet de 
type Flemm::Utils::List.

=item reset()

Mise � z�ro de la liste

=item next();

Acc�de � l'�l�ment suivant dans la liste quand il existe.
Renvoie undef sinon

=item add($ref);

Affecte le contenu r�f�renc� par $ref en fin de liste

=item size();

Renvoie la taille de la liste

=back

=cut

