#!/bin/bash

__ScriptVersion="version"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -G|no-git     Don't update git repos"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

do_git=true
foo=true

while getopts ":hGF" opt
do
    case ${opt} in

        h|help     )  usage; exit 0   ;;

        G|no-git   ) do_git=false ;;
        F|no-foo   ) foo=false ;;

        * )  echo -e "\n  Option does not exist : OPTARG\n"; usage; exit 1   ;;

    esac    # --- end of case ---
done

if $do_git; then
    echo "update repos"
else
    echo "no update repos"
fi

if $foo; then
    echo "update foo"
else
    echo "no update foo"

fi
