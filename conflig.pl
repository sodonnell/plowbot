#!/usr/bin/env perl
#
# plowbot configuration
#
# !!! EDITING REQUIRED !!!
#
use strict;
use warnings;

# Custom HTTP User Agent string
my $agent = 'plowbot/1.0';

use Switch;
use Number::Format;
use POE qw(Component::IRC);

use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;
$lwp->agent($agent);

use Digest::MD5;
my $md5 = Digest::MD5->new;

my $nickname;
my $ircname;
my $server;
my $master;
my @channels;

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
# Configure your networks, username(s), bot master (i.e. you), and IRC Channels below.
#
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
    case /^-f|--freenode/
    {
        # freenode
        $nickname = 'plowbot';
        $ircname = $agent;
        $server = 'irc.freenode.net';
        $master = 'yourmom';
        @channels = ('#sgvlug');
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
    use DBI;
    our $db_conn;
    my $db_driver = 'mysql';
    my $db_host = 'localhost';
    my $db_user = 'plowbot';
    my $db_pass = 'plowb0t1';
    my $db_name = 'plowbot';
    my $db_dsn = 'DBI:'.$db_driver.':'. $db_name .':'.$db_host;
}

#
# DISABLED MODULES
# These modules are experimental and/or legacy modules that should not be
# enabled by default. More work needs to be done with these and subsequent procedures.
#
#use XML::RSS::Parser;
#my $parser = XML::RSS::Parser->new;

# disabled by default - Eliza AI Module
#use Chatbot::Eliza; # a wee-bit of AI experiment and trickery ;p
#my $eliza = Chatbot::Eliza->new;
my $eliza; # use above to enable, and comment-out this line.

# disabled by default - bitly API auth config
#my $bitly_api_login = "";
#my $bitly_api_key = "";

sub print_help()
{
    print "Usage: $0 [network flag]\n\n";
    print "Network Flags:\n";
    print "\t-d|--dalnet (to connect to DALnet)\n";
    print "\t-e|--efnet (to connect to EFnet)\n";
    print "\t-f|--freenode (to connect to freenode)";
    # add more if you wish
}
