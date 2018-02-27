#!/usr/bin/env bash
#
# Written by Sean O'Donnell <sean@seanodonnell.com>
# Copyright 2009-2018 GPL License. Use it and Enjoy!
#

# display cheesy figlet logo
cat logo.txt;

# Install default/requried perl modules.
echo -e "Installing required perl modules via CPAN\n";

sudo perl -MCPAN -e 'install DBD::mysql';
sudo perl -MCPAN -e 'install Switch';
sudo perl -MCPAN -e 'install Number::Format';
sudo perl -MCPAN -e 'install POE::Component::IRC';
sudo perl -MCPAN -e 'install Digest::MD5';
sudo perl -MCPAN -e 'install XML::RSS::Parser';
sudo perl -MCPAN -e 'install Chatbot::Eliza';

echo -e "Done.\n";

#
# send to config editor
#
echo "Intsallation complete!\n\nWould you like to edit your configuration, now? [yes|no]\n\n";
readline RESPONSE;

if [ $RESPONSE == "yes" ]
    vi config.pl
if

#
# create symlink to /usr/bin/plowbot and /etc/plowbot.conf
#
echo -e "Creating symbolic links: /etc/plowbot.conf and /usr/bin/plowbot\n";
sudo ln -s plowbot.pl /usr/bin/plowbot;
sudo ln -s config.pl /etc/plowbot.conf;
echo -e "Done.\n\n";

echo -e "Installation complete.\nYou can now connect to DALNet, Efnet or Freenode using the following flags:\n";
echo -e "\n"-d|--dalnet - to connect to the DALnet network\n";
echo -e "\n"-e|--efnet - to connect to the EFnet network\n";
echo -e "\n"-f|--freenode - to connect to the Freenode network\n";

echo -e "You can also add additional networks and flags by modifying /etc/plowbot.conf.\n";
echo -e "You can view output logs for monitoring or debugging via /var/log/plowbot.log\n";
echo -e "Enjoy!\n";
