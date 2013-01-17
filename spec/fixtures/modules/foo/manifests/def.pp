define foo::def (
  $param = 'default'
) {

  notify {'foo-def-notify':
    message => $param,
  }


}
