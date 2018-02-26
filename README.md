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

## Installing Required Perl Modules (Manuall)
Note: The install.sh script will do this for you.

sudo perl -MCPAN -e 'install Number::Format'
sudo perl -MCPAN -e 'install XML::RSS::Parser'
sudo perl -MCPAN -e 'install POE::Component::IRC'

# experimental modules (disabled for now)
#sudo perl -MCPAN -e 'install Chatbot::Eliza'
