# plowbot - An IRC Bot written in Perl.

A simple IRC Bot written in Perl. This project was intended to have a simple channel bot for random things. It was more of an experiment in IRC Bot programming using Perl, but can be used as a boilerplate for creating your own custom IRC bot in perl.

# CPAN Modules
The install.sh assumes that you have sudo access, and Perl/CPAN installed.

## Required Perl Modules:
* Switch
* POE::Component::IRC
* Number::Format
* Digest::MD5
* DBD::mysql

## Optional Perl Modules:
* Chatbot::Eliza
* XML::RSS::Parser

# Installation
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
# experimental modules (disabled for now)
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

Currently, the plowbot only responds to triggers within a channel it has joined. 

Private Message Triggers have not yet been implemented.

**Bot-Master Channel Triggers**
* !join [channel] - Instructs the bot to /join the specified channel.
* !part [channel] - Instructs the bot to /part the specified channel.
* !op [nick] - Instructs the bot to /op the specified nick(s).
* !deop [nick] - Instructs the bot to /deop the specified nick(s).
* !kick [nick] - Instructs the bot to /kick the specified nick(s).
* !uptime - Displays the uptime of the server the bot in running on.

**Public/Non-Bot-Master Channel Triggers**
* !md5 [string] - Converts text/string to md5 hash.
