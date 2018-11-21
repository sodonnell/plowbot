# plowbot - An IRC Bot written in Perl.

A simple IRC Bot written in Perl. This project was intended to have a simple channel bot for random things. It was more of an experiment in IRC Bot programming using Perl, but can be used as a boilerplate for creating your own custom IRC bot in perl.

> NOTE: This project is being re-developed using a custom branch, and is currently considered 'not working' in the master branch. Don't bother trying to use this code at the moment. More updates to come. Cheers!

# 3rd-Party Application(s) - Optional

* MySQL Server - Most of this functionality has been deprecated, but you can easily extend the plowbot to collect data to mysql.

# CPAN Module Requirments

The install.sh assumes that you have sudo access, and Perl/CPAN installed.

The following perl modules will be installed during the installation process (aka: running install.sh)

* Switch
* LWP
* POE::Component::IRC
* Number::Format
* Digest::MD5
* DBD::mysql
* Chatbot::Eliza
* XML::RSS::Parser

# Configuration

We suggest editing the config.pl script prior to installation. The install.sh script will place the file to the /etc/plowbot.conf file, once executed.

## IRC Network/User Configuration

In the config.pl (or resulting /etc/plowbot.conf) file, you will see a switch with various servers and channels configured.

Example:
```
case /^-f|^--freenode/
{
    $nickname = 'plowbot';
    $ircname = 'PlowBot/v1.0';
    $server = 'irc.freenode.net';
    $master = 'mynickname';
    @channels = ('#privchan chanpass','#linux','#perl','#plowbot');
}
```

This configuration example (above) would create a flag to automatically connect to the freenode IRC network, as the user 'plowbot', with a bot-master named 'mynickname'.

You would then want to use the following command(s) to connect the plowbot to freenode:

```
./plowbot.pl -f
```

or 

```
./plowbot.pl --freenode
```

You can extend the cases and execution flags as you see fit, so that you can connect to any specific network or channels that you wish. There are a few cases which exist as examples.

## Database Configuration

## Bitly API Client Configuration

The Bitly API Client is currently disabled by default, as the API service is considered legacy (circa 2009) and is now deprecated.

# Installation

You can edit the config.pl file prior to executing the install.sh script, or you can edit it afterwards, from the following path: /etc/plowbot.conf
```
git clone https://github.com/sodonnell/plowbot.git
cd plowbot
chmod +x ./install.sh
./install.sh
```

## Installing Required Perl Modules (Manually)
Note: The install.sh script will do this for you, but in case you have issues, this may help.

```
# required modules
sudo perl -MCPAN -e 'install Switch'
sudo perl -MCPAN -e 'install POE::Component::IRC'
sudo perl -MCPAN -e 'install Number::Format'
sudo perl -MCPAN -e 'install Digest::MD5'
sudo perl -MCPAN -e 'install DBD::mysql'
sudo perl -MCPAN -e 'install Chatbot::Eliza'
sudo perl -MCPAN -e 'install XML::RSS::Parser'
```

# Running plowbot

Connect to a EFNet Server:

```
plowbot -e
```

Connect to a FreeNode Server:
```
plowbot -f
```

Connect to a DALnet Server:
```
plowbot -d
```

Note: you can add your prefered irc networks and custom flags within the config.pl file.

# !Triggers:

Currently, the plowbot only responds to triggers within an IRC channel it has joined. 

Private Message Triggers have not yet been implemented.

**Bot-Master Channel Triggers**
* !join [channel] - Instructs the bot to /join the specified channel.
* !part [channel] - Instructs the bot to /part the specified channel.
* !op [nick] - Instructs the bot to /op the specified nick(s).
* !deop [nick] - Instructs the bot to /deop the specified nick(s).
* !kick [nick] - Instructs the bot to /kick the specified nick(s).
* !uptime - Displays the uptime of the server the bot in running on.

**Public/Non-Bot-Master Channel Triggers**
* !addquote [string] - Add quote to database
* !quote - Print random quote from database

**Deprecated Triggers**
* !md5 [string] - Converts text/string to md5 hash. *DEPRECATED*
* !bitly [url] - returns a URL-shortened bookmark of the specified URL. *DEPRECATED/REMOVED*
