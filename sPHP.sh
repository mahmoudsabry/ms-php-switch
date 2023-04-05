#!/bin/bash

phpversion='php'$(php -r 'echo substr(phpversion(),0,3);')
ver=
for d in /etc/php/* ; do
loopver='php'$(echo "$d" | cut -d'/' -f 4)
    ver+=' '$loopver
if [[ $loopver == $phpversion ]]
then
ver+='*'
selectedversion="$loopver";
fi
done
ver=($ver)
printf "Activated version \033[0;32m$selectedversion\033[0m switch to :\n"
select newPhpVersion in ${ver[@]}
do
if [[ $REPLY>0 && $REPLY<=${#ver[@]} ]]
then
sudo a2dismod $selectedversion && sudo a2enmod $newPhpVersion && sudo update-alternatives --set php /usr/bin/$newPhpVersion && sudo /etc/init.d/apache2 restart
exit
else
echo "Please choose between 1:${#ver[@]}"
fi


done



