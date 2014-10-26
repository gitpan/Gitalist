use MooseX::Declare;

class Gitalist::Git::CollectionOfRepositories::FromListOfDirectories with Gitalist::Git::CollectionOfRepositories {
    use MooseX::Types::Common::String qw/NonEmptySimpleStr/;
    use MooseX::Types::Moose qw/ ArrayRef HashRef /;
    use File::Basename qw/basename/;
    use Moose::Autobox;

    has repos => (
        isa => ArrayRef[NonEmptySimpleStr],
        is => 'ro',
        required => 1,
    );
    has repos_by_name => (
        isa => HashRef[NonEmptySimpleStr],
        is => 'ro',
        lazy_build => 1,
        traits => ['Hash'],
        handles => {
            _get_path_for_repository_name => 'get',
        },
    );

    method _build_repos_by_name {
        { map { basename($_) => $_ } $self->repos->flatten };
    }

    ## Builders
    method _build_repositories {
        [ map { $self->get_repository($_) } $self->repos->flatten ];
    }
}                               # end class

1;
