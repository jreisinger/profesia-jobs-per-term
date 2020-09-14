#!/usr/bin/env perl
use strict;
use warnings;
use autodie;
use 5.010;

# Terms to search and graph organized by categories...
my %terms = (
    "Scripting languages"   => [ qw(python perl ruby shell bash) ],
    "Programming languages" => [ qw(java javascript golang php) ],
    "Operating systems"     => [ qw(linux windows freebsd solaris) ],
    "Certifications"        => [ qw(ccna cissp lpic ckad) ],
    "Linux scripting"       => [ ('linux perl', 'linux python', 'linux ruby', 'linux bash', 'linux shell') ],
    "Monitoring"            => [ qw(zabbix nagios icinga prometheus grafana) ],
    "Databases"             => [ qw(mysql postgresql oracle couchdb redis mongodb) ],
    "Web servers"           => [ qw(apache nginx lighttpd) ],
    "Configuration mngt"    => [ qw(puppet chef salt cfengine ansible) ],
    "DevOps"                => [ qw(devops cloud aws gcp agile scrum sre) ],
    #"Containers"            => [ qw(docker rkt coreos systemd-nspawn lxc kubernetes swarm mesos marathon) ],
    "Containers"            => [ qw(docker rkt lxc kubernetes swarm) ],
    "Big data"              => [ qw(splunk graylog elasticsearch elk) ],
    "Other"                 => [ qw(bind haproxy memcache jenkins gitlab) ],
);

# Repo path...
chdir "$ENV{HOME}/git/hub/profesia-jobs-per-term";

print "--> Pull\n";
system "git pull";

# Binary...
my $TECH_TERMS = "$ENV{HOME}/go/bin/tech-terms";

sub run {
    my $cmd = shift;
    print "running '$cmd' ...";
    system($cmd);
    print " done\n";
}

print "--> Search terms and store results\n";
my @all_terms;
for my $category (keys %terms) {
    push @all_terms, @{ $terms{$category} };
}
my $all_terms = join " ", map { "'$_'" } @all_terms;
my $cmd = "$TECH_TERMS search $all_terms --store";
#say($cmd);
run($cmd);

print "--> Generate graphs\n";
for my $category ( keys %terms ) {
    my $terms = join " ", map { "'$_'" } @{ $terms{$category} };
    my $cmd = "$TECH_TERMS plot --title '$category' $terms";
    #say($cmd);
    run($cmd);
}

print "--> Generate README content\n";
for my $category ( sort keys %terms ) {
    my $urlencoded = $category;
    $urlencoded =~ s/\s+/%20/g; 
    say "![$category](https://raw.githubusercontent.com/jreisinger/profesia-jobs-per-term/master/graphs/$urlencoded.png)";
}

print "--> Commit and push\n";
system "git commit -am 'updated data' && git push";
