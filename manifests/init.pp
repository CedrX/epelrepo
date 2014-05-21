#class epelrepo
#Configure les dépots epel pour la famille de distributions dérivées de redhat
class epelrepo {


	file { "/usr/local/bin/install_epel.sh":
        mode => "0744",
        owner => 'root',
        group => 'root',
        source => 'puppet:///modules/epelrepo/install_epel.sh',
        require => Class["elinks"],
	before => Exec["execute_install_repo_sh"]
    	}
	
	exec { "execute_install_repo_sh":
                command => "/usr/local/bin/install_epel.sh http://$::global_proxyhost  $::global_proxyport",
                onlyif => "/usr/bin/test ! -f /etc/yum.repos.d/epel.repo",
		logoutput => 'true',
                require => File["/usr/local/bin/install_epel.sh"],
        }
	File["/usr/local/bin/install_epel.sh"] -> Exec["execute_install_repo_sh"]

}
