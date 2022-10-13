patcherRevert(){
  buildMarker=.lfrbuild-portal
  currentCommit=$(git rev-parse HEAD)
  revert=0
  ARRAY=()
  read -p "Enter Fix Pack: " baseline
  for modpath in $(git diff --name-only $baseline $currentCommit);
  do 
    tmp2=${modpath%/src*}
    ARRAY+=(${tmp2})
  done
  UNIQARRAY=($(for modpath in "${ARRAY[@]}"; do echo "${modpath}"; done | sort -u))
  rootRepo=$(pwd)
  for modpath in "${UNIQARRAY[@]}"; 
    do 
    modDir=$rootRepo/$modpath
    cd $modDir
    if test -f "$buildMarker"; then
      continue
    else
    revert=1
    echo "$buildMarker does not exist in "$modpath 
    echo "Reverting Mod"
    git checkout $baseline -- $modDir
    fi
    done
    cd $rootRepo
    if [ $revert == 0 ];then
      echo "No forbidden changes detected"
    else
        git status
        read -p "Forbidden modules have been reverted, create Revert Changes for Patcher commit? (y/n) " ANSWER
        if [ $ANSWER != 'y' ] && [ $ANSWER != 'Y' ]; then
        return
        else
        git add --all
        git commit -m "Revert Change for Patcher"
  fi
  fi
}
