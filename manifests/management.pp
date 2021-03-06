# Management Server.

class rancher::management {

  docker::image { 'rancher/server':
    require => Package['docker'],
  }

  docker::run { 'rancher_server':
    image   => 'rancher/server',
    ports   => [ '8080:8080' ],
    require => Docker::Image['rancher/server'],
  }

}
