#!/usr/bin/env perl
#
# plowbot configuration
#
# !!! EDITING REQUIRED !!!
#
use strict;
use warnings;
use Env;

my @ISA = qw(Exporter);
my @EXPORT = qw(VERSION parse_config_file);

my $VERSION = "1.0.0";

# Custom HTTP User Agent string for LWP::UserAgent
my $agent = 'plowbot/'.$VERSION;

# IRC Client/Network Configuration
#
# Using the switch below, you can add support
# for multiple IRC servers. Although this bot
# doesn't currently support connecting to multiple
# servers in a single instance, it has the potential to.
#
# You can define/extend the case below if you wish to use
# as other arguments/flags to trigger other irc servers.
#
# Configure your network(s), username(s), bot-master (i.e. you),
# and IRC Channel(s) below.
#
my $nickname;
my $ircname;
my $server;
my $master;
my @channels;

# flat-file quotes data
our $fquotes = "quotes.txt";
our $line;

# configure your favorite IRC networks and channels here.
switch($ARGV[0])
{
    case /^-e|^--efnet/
    {
        # efnet
        $nickname = 'plowbot';
        $ircname = $agent;
        $server = 'irc.he.net';
        $master = 'yourmom';
        @channels = ('#privchan chanpass','#linux');
    }
    case /^-f|^--freenode/
    {
        # freenode
        $nickname = 'plowbot';
        $ircname = $agent;
        $server = 'irc.freenode.net';
        $master = 'yourmom';
        @channels = ('#plowbot');
    }
    case /^-d|^--dalnet/
    {
        # dalnet
        $nickname = 'plowbot';
        $ircname = $agent;
        $server = 'irc.dalnet.net';
        $master = 'n00bg33k';
        @channels = ('#privchan chanpass','#linux');
    }
    else
    {
        print_help();
        exit;
    }
}

#
# database config
#
# set '$use_db = 1;' if you want to enable
# logging and other database-related functionality.
#
my $use_db = 0;

# if $use_db = 0, you can ignore the $db_ settings below.
if ($use_db)
{
    our $db_conn;
    my $db_host = 'localhost';
    my $db_user = 'plowbot';
    my $db_pass = 'plowb0t1';
    my $db_name = 'plowbot';
    my $db_driver = 'mysql';
    use DBI;
}

use Switch;
use Number::Format;
use POE qw(Component::IRC);

use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;
$lwp->agent($agent);

# deprecated
use Digest::MD5;
my $md5 = Digest::MD5->new;

use XML::RSS::Parser;
my $parser = XML::RSS::Parser->new;

# disabled by default - Eliza AI Module
use Chatbot::Eliza; # a wee-bit of AI experiment and trickery ;p
my $eliza = Chatbot::Eliza->new;

# We create a new IRC object
my $irc = POE::Component::IRC->spawn(
    nick => $nickname,
    ircname => $ircname,
    server => $server,
) or die "Error spawning the POE IRC Component: $!";

POE::Session->create(
     package_states => [
         main => [ qw(_default _start irc_001 irc_public) ],
     ],
     heap => { irc => $irc },
 );

$poe_kernel->run();
