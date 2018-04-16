#!/usr/bin/perl
#
# plowbot.pl
#
# Sean's Experimental Freenode IRC-Op Bot written in Perl.
#
# This IRC bot is intended simply as an exercise in coding 
# IRC commands via the Perl/CPAN POE::Component::IRC module.
#
# I've also incorporated a few of my own scripts that I had 
# originally written for the Irssi Client, which I still use 
# as an actual IRC Client (rather than as an IRC bot), but 
# prefer to have a dedicated (background) 'bot' process running 
# it's own process for such functionality.
#

# include the configuration file.
require '/etc/plowbot.conf';

use Switch;
use Number::Format;
use POE qw(Component::IRC);

use LWP::UserAgent;
my $lwp = LWP::UserAgent->new;
$lwp->agent($agent);

use Digest::MD5;
my $md5 = Digest::MD5->new;

use XML::RSS::Parser;
my $parser = XML::RSS::Parser->new;

# disabled by default - Eliza AI Module
use Chatbot::Eliza; # a wee-bit of AI experiment and trickery ;p
my $eliza = Chatbot::Eliza->new;

if ($use_db)
{
    use DBI;
}

# We create a new IRC object
my $irc = POE::Component::IRC->spawn( 
    nick => $nickname,
    ircname => $ircname,
    server => $server,
) or die "Error spawning the POE IRC Component: $!";

# flat-file quotes data
our $fquotes = "quotes.txt";
our $line;

POE::Session->create(
     package_states => [
         main => [ qw(_default _start irc_001 irc_public) ],
     ],
     heap => { irc => $irc },
 );
 
$poe_kernel->run();

sub _default
{
	my ($event, $args) = @_[ARG0 .. $#_];
	my @output = ( "$event: " );
	
	for my $arg (@$args) 
	{
		if ( ref $arg eq 'ARRAY' ) 
		{
			push( @output, '[' . join(', ', @$arg ) . ']' );
		}
		else 
		{
			push ( @output, "'$arg'" );
		}
	}

	print join ' ', @output, "\n";
	return 0;
}

sub _start 
{
     my $heap = $_[HEAP];

     # retrieve our component's object from the heap where we stashed it
     my $irc = $heap->{irc};

     $irc->yield( register => 'all' );
     $irc->yield( connect => { } );
     return;
}

sub irc_001 
{
     my $sender = $_[SENDER];

     # Since this is an irc_* event, we can get the component's object by
     # accessing the heap of the sender. Then we register and connect to the
     # specified server.
     my $irc = $sender->get_heap();

     print "Connected to ", $irc->server_name(), "\n";

     # we join our channels
     $irc->yield( join => $_ ) for @channels;
     return;
 }
 
sub irc_public 
{
 	master_filter(@_);
 	return;
}

sub master_filter
{
	my ($sender, $who, $where, $what) = @_[SENDER, ARG0 .. ARG2];
	
	my $nick = ( split /!/, $who )[0];
	my $channel = $where->[0];

	if ($use_db && $db_conn)
	{
		my $sql_log = "INSERT INTO plowbot_logs (nick,chan,address,server,textinput) VALUES ('$nick','$channel','','$server','$what');";
		db_query($sql_log);
	}

	if ($nick eq $master || $nick eq "+$master" || $nick eq "\@$master")
	{
		# botmaster triggers
        switch($what)
        {
            case /^!uptime/
            {
                $irc->yield( privmsg => $channel => "$nick: As you wish, master." );
                my $uptime = `uptime`;
                $irc->yield( privmsg => $channel => "$nick: $uptime" );
            }
            case /^!quit/
            {
                $irc->yield( privmsg => $channel => "$nick: As you wish, master." );
                $irc->yield( quit => msg => "Nuked by: $nick" );
                print "Exiting. The !quit command was executed by: $nick\n";
                exit;
            }
            case /^!join/
            {
                my $whereto = $what;
                $whereto =~ s/^!join //;
                print "Joining: $whereto\n";
                $irc->yield( join => "$whereto" );
            }
            case /^!part/
            {
                my $whereto = $what;
                $whereto =~ s/^!part //;
                print "Parting $whereto\n";
                $irc->yield( part => "$whereto" => msg => "$whereto Peace out!" );
            }
            case /^!kick/
            {
                my $who = $what;
                $who =~ s/^!kick //;
                print "Kicking: $who\n";
                $irc->yield( kick => $channel => msg => "$who *b00ted*" );
            }
            case /$nickname/
            {
                # AI testing with Eliza
		        $what =~ s/$nickname//;
                my $reply = $eliza->transform($what);
                $irc->yield( privmsg => $channel => "$nick: $reply" );
            }
            case /^!op/
            {
                my $who = $what;
                $who =~ s/^!op //;
                if ($who)
                {
                    print "Op'ing Minion: $who\n";
                }
                else
                {
                    $who = $master;
                    print "Op'ing Master: $who\n";
                }
                $irc->yield( mode => $channel => "+o $who" );
            }
            case /^!deop/
            {
                my $who = $what;
                $who =~ s/^!deop //;
                if ($who)
                {
                    print "deop'ing Minion: $who\n";
                }
                else
                {
                    $who = $master;
                    print "deop'ing Master: $who\n";
                }
                $irc->yield( mode => $channel => "-o $who" );
            }
        }
	}

    # public (non-master) triggers
    switch($what)
    {
    	# deprecated. 2010-ish API is dead.
        case /^!bitly/
        {
            if ($use_bitly)
            {
                my $url = $what;

                $url =~ s/^!bitly //;

                my $url_bitly;

                # @todo Update API endpoint. This one was circa 2009.
                my $api_src = "http://api.bit.ly/shorten?version=2.0.1&longUrl=".$url."&login=".$bitly_api_login."&apiKey=".$bitly_api_key;

                my $response = $lwp->get($api_src);

                if ($response->is_success)
                {
                    my $raw_data = $response->decoded_content;

                    foreach my $line (split(/\n/,$raw_data))
                    {
                        if ($line =~ m/shortURL/i)
                        {
                            $line =~ s/\"//g;
                            $line =~ s/,//g;

                            my ($var,$url_bitly) = split(/:/,$line,2);

                            $url_bitly =~ s/ //g;
                            $url_bitly =~ s/\t//g;

                            #print "url: $url\nbitly: $url_bitly\n";
                            $irc->yield( privmsg => $channel => "$nick (URL=SUCCESS): $url_bitly" );
                            $irc->yield( privmsg => $channel => "$line" );

                            last;
                        }
                    }
                    print "Transformed $url to $url_bitly\n";
                }
                else
                {
                    print "An error occurred while making the HTTP Request: $response->errstr\n";
                    $irc->yield( privmsg => $channel => "$nick (URL=FAIL): $response->errstr" );
                }
            }
        }

        case /^!addquote/
        {
            $what =~ s/!addquote //g;
            $who =~ s/\!.*//g;
            add_quote($what);
            $irc->yield( privmsg => $channel => "Quote added. Thank you, $who." );
        }
        case /^!quote/
        {
            $quote = read_quote();
            $irc->yield( privmsg => $channel => "$quote" );
        }

        case /^!md5sum/
        {
	    # deprecated. intended to encrypt strings, not files. Needs work. That requires time. Eh.
            my $encstr = $what;
            $encstr =~ s/^!md5 //;
            my $md5sum = md5sum($encstr);
            $irc->yield( privmsg => $channel => "$md5sum" );
        }
    }
	return;
}



sub add_quote
{
    my ($quote) = @_;
    open(QUOTES, '>>', $fquotes) or print "Error opening $fquotes file.";
    print QUOTES $quote ."\n";
    close(QUOTES);
}

sub read_quote
{
    open(QUOTES, '<', $fquotes) or print "Error opening $fquotes file.";
    rand($.)<1 and ($line=$_) while <QUOTES>;
    close(QUOTES);
    return $line;
}

# this routine returns the md5sum of a specified file.
sub md5sum
{
	#my $this = shift;
	my ($file) = @_;

	if (-e $file)
	{
		open(FILE, $file) or die "Can't open '$file': $!";
		binmode(FILE);
		while (<FILE>) 
		{ 
			$md5->add($_);
		}
		close(FILE);
		return $md5->b64digest;
	}
	else
	{
		return "error: file not found. ($file)";
	}
}

# perform MD5sum check to compare feed data between the 
# most recent and current XML data for the selected feed.
sub md5checksum
{
	my $this = shift;
	my ($file1,$file2) = @_;

	if (((-e $file1) && (-e $file2)) && ($this->md5sum($file1) eq $this->md5sum($file2)))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

if ($use_db)
{
    my $db_dsn = 'DBI:'.$db_driver.':'. $db_name .':'.$db_host;
    our $db_conn = db_conn();

    sub db_conn
    {
        my $db = DBI->connect($db_dsn, $db_user, $db_pass)
            or return 'Connection Error: $DBI::err($DBI::errstr)';
        return $db;
    }

    sub db_disconn
    {
        # my $db_conn = shift;
        $db_conn->disconnect();
    }

    sub db_query
    {
        # my ($db_conn,$sql) = @_;
        my $sql = shift;

        if ($sql)
        {
            my $db_query = $db_conn->prepare($sql)
                or return 'SQL Error: $DBI::err($DBI::errstr)';
            $db_query->execute()
                or return 'Query Error: $DBI::err($DBI::errstr)';
            $db_query->finish();
        }
        return;
    }
}
