#!/usr/bin/perl

$|=1;
while (<>) {
@X = split;
if ($X[0] =~ m/^https?\:\/\/.*/) {
	$x = $X[0]; 
	$_ = $X[0];
	$u = $X[0];
} else { 
	$x = $X[1]; 
	$_ = $X[1];
	$u = $X[1];
}


#ads youtube
if ($x=~ m/^https?\:\/\/.*youtube.*api.*stats.*ads.*/){
    @content_v = m/[&?]content_v\=([^\&\s]*)/;
    @cpn = m/[%&?\/](cpn[%&=\/][^\&\s\/]*)/;
    unless (-e "/tmp/@cpn"){
    open FILE, ">/tmp/@cpn";
    print FILE "id=@content_v";
    close FILE;
    }
    $out=$x;

#tracking youtube
} elsif ($x=~ m/^https?\:\/\/.*youtube.*(ptracking|set_awesome).*/){
    @video_id = m/[&?]video_id\=([^\&\s]*)/;
    @cpn = m/[%&?\/](cpn[%&=\/][^\&\s\/]*)/;
    unless (-e "/tmp/@cpn"){
    open FILE, ">/tmp/@cpn";
    print FILE "id=@video_id";
    close FILE;
    }
    $out=$x;
 
 
#stream_204 youtube
} elsif ($x=~ m/^https?\:\/\/.*youtube.*(stream_204|watchtime|qoe|atr).*/){
    @docid = m/[&?]docid\=([^\&\s]*)/;
    @cpn = m/[%&?\/](cpn[%&=\/][^\&\s\/]*)/;
    unless (-e "/tmp/@cpn"){
    open FILE, ">/tmp/@cpn";
    print FILE "id=@docid";
    close FILE;
    }
    $out=$x;
 
#player_204 youtube
} elsif ($x=~ m/^https?\:\/\/.*youtube.*player_204.*/){
    @v = m/[&?]v\=([^\&\s]*)/;
    @cpn = m/[%&?\/](cpn[%&=\/][^\&\s\/]*)/;
    unless (-e "/tmp/@cpn"){
    open FILE, ">/tmp/@cpn";
    print FILE "id=@v";
    close FILE;
    }
    $out=$x;

#youtube
} elsif ($x=~ m/^https?\:\/\/.*(youtube|googlevideo).*videoplayback.*title.*/){
    @title      = m/[%&?\/](title[%&=\/][^\&\s\/]*)/;
    @itag      = m/[%&?\/](itag[%&=\/][^\&\s\/]*)/;
    @range   = m/[%&?\/](range[%&=\/][^\&\s\/]*)/;
    $out="http://pc-mikrotik/youtube/@itag@title@range";
 
#youtube
} elsif ($x=~ m/^https?\:\/\/.*(youtube|googlevideo).*videoplayback.*/){
    @cpn      = m/[%&?\/](cpn[%&=\/][^\&\s\/]*)/;
    @id      = m/[%&?\/](id[%&=\/][^\&\s\/]*)/;
    @itag      = m/[%&?\/](itag[%&=\/][^\&\s\/]*)/;
    @range  = m/[%&?\/](range[%&=\/][^\&\s\/]*)/;
    @slices = m/[%&?\/](slices[%&=\/][^\&\s\/]*)/;
    @mime     = m/[%&?\/](mime[%&=\/][^\&\s\/]*)/;
    if (defined(@cpn[0])){
        if (-e "/tmp/@cpn"){
        open FILE, "/tmp/@cpn";
        @id = <FILE>;
        close FILE;}
    }
    $out="http://pc-mikrotik/youtube/@id@itag@mime@range@slices";


#utmgif
} elsif ($x=~ m/^https?\:\/\/.*utm.gif.*/) {
    $out="http://pc-mikrotik/__utm.gif";


#safe_image FB
} elsif ($x=~ m/^https?\:\/\/fbexternal-a\.akamaihd\.net\/safe_image\.php\?d.*/) {
    @d = m/[&?]d\=([^\&\s]*)/;
    @h = m/[&?]h\=([^\&\s]*)/;
    @w = m/[&?]w\=([^\&\s]*)/;
    $out="http://pc-mikrotik/safe_image/d=@d&w=@w&h=@h";

#safe_image FB 1
} elsif ($x=~ m/^https?\:\/\/fbexternal-a\.akamaihd\.net\/safe_image\.php\?d.*/) {
    $out="http://helpr/safe_image/d=@d&w=@w&h=@h";

#safe_image FB 2
} elsif ($x=~ m/^https?\:\/\/fbstatic-a\.akamaihd\.net\/safe_image\.php\?d.*/) {
    $out="http://helpr/safe_image/d=@d&w=@w&h=@h";

#fbcdn size picture
} elsif ($x=~ m/^https?\:\/\/.*(fbcdn).*\/v\/.*\/(.*x.*\/.*\.(jpg|jpeg|bmp|ico|png|gif))\?oh=\.*/) {
    $out="http://pc-mikrotik/fbcdn/" . $2;

#fbcdn picture
} elsif ($x=~ m/^https?\:\/\/.*(fbcdn).*\/v\/.*\/(.*\.(jpg|jpeg|bmp|ico|png|gif))\?oh=\.*/) {
    $out="http://pc-mikrotik/fbcdn/" . $2;

#fbcdn profile 1
} elsif ($x=~ m/^https?\:\/\/fbcdn-[profile|sphotos].*\.akamaihd\.net\/h[profile|photos].*\/t1.*\/([a-z]\d+x\d+)\/(.*\.jpg)/) {
    $out="http://helpr/fbcdn/" . $2;

#fbcdn profile 2
} elsif ($x=~ m/^https?\:\/\/.*\/([a-z]\d+x\d+)\/(.*\.(bmp|ico|jpe?g|png)).*/) {
    $out="http://helpr/fbcdn/" . $2;

#reverbnation
} elsif ($x=~ m/^https?\:\/\/c2lo\.reverbnation\.com\/audio_player\/ec_stream_song\/(.*)\?.*/) {
    $out="http://pc-mikrotik/reverbnation/" . $1;
 
#playstore
} elsif ($x=~ m/^https?\:\/\/.*\.c\.android\.clients\.google\.com\/market\/GetBinary\/GetBinary\/(.*\/.*)\?.*/) {
    $out="http://pc-mikrotik/android/market/" . $1;


#filehost
} elsif ($x=~ m/^https?\:\/\/.*datafilehost.*\/get\.php.*file\=(.*)/) {
    $out="http://pc-mikrotik/filehost/" . $1;


#speedtest
} elsif ($x=~ m/^https?\:\/\/.*(speedtest|espeed).*\/(.*\.(jpg|txt|png|bmp)).*/) {
    $out="http://pc-mikrotik/speedtest/" . $2;


#filehippo
} elsif ($x=~ m/^https?\:\/\/.*\.filehippo\.com\/.*\/(.*\/.*)/) {
    $out="http://pc-mikrotik/filehippo/" . $1;


#4shared preview.mp3
} elsif ($x=~ m/^https?\:\/\/.*\.4shared\.com\/.*\/(.*\/.*)\/dlink.*preview.mp3/) {
    $out="http://pc-mikrotik/4shared/preview/" . $1;

#4shared
} elsif ($x=~ m/^https?\:\/\/.*\.4shared\.com\/download\/(.*\/.*)\?tsid.*/) {
    $out="http://pc-mikrotik/4shared/download/" . $1;

#steampowered dota 2
} elsif ($x=~ m/^https?\:\/\/media\d+\.steampowered\.com\/client\/(.*)/) {
    $out="http://helpr/media/steampowered/" . $1;

#steampowered dota2 chunk-manifest
} elsif ($x=~ m/^https?\:\/\/valve\d+\.cs\.steampowered\.com\/depot\/(.*)/) {
    $out="http://helpr/steampowered/depot/" . $1;

#animeindo
} elsif ($x =~ m/^http:\/\/.*aisfile\.com:182\/.\/(.*)\/(.*\.(mp4|flv)).*/){
    $out="http://helpr/aisfile:182/" . $2;

#android
} elsif ($X =~ m/^http:\/\/.*\.c\.android\.clients\.google\.com\/market\/GetBinary\/([\w\d\-\.\%]*)\/([\d]*)\/.*/){
    $out="http://helpr/android-apps/" . $1;

#prn
} elsif ($X =~ m/^http:\/\/.*\.xvideos\.com\/.*\/([\w\d\-\.\%]*\.(3gp|mpg|flv|mp4))\?.*/){
    $out="http://helpr/xvideos/" . $1;

} elsif ($X =~ m/^http:\/\/[\d]+\.[\d]+\.[\d]+\.[\d]+\/.*\/xh.*\/([\w\d\-\.\%]*\.flv)/){
    $out="http://helpr/Xhamster/" . $1;

} elsif ($X =~ m/^http:\/\/[\d]+\.[\d]+\.[\d]+\.[\d]+.*\/([\w\d\-\.\%]*\.flv)\?start=0/){
    $out="http://helpr/Xhamster2/" . $1;

} elsif ($X =~ m/^https?\:\/\/.*\/([a-z].[a-zA-Z])\/.*\.flv/){
    $out="http://helpr/Xhamster3/" . $1;

} elsif ($X =~ m/^http:\/\/.*\.youjizz\.com.*\/([\w\d\-\.\%]*\.(mp4|flv|3gp))\?.*/){
    $out="http://helpr/YouJizz/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\.\%]*\.keezmovies[\w\d\-\.\%]*\.com.*\/([\w\d\-\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
    $out="http://helpr/KeezMovies/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\.\%]*\.tube8[\w\d\-\.\%]*\.com.*\/([\w\d\-\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
    $out="http://helpr/Tube8/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\.\%]*\.youporn[\w\d\-\.\%]*\.com.*\/([\w\d\-\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
    $out="http://helpr/YouPorn/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\.\%]*\.spankwire[\w\d\-\.\%]*\.com.*\/([\w\d\-\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
    $out="http://helpr/SpankWire/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\.\%]*\.pornhub[\w\d\-\.\%]*\.com.*\/([[\w\d\-\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
    $out="http://helpr/PornHub/" . $1;

} elsif ($X =~ m/^http:\/\/[\w\d\-\_\.\%\/]*.*\/([\w\d\-\_\.]+\.(flv|mp3|mp4|3gp|wmv))\?.*cdn\_hash.*/){
    $out="http://helpr/media/" . $1;


} else {
$out=$x;
}

if ($X[0] =~ m/^https?\:\/\/.*/) {
	print "OK store-id=$out\n";
} else {
	print $X[0] . " " . "OK store-id=$out\n";
}
}
