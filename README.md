# plowbot - An IRC Bot written in Perl.
--
# CPAN Modules
The install.sh assumes that you have sudo access, and Perl/CPAN installed.

## Required Perl Modules:
* POE::Component::IRC
* Number::Format
* XML::RSS::Parser
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
