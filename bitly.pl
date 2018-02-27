package bitly_plowbot

sub plowbot_bitly
    if ($use_botly)
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
