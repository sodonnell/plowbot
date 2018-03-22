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
}

# deprecated; legacy API implementation. Needs updating;
# leave disabled for now.
#my $bitly = 1; # enabled
my $use_bitly = 0; # disabled

if ($use_bitly)
{
    my $bitly_api_login = "???";
    my $bitly_api_key = "???";
}

sub print_help()
{
    print "Usage: $0 [network flag]\n\n";
    print "Network Flags:\n";
    print "\t-d|--dalnet (to connect to DALnet)\n";
    print "\t-e|--efnet (to connect to EFnet)\n";
    print "\t-f|--freenode (to connect to freenode)";
    # add more if you wish
}
