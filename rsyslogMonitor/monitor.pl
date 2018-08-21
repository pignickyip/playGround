#!/usr/bin/env perl
#use strict;
#use warnings;
#for perl 5.18
use experimental 'smartmatch';
use Cwd qw(cwd);
#my $myDirectory = cwd;
my $myDirectory = "/tmp/nickyip/Monitor";
require $myDirectory."/telegram_config.pl";

# Set the file we use
my $theFile = "/var/log/mySystem.log";
my $theRecord = $myDirectory."/recordSystem.txt";
#@ARGV = $theFile if not @ARGV;
#die "Usage: $0 $theFile \n" if not @ARGV;

#Read the file to obtain last value we looked up
my @recordLine = ();
open my $fh, '<' ,  $theRecord or die "Cannot open the File: $!";
while (my $line = <$fh>) {
        push @recordLine, $line;
}
close $fh;
# Match the Data
my @lastLine = ();
$recordFileSc = (scalar @recordLine);
foreach my $file ($theFile) {
        $fileCountRow = `wc -l < $file`;
        open my $fh, '<:encoding(UTF-8)', $file or die;
        while (my $line = <$fh>) {
       # /^(?=.*\b(?:UFW|MySql)\b)(?:\w++ ?){1,}/
                $myEscape = $line;
                $myEscape =~ s/"/ /g;;
                if ($line =~ /Alert/) {
                        if ($. ~~ @recordLine ){
                                #continue;
                                # Handle a job, if the log file rotated
                                # Have a window and problem
                                if($recordFileSc > $fileCountRow){
                                        if( $. >= $fileCountRow){
                                                telegram_sendMsg($myEscape);
                                                #print "HI";
                                        }
                                }
                        }else {
                                telegram_sendMsg($myEscape);
                        }
                } else {
                        #print "Message Not Found\n";
                }
                push @lastLine , $.;
        }
}
close $fh;


# Record the last value we looked up
open my $fh, '>', $theRecord or die "Cannot open the File: $!";
foreach (@lastLine)
{
    print $fh "$_\n";
}
close $fh;

# End.

