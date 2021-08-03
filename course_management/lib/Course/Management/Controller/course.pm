package Course::Management::Controller::Course;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Data::Dumper;

# This action will render a template
sub list_exercises ($self) {

  my $id = $self->param('id');
  my $cc = $self->stash('cc');
  
  my ($course) = grep {$_->{id} eq $id} @$cc;

  # Render template "course/list_execises.html.ep" with message
  $self->render(course => $course);
}


1;
