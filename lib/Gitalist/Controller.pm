package Gitalist::Controller;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->meta->make_immutable;
1;

