#!/bin/sh
OK="\t[\e[92m✓\e[0m]"
KO="\t[\e[91m✗\e[0m]"

DAY=`date +"%d"`
FULLPATH="$OUTPUT_PATH/$OUTPUT_FOLDER"

echo "path:$OUTPUT_PATH"
echo "folder:$OUTPUT_FOLDER"
echo "fullpath:$FULLPATH"
echo "daily:$FULLPATH.$DAY"
echo "build:$BUILD_TYPE"
echo '-----'

if [ ! -z $GIT_REPO ]
then
    echo -n `date +"%F %X"` "Cloning"

    if [ $QUIET='True' ]
        then
            cd /app && git clone --quiet https://"$GIT_USER":"$GIT_TOKEN"@github.com/"$GIT_REPO".git . >/dev/null 2>&1
        else
            cd /app && git clone --quiet https://"$GIT_USER":"$GIT_TOKEN"@github.com/"$GIT_REPO".git .
    fi

    if [ $? -eq 0 ]
    then
        echo -e $OK
    else
        echo -e $KO
    fi
else
        echo `date +"%F %X"` "Cloning not performed (GIT_REPO missing)"
fi

echo -n `date +"%F %X"` "Updating"
if [ $QUIET='True' ]
    then
        npm update --silent >/dev/null 2>&1
    else
        npm update
fi
if [ $? -eq 0 ]
then
    echo -e $OK
else
    echo -e $KO
fi

if [ -d $OUTPUT_PATH ]
then
    echo -n `date +"%F %X"` "Building"

    if [ $QUIET='True' ]
    then
        cd /app && ng build --configuration=$BUILD_TYPE --outputPath="$FULLPATH.$DAY" >/dev/null 2>&1
    else
        cd /app && ng build --configuration=$BUILD_TYPE --outputPath="$FULLPATH.$DAY"
    fi

    if [ $? -eq 0 ]
    then
        echo -e $OK
    else
        echo -e $KO
    fi

    # We remove the old symlink & We create the new symlink
    echo -n `date +"%F %X"` "Linking"
    cd $OUTPUT_PATH
    rm -f "$OUTPUT_FOLDER"
    ln -s "$OUTPUT_FOLDER.$DAY" $OUTPUT_FOLDER

    if [ $? -eq 0 ]
    then
        echo -e $OK
    else
        echo -e $KO
    fi
else
    echo `date +"%F %X"` "Building not performed (OUTPUT_PATH not found)"
fi
echo `date +"%F %X"` "We're done"
