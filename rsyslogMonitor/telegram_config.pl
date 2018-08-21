#!/usr/bin/perl

sub telegram_sendMsg{
        my $theMsg=shift;

        my $thisIP="ip";
        $theMsg = $theMsg." - from ".$thisIP;

        my $telegram_bot_token="00000000:yourToken";
        my $telegram_chat_id="-YourChatID";
        my $telegram_bot_api="https://api.telegram.org/bot".$telegram_bot_token;

        `/usr/bin/curl -s -m 10 "$telegram_bot_api/sendMessage" --data-urlencode "chat_id=$telegram_chat_id" --data-urlencode "text=$theMsg" > /dev/null`
}

1; #for returning true value as this file being "require"

