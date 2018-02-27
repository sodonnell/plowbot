#!/usr/bin/env bash
#
# Install requried perl models.
#
# Written by Sean O'Donnell <sean@seanodonnell.com>
# Copyright 2009-2018 GPL License. Use it and Enjoy!
#
cat logo.txt;

echo -e "Installing required perl modules via CPAN\n";

# default/required modules.
sudo perl -MCPAN -e 'install DBD::mysql';
sudo perl -MCPAN -e 'install Switch';
sudo perl -MCPAN -e 'install Number::Format';
sudo perl -MCPAN -e 'install POE::Component::IRC';
sudo perl -MCPAN -e 'install Digest::MD5';

# experimental modules.
sudo perl -MCPAN -e 'install XML::RSS::Parser';
sudo perl -MCPAN -e 'install Chatbot::Eliza';

echo -e "Done.\n";

#
# create symlink to /usr/bin/plowbot
#
echo -e "Creating symbolic link to plowbot within /etc/bin";
sudo ln -s plowbot.pl /usr/bin/plowbot;
echo -e "Done.\n\n";

#
# sent to config editor
#
echo "Intsallation complete!\n\nWould you like to edit your configuration, now? [yes|no]\n\n";
readline RESPONSE;

if [ $RESPONSE == "yes" ]
    vi config.pl
if

echo -e "Installation complete.\nYou can now connect to DALNet, Efnet or Freenode using the following flags:";

echo -e "\n"-d|--dalnet - to connect to the DALnet network\n";
echo -e "\n"-e|--efnet - to connect to the EFnet network\n";
echo -e "\n"-f|--freenode - to connect to the Freenode network\n";

echo -e "You can also add additional networks and flags by modifying the config.pl script.\n";

echo -e "Enjoy!\n";
