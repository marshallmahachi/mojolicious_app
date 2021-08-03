package Course::Management;
use Mojo::Base 'Mojolicious', -signatures;
use Mojo::Home;
use YAML qw(LoadFile);

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');
  my $course_config = LoadFile($config->{course_config});

  my $home = Mojo::Home->new;
  $home->detect;

  # Configure the application
  $self->secrets($home->child($config->{secrets}));

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/' => {cc => $course_config})->to('Example#welcome');
  $r->get('/course/:id' => {cc => $course_config})->to('course#list_exercises');
}

1;
