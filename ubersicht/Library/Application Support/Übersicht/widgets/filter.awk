#!/usr/bin/awk -f
BEGIN {
  res="";
  prev=0;
  focused=0;
}
{
  if (focused==0 && $1==1)
    focused=$2

  if (res=="")
    res = focused==$2 ? res"["$2":" : res$2":";
  else
    if (prev==$2 )
      res=res"|";
    else if (focused==$2)
      res=res" ["$2":";
    else if (focused!=0 && focused<$2){
      res=res"] "$2":";
      focused=1000
    }
    else
      res=res" "$2":";

  prev = $2;

  $1=$2="";

  if ($3 ~ /Discord/){
    $3=$NF=$(NF-1)="";
    r=$0
  }
  else if ($3 ~ /KeePassXC/){
    $0 ~ "Locked" ? $3=$NF=$(NF-1)=$(NF-2)="" : $3=$NF=$(NF-1)="";
    r=$0
  }
  else if ($3 ~ /System/ && $4 ~ /Preferences/){
    $3=$4="";
    r=$0
  }
  else if ($3 ~ /Spotify/){
    if ($0 ~ /-/ ){
      $3="";
      r=$0
    }
    else
      r=$3
  }
  else if ($3 ~ /FaceTime/){
    if ($0 ~ /with/ ){
      $5=$4=$3="";
      r=$0
    }
    else
      r=$3
  }
  else if ($3 ~ /mpv/){
    $3=$NF=$(NF-1)="";
    r=$0
  }
  else if ($3 ~ /qBittorrent/){
    r=$3
  }
  else if ($3 ~ /zoom.us/){
    $0="";
    r=$0

  }
  else if ($3 ~ /VLC/ || $3 ~ /Finder/){
    $3="";
    r=$0

  }
  else if ($3 ~ /Mail/ || $3 ~ /WhatsApp/ || $3 ~ /Calendar/ || $3 ~ /Safari/ || $3 ~ /Brave/ || $3 ~ /Chromium/ || $3 ~ /Firefox/){
    r=$3
}
else if ($3 ~ /kitty/){
  r=$NF
  }
  else if ($3 ~ /Preview/){
    $3="";
  gsub(/\(page.*\)/,"\b");
  r=$1
}
else
  r=$0

sub(/^[ \t\r\n]+/, "", r);
sub(/[ \t\r\n]+$/, "", r);

res = res""r
}
END {
  if (res!="" && focused!=0 && focused!=1000)
    res=res"]"

  print res

}
