#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /var/plexguide/pgtrakt

# FUNCTIONS START ##############################################################

# FIRST FUNCTION
variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

deploycheck() {
  dcheck=$(systemctl is-active traktarr)
  if [ "$dcheck" == "active" ]; then
    dstatus="✅ DEPLOYED"
  else dstatus="⚠️ NOT DEPLOYED"; fi
}

sonarrcheck() {
  pcheck=$(docker ps | grep "\<sonarr\>")
  if [ "$pcheck" == "" ]; then

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Sonarr is not Installed/Running! Cannot Proceed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
    question1
  fi
}

radarrcheck() {
  pcheck=$(docker ps | grep "\<radarr\>")
  if [ "$pcheck" == "" ]; then

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Radarr is not Installed/Running! Cannot Proceed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
    question1
  fi
}

squality() {
  sonarrcheck
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Sonarr Profile
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Type a profile that exists! Check Sonarr's Profiles incase! This is
case senstive! If you mess this up, it will put invalid profiles that do
not exist within Sonarr!

Default Profiles for Sonarr (case senstive):

Any
SD
HD-720p
HD-1080p
Ultra-HD
HD - 720p/1080p
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Go Back? Type > exit

EOF
  read -p '↘️ Type Sonarr Location | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Sonarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Set Is: $typed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    echo "$typed" >/var/plexguide/pgtrak.sprofile
    read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
    question1
  fi

}

rquality() {
  radarrcheck
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Radarr Profile
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Type a profile that exists! Check Raddar's Profiles incase! This is
case senstive! If you mess this up, it will put invalid profiles that do
not exist within Radarr!

Default Profiles for Radarr (case senstive):

Any
SD
HD-720p
HD-1080p
Ultra-HD
HD - 720p/1080p
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Go Back? Type > exit

EOF
  read -p '↘️ Type Radarr Location | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Radarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Set Is: $typed

EOF

    echo "$typed" >/var/plexguide/pgtrak.rprofile
    read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
    question1
  fi

}

api() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Trakt API-Key
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must retrieve your API Key! Prior to
continuing, please follow the current steps.

[ 1 ] Visit - https://trakt.tv/oauth/applications
[ 2 ] Click - New Applications
[ 3 ] Name  - Whatever You Like
[ 4 ] Redirect UI - https://google.com
[ 5 ] Permissions - Click /checkin and /scrobble
[ 6 ] Click - Save App
[ 7 ] Copy the Client ID & Secret for the Next Step!

Go Back? Type > exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️ Type API Client | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/pgtrak.client
  read -p '↘️ Type API Secret | Press [ENTER]: ' typed </dev/tty
  echo $typed >/var/plexguide/pgtrak.secret

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Traktarr API Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: The API Client and Secret is set! Ensure to setup your <paths> and
<profiles> prior to deploying Traktarr.

INFO: Messed up? Rerun this API Interface to update the information!

EOF

    read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
    question1
  fi

}

spath() {
hdpath=$(cat /var/plexguide/server.hd.path)
tvfolderprint=$(ls $hdpath/unionfs/ | grep -E 'TV*|tv')
  sonarrcheck
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Sonarr Path
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must set the PATH to where Sonarr is
actively scanning your tv shows.

Examples:

Possible TV folder

$hdpath/unionfs/ + 

$tvfolderprint
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Go Back? Type > exit

EOF
  read -p '↘️ Type Sonarr Location | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking Path $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    ##################################################### TYPED CHECKERS - START
    typed2=$typed
    bonehead=no
    ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
    initial="$(echo $typed | head -c 1)"
    if [ "$initial" != "/" ]; then
      typed="/$typed"
    fi
    ##### If BONEHEAD added a / at the end, we fix for them
    initial="${typed: -1}"
    if [ "$initial" == "/" ]; then
      typed=${typed::-1}
    fi

    ##################################################### TYPED CHECKERS - START
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking if Location is Valid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    mkdir $typed/test 1>/dev/null 2>&1

    file="$typed/test"
    if [ -e "$file" ]; then

      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Sonarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

      ### Removes /mnt if /mnt/unionfs exists
      #check=$(echo $typed | head -c 12)
      #if [ "$check" == "/mnt/unionfs" ]; then
      #typed=${typed:4}
      #fi

      echo "$typed" >/var/plexguide/pgtrak.spath
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      echo ""
      question1
    else
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ ALERT: Path $typed DOES NOT Exist! No Changes Made!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Note: Exiting the Process! You must ensure that linux is able to READ
your location.

Advice: Exit PTS and (Test) Type >>> mkdir $typed/testfolder

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      echo "" && question1
    fi
  fi

}

rpath() {
hdpath=$(cat /var/plexguide/server.hd.path)
moviefolderprint=$(ls $hdpath/unionfs/ | grep -E  'Movi*|movi*')

  radarrcheck
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Radarr Path
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must set the PATH to where Radarr is
actively scanning your movies.

Possible Movie folder

$hdpath/unionfs/ + 

$moviefolderprint


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Go Back? Type > exit

EOF
  read -p '↘️ Type Radarr Location | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then
    question1
  else
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking Path $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    ##################################################### TYPED CHECKERS - START
    typed2=$typed
    bonehead=no
    ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
    initial="$(echo $typed | head -c 1)"
    if [ "$initial" != "/" ]; then
      typed="/$typed"
    fi
    ##### If BONEHEAD added a / at the end, we fix for them
    initial="${typed: -1}"
    if [ "$initial" == "/" ]; then
      typed=${typed::-1}
    fi

    ##################################################### TYPED CHECKERS - START
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking if Location is Valid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 1.5

    mkdir $typed/test 1>/dev/null 2>&1

    file="$typed/test"
    if [ -e "$file" ]; then

      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Radarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
      echo "$typed" >/var/plexguide/pgtrak.rpath
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      echo ""
      question1
    else
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ ALERT: Path $typed DOES NOT Exist! No Changes Made!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Note: Exiting the Process! You must ensure that linux is able to READ
your location.

Advice: Exit PTS and (Test) Type >>> mkdir $typed/testfolder

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      echo "" && question1
    fi
  fi

}
maxyear() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Limit of max allowed Year
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Set a Number from [ 1900 ] - [ 2100 ]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty
  if [[ "$typed" -ge "1900" && "$typed" -le "2100" ]]; then
    echo "$typed" >/var/plexguide/pgtrakyear.max && question1
  else badinput; fi
}

credits(){
clear
chk=$(figlet traktarr | lolcat )
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 traktarr Credits 
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$chk

#########################################################################
# Author:   l3uddz                                                      #
# URL:      https://github.com/l3uddz/l3uddz/traktarr                   #
# Coder of l3uddz/traktarr                                              #
# --                                                                    #
# Author(s):     l3uddz, desimaniac                                     #
# URL:           https://github.com/cloudbox/cloudbox                   #
# Coder of l3uddz/traktarr role                                         #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

 echo
  read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
  question1
}

# BAD INPUT
badinput() {
  echo
  read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed </dev/tty
  question1
}

# FIRST QUESTION
question1() {

  api=$(cat /var/plexguide/pgtrak.secret)
  if [ "$api" == "NOT-SET" ]; then api="NOT-SET"; else api="SET"; fi

  rpath=$(cat /var/plexguide/pgtrak.rpath)
  spath=$(cat /var/plexguide/pgtrak.spath)
  rprofile=$(cat /var/plexguide/pgtrak.rprofile)
  sprofile=$(cat /var/plexguide/pgtrak.sprofile)
  mxyear=$(cat /var/plexguide/pgtrakyear.max)
  deploycheck

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Traktarr Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Changes Made? Must Redeploy Traktarr when Complete!

[1] Trakt API-Key                       [ $api ]
[2] Sonarr Path                         [ $spath ]
[3] Raddar Path                         [ $rpath ]
[4] Sonarr Profile                      [ $sprofile ]
[5] Radarr Profile                      [ $rprofile ]
{6] Max Year allowed                    [ $mxyear ]

[7] Deploy Traktarr                     [ $dstatus ]

[C] Credits

[Z] - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)
    api
	question1
	;;
  2)
    spath
	question1
	;;
  3)
    rpath
	question1
	;;
  4)
    squality
	question1
	;;
  5)
    rquality
	question1
	;;
  6)
    maxyear
	question1
	;;
  7)
    sonarr=$(docker ps | grep "sonarr")
    radarr=$(docker ps | grep "radarr")

    if [ "$radarr" == "" ] && [ "$sonarr" == "" ]; then
      tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Sonarr or Radarr must be Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

      read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
      echo
      question1
    else

      if [ "$sonarr" = "" ]; then
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Traktarr will only work for movies! Sonarr Not Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
        echo
      fi

      if [ "$radarr" = "" ]; then
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Traktarr will only work for shows! Radarr Not Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        read -p '🌎 Acknowledge Info | Press [ENTER] ' typed </dev/tty
        echo
      fi

      file="/opt/appdata/radarr/config.xml"
      if [ -e "$file" ]; then
        info=$(cat /opt/appdata/radarr/config.xml)
        info=${info#*<ApiKey>} 1>/dev/null 2>&1
        info1=$(echo ${info:0:32}) 1>/dev/null 2>&1
        echo "$info1" >/var/plexguide/pgtrak.rapi
      fi

      file="/opt/appdata/sonarr/config.xml"
      if [ -e "$file" ]; then
        info=$(cat /opt/appdata/sonarr/config.xml)
        info=${info#*<ApiKey>} 1>/dev/null 2>&1
        info2=$(echo ${info:0:32}) 1>/dev/null 2>&1
        echo "$info2" >/var/plexguide/pgtrak.sapi
      fi
    fi
    ansible-playbook /opt/plexguide/menu/traktarr/traktarr.yml
	question1
	;;
  C)
	credits
	clear
	question1
	;;
  c)		
	credits
	clear
	question1
	;;
  z)
    exit
    ;;
  Z)
    exit
    ;;
  *)
    question1
    ;;
  esac
}

# FUNCTIONS END ##############################################################

variable /var/plexguide/pgtrak.client "NOT-SET"
variable /var/plexguide/pgtrak.secret "NOT-SET"
variable /var/plexguide/pgtrak.rpath "NOT-SET"
variable /var/plexguide/pgtrak.spath "NOT-SET"
variable /var/plexguide/pgtrak.sprofile "NOT-SET"
variable /var/plexguide/pgtrak.rprofile "NOT-SET"
variable /var/plexguide/pgtrak.rprofile "NOT-SET"
variable /var/plexguide/pgtrakyear.max "NOT-SET"

deploycheck
question1