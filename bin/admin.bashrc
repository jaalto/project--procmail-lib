# .......................................................................
#
#   $Id: admin.bashrc,v 1.12 2005/02/16 16:07:14 jaalto Exp $
#
#   These bash functions will help uploading files to Sourceforge project.
#   You need:
#
#       Unix        (Unix)  http://www.fsf.org/directory/bash.html
#                   (Win32) http://www.cygwin.com/
#       Perl 5.4+   (Unix)  http://www.perl.org
#                   (Win32) http://www.ativestate.com
#       t2html.pl   Perl program to convert text -> HTML
#                   http://www.cpan.org/modules/by-authors/id/J/JA/JARIAALTO/
#
#
#   This file is of interest only for the Admin or Co-Developer of
#   project.
#
#       http://sourceforge.net/projects/pm-lib
#       http://pm-lib.sourceforge.net/
#
#   Include this file to your $HOME/.bashrc and make the necessary
#   modifications:
#
#       SF_PM_LIB_USER=<sourceforge-login-name>
#       SF_PM_LIB_USER_NAME="FirstName LastName"
#       SF_PM_LIB_ROOT=~/cvs-projects/pm-lib
#       SF_PM_LIB_HTML_TARGET=http://pm-lib.sourceforge.net/
#
#       source ~/sforge/devel/pm-lib/bin/admin.bashrc
#
# .......................................................................

function sfpmlibinit ()
{
    local id="$FUNCNAME"

    local url=http://pm-lib.sourceforge.net/

    SF_PM_LIB_HTML_TARGET=${SF_PM_LIB_HTML_TARGET:-$url}
    SF_PM_LIB_KWD=${SF_PM_LIB_KWD:-"\
procmail, sendmail, programming language, library"}
    SF_PM_LIB_DESC=${SF_PM_LIB_DESC:-"Procmail module library"}
    SF_PM_LIB_TITLE=${SF_PM_LIB_TITLE:-"$SF_PM_LIB_DESC"}
    SF_PM_LIB_ROOT=${SF_PM_LIB_ROOT:-""}

    if [ "$SF_PM_LIB_USER" = "" ]; then
       echo "$id: Identity SF_PM_LIB_USER unknown."
    fi

    if [ "$SF_PM_LIB_USER_NAME" = "" ]; then
       echo "$id: Identity SF_PM_LIB_USER_NAME unknown."
    fi
}

function sfpmlibdate ()
{
    date "+%Y.%m%d"
}

function sfpmlibfilesize ()
{
    #   put line into array ( .. )

    local line
    line=($(ls -l "$1"))

    #   Read 4th element from array
    #   -rw-r--r--    1 root     None         4989 Aug  5 23:37 file

    echo ${line[4]}
}

function sfpmlibscp ()
{
    #   To upload file to project, call from shell prompt
    #
    #       bash$ sfpmlibscp [-d dir] <FILE>

    local sfuser=$SF_PM_LIB_USER
    local sfproject=p/pm/pm-lib

    if [ "$SF_PM_LIB_USER" = "" ]; then
        echo "sfpmlibscp: identity SF_PM_LIB_USER unknown, can't scp files."
        return
    fi

    local dir

    if [ "$1" = "-d" ]; then
        dir=$2
        shift; shift
    fi

    scp $* $sfuser@shell.sourceforge.net:/home/groups/$sfproject/htdocs/$dir
}

function sfpmlib_docupdate ()
{
    local root=$SF_PM_LIB_ROOT
    local master=pm-lib.txt
    local doc=pm-lib.doc.tmp

    cd ${SF_PM_LIB_ROOT:-no-root-defined} ||  return $?
    cd doc/source || return $?

    perl -S ripdoc.pl  $(ls ../../lib/pm-ja*.rc|sort) > $doc
    awk '/Pm-jaaddr/  {exit} {print} ' $master > $master.tmp

    cat $master.tmp $doc > $master && rm -f *.tmp

    echo "Updated $(pwd)/$master"
}

function sfpmlibhtml ()
{
    local id="$FUNCNAME"

    #   To generate HTML documentation located in /doc directory, call
    #
    #       bash$ sfpmlibhtml <FILE.txt>
    #
    #   To generate Frame based documentation
    #
    #        bash$ sfpmlibhtml <FILE.txt> --html-frame
    #
    #   For simple page, like README.txt
    #
    #        bash$ sfpmlibhtml <FILE.txt> --as-is

    local input="$1"
    shift

    if [ "$input" = "" ]; then
        echo "Usage: $id FILE [html-options]"
        return 1
    fi

    if [ ! -f $input ]; then
        echo "$id: No file found [$input]"
        return 1
    fi

    echo "$id: Htmlizing $input $* $size"

    perl -S t2html.pl                                               \
          $*                                                        \
          --button-top "$SF_PM_LIB_HTML_TARGET"                     \
          --title  "$SF_PM_LIB_TITLE"                               \
          --author "$SF_PM_LIB_USER_NAME"                           \
          --meta-keywords "$SF_PM_LIB_KWD"                          \
          --meta-description "$SF_PM_LIB_DESC"                      \
          --name-uniq                                               \
          --Out                                                     \
          $input ||
          return 1

    if [ -d "../../html/"  ]; then
        mv *.html ../../html/
    elif [ -d "../html/"  ]; then
        mv *.html ../html/
    else
        echo "$id: Can't move generated HTML to ../html/"
    fi
}

function sfpmlibhtmlall ()
{
    local id="$FUNCNAME"

    #   loop all *.txt files and generate HTML
    #   If filesize if bigger than 15K, generate Framed HTML page.

    local dir=$SF_PM_LIB_ROOT/doc/tips

    (
        cd $dir || return
        echo "Source dir:" $(pwd)

        for file in *.txt;
        do
             local size=$(sfpmdocfilesize $file)

             if [ $size -gt 15000 ]; then
               opt=--html-frame
             fi

             sfpmdochtml $file $opt

         done
    )
}

function sfpmlib_release ()
{
    local id="$FUNCNAME"

    local dir=/tmp

    if [ ! -d $dir ]; then
        echo "$id: Can't make release. No directory [$dir]"
        return
    fi

    if [ ! -d "$SF_PM_LIB_ROOT" ]; then
        echo "$id: No SF_PM_LIB_ROOT [$SF_PM_LIB_ROOT]"
        return
    fi

    local cmd=gzip
    local opt=-9

    local base=procmail-lib
    local ver=$(sfpmlibdate)
    local tar=$base-$ver.tar
    local dest=$dir/$tar
    local final=$dir/$tar.gz

    if [ -f $final ]; then
        echo "$id: Removing old archive $final"
        rm $final
    fi

    (
        todir=$base-$ver
        tmp=$dir/$todir

        if [ -d $tmp ]; then
            echo "$id: Removing old archive directory $tmp"
            rm -rf $tmp
        fi

        cp -r $SF_PM_LIB_ROOT $dir/$todir

        cd $dir || exit 1

        files=$(find $todir -type f             \
            \( -name "*[#~]*"                   \
               -o -name ".*[#~]"                \
               -o -name ".#*"                   \
               -o -name "*.stack*"              \
               -o -name "*elc"                  \
               -o -name "*tar"                  \
               -o -name "*gz"                   \
               -o -name "*bz2"                  \
               -o -name .cvsignore              \
            \) -prune                           \
            -o -type d \( -name CVS \) -prune   \
            -o -type f -print                   \
            )

        tar cvf $dest $files

        echo "$id: Running $cmd $opt $dest"

        $cmd $opt $dest || exit 1

        echo "$id: Made release $final"
        ls -l $final

        echo "Upload to ftp://upload.sourceforge.net/incoming"

    )
}

sfpmlibinit                     # Run initializer

export SF_PM_LIB_HTML_TARGET
export SF_PM_LIB_KWD
export SF_PM_LIB_DESC
export SF_PM_LIB_TITLE
export SF_PM_LIB_ROOT

# End of file
