#!/usr/bin/env perl
use strict;
use warnings;
use autodie;
use 5.010;

# Terms to search organized by categories...
my %terms = (
    "Scripting languages"   => [ qw(python perl ruby shell bash) ],
    "Programming languages" => [ ('java', 'javascript', '"c++"', 'golang', 'go') ],
    "Operating systems"     => [ qw(linux windows freebsd solaris) ],
    "Certifications"        => [ qw(ccna cissp lpic) ],
    "Linux scripting"       => [ ('linux perl', 'linux python', 'linux ruby', 'linux bash', 'linux shell') ],
    "Monitoring"            => [ qw(zabbix nagios icinga prometheus grafana) ],
    "Databases"             => [ qw(mysql postgresql oracle couchdb redis mongodb) ],
    "Web servers"           => [ qw(apache nginx lighttpd) ],
    "Configuration mngt"    => [ qw(puppet chef salt cfengine ansible) ],
    "DevOps"                => [ qw(devops cloud aws gcp agile scrum sre) ],
    "Containers"            => [ qw(docker rkt coreos systemd-nspawn lxc kubernetes swarm mesos marathon) ],
    "Big data"              => [ qw(splunk graylog elasticsearch elk) ],
    "Other"                 => [ qw(bind haproxy memcache jenkins gitlab) ],
);

sub run {
    my $cmd = shift;
    print "running '$cmd' ...";
    system($cmd);
    print " done\n";
}

#print "--> Generate graphs\n";
#for my $category ( keys %terms ) {
#    my $terms = join " ", map { "'$_'" } @{ $terms{$category} };
#    my $cmd = "tech-terms plot --title '$category' $terms";
#    #say($cmd);
#    run($cmd);
#}

print "--> Generate README content\n";
for my $category ( keys %terms ) {
    say "![$category](https://raw.githubusercontent.com/jreisinger/profesia-jobs-per-term/master/graphs/$category.png)";
}
