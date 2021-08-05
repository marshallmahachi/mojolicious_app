package Course::Management::Controller::Course;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Upload;
use Mojo::Home;
use Data::Dumper;

# This action will render a template
sub list_exercises ($self) {

  my $id = $self->param('id');
  my $cc = $self->stash('cc');

  my ($course) = grep {$_->{id} eq $id} @$cc;

  # Render template "course/list_execises.html.ep" with message
  $self->render(course => $course);
}

sub upload ($self) {
  my $id = $self->param('id');
  my $cc = $self->stash('cc');

  my ($course) = grep {$_->{id} eq $id} @$cc;
  die if not $course;

  my $home = Mojo::Home->new;
  $home->detect;

  my $dir = $home->child('data', $id);
  $dir->make_path;
  my $filename = $dir->child('a.txt');

  my $upload = Mojo::Upload->new;
  $upload->move_to($filename);
}

1;
