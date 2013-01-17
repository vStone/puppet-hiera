class foo (
  $param = 'default'
) {

  notify {'foo-notify':
    message => $param,
  }

}
