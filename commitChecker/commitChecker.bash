glist(){
  INFP=()
  NOTINFP=()

  fp=$1
  contentList=$2
  IFS=',' read -r -a commitList <<< "$contentList"
  for commit in "${commitList[@]}"; 
  do 
    commitCheck=""
    commitCheck=$(git log $fp --grep=$commit --oneline)
    if [ -z "$commitCheck" ]
    then
      NOTINFP+=("${commit}")
    else
      INFP+=("${commitCheck}")
    fi
  done
  echo ""
  echo  "Tickets not in FP: "
  echo  "Count: "${#NOTINFP[@]}""
    for commit in "${NOTINFP[@]}"; 
    do 
      echo  "$commit"
    done
    echo ""
    echo ""

  echo  "Tickets in FP: "
  echo  "Count: "${#INFP[@]}""
  echo ""
    for commit in "${INFP[@]}"; 
    do 
      echo  "$commit"
    done
}
