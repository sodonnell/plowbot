# plowbot - An IRC Bot written in Perl.

A simple IRC Bot written in Perl. This project was intended to have a simple channel bot for random things. It was more of an experiment in IRC Bot programming using Perl.

# !Triggers:

** Bot-Master Triggers (non-public.) **
* !uptime - Displays the uptime of the server the bot in running on.
* !join [channel] - Instructs the bot to /join the specified channel.
* !part [channel] - Instructs the bot to /part the specified channel.
* !op [nick] - Instructs the bot to /op the specified nick(s).
* !deop [nick] - Instructs the bot to /deop the specified nick(s).
* !kick [nick] - Instructs the bot to /kick the specified nick(s).

** Public Triggers (non-master, but master can too.) **
* !md5 [string] - Converts text/string to md5 hash.


# CPAN Modules
The install.sh assumes that you have sudo access, and Perl/CPAN installed.

## Required Perl Modules:
* POE::Component::IRC
* Number::Format
* XML::RSS::Parser
* Digest::MD5

## Optional Perl Modules:
* Chatbot::Eliza

# Installation
```
git clone https://github.com/sodonnell/plowbot.git
cd plowbot
./install.sh
```

## Installing Required Perl Modules (Manually)
Note: The install.sh script will do this for you.

```
sudo perl -MCPAN -e 'install Number::Format'
sudo perl -MCPAN -e 'install XML::RSS::Parser'
sudo perl -MCPAN -e 'install POE::Component::IRC'
sudo perl -MCPAN -e 'install Digest::MD5'
# experimental modules (disabled for now)
#sudo perl -MCPAN -e 'install Chatbot::Eliza'
```

# Running plowbot

Connect to the EFNet Server:

```
plowbot -e
```

Connect to the FreeNode Server:
```
plowbot -f
```

Note: you can add irc networks within the 
