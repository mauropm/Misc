#!/usr/bin/perl
###### LDAP-2-Mailman Synchronization script ######################################
# @author: Radek Antoniuk
# @website: http://www.warden.pl
# @license: GNU
#
# This script synchronises (adds/removes) the users from the Mailman mailing lists
# according to the objects found in LDAP. You can put it in cron. The script was
# written using Debian-style paths to Mailman, you may need to adjust them
# if you have a different mailman installation.
#
###################################################################################
use strict;
use warnings;
use Net::LDAP;

my $ldap_host = "ldap://150.200.112.155:389";
my $ldap_bind_dn = "cn=admin,o=MEXICO";
my $ldap_bind_pass = "x3w576m!";
#my $ldap_base_dn = "ou=distlists,groupwise,mexico,ou=lists,dc=domain,dc=com";
#my $ldap_base_dn = "ou=DISTLISTS,ou=GROUPWISE,o=MEXICO";
my $ldap_base_dn = "ou=DISTLISTS,ou=GROUPWISE,o=MEXICO";


my $create_nonexistent = 1;
my $default_list_admin = 'ealvarez@novell.com';
my $default_list_password = "novell";

# Connect to LDAP proxy and authenticate
my $ldap = Net::LDAP->new($ldap_host) || die "Can't connect to server\n";
$ldap->bind($ldap_bind_dn, password => $ldap_bind_pass) || die "Connected to server, but couldn't bind\n";

# search for interesting groups
my $ret = $ldap->search( base   => $ldap_base_dn,  filter => "(&(objectClass=groupWiseDistributionList))" );
#my $ret = $ldap->search( base   => $ldap_base_dn);
die "Search returned no groups\n" unless $ret;

print "\n\n";
print "------------------------------\n";

foreach my $group ($ret->entries) {

  my $member_emails = ""; #list of emails in the group
  my $list_name = $group->get_value("cn");
  
  my $mp_tmp = join('_', split ' ', $list_name); 
  
  $list_name = $mp_tmp; 
  $list_name =~s/ñ/n/; 
  
  if($list_name) {
    print "Processing list: $list_name \n";

    # get the membership list
    my @member_list = $group->get_value("member");

    # make a list of emails to pass to mailman from member objects
    foreach my $member_dn (@member_list) {
            my $person = $ldap->search(  base  => $member_dn, filter => "(&(mail=*)(!(pwdAccountLockedTime=*)))", scope => "base"  );
            # try to get the referred object, or continue if locked account or object does not exist #
            if (my $member = $person->entry(0)) {
               my $email = $member->get_value("mail");
               $member_emails .= $email."\n";
            }
    };

    # now process normal mail attributes #
    @member_list = $group->get_value("mail");

    foreach my $email (@member_list) {
            $member_emails .= $email . "\n";
    };

    # check if list exists
    if (! -d "/var/lib/mailman/lists/$list_name" ){
        print "List $list_name does not exist.\n";

        #if not and we want to create it automatically
        if ($create_nonexistent) {
                print "Creating new list $list_name.\n";
                qx{/usr/lib/mailman/bin/newlist -q $list_name $default_list_admin $default_list_password};
                # check if now the list exists
                #die "FATAL: Unable to create list $list_name" if (! -d "/var/lib/mailman/lists/$list_name" );
        }

    }

    print "\nSyncing $list_name...\n";

    open( PIPE, "|/usr/lib/mailman/bin/sync_members -w=yes -g=yes -a=yes -f - $list_name" ) || die "Couldn't fork process! $!\n";
    print PIPE $member_emails;
    close PIPE;

    print "------------------------------\n";
  };
};

$ldap->unbind;
print "\n\n";
