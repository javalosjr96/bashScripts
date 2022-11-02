autoCP(){
read -p "LPS Ticket from JIRA: " LPSTicket
read -p "Enter main branch: " branch

commitHashesFull=$(git log $branch --grep=$LPSTicket --oneline)

echo -e "\nCommit List:\n"
echo "$commitHashesFull"
echo -e "\n"

echo "-------Menu-----------"
echo "1: Auto Cherry-Pick(Conflicts are possible)"
echo "2: Create TXT with Only Commit Hashes"
echo "3: Create TXT with Full Commit"
read -p "Enter Selection: " menuNum

if [ $menuNum -eq 1 ]
then
commitHashes=$(git log $branch --format=format:"%H" --grep=$LPSTicket)

arr=($commitHashes)

for commitHash in "${arr[@]}";
  do 
    git cherry-pick $commitHash
  done
fi


if [ $menuNum -eq 2 ]
then
commitHashes=$(git log $branch --format=format:"%H" --grep=$LPSTicket)

arr=($commitHashes)

[ -e "$LPSTicket-commitHashes".txt ] && rm "$LPSTicket-commitHashes".txt

for commitHash in "${arr[@]}";
  do 
    echo  "$commitHash" >> "$LPSTicket-commitHashes".txt
  done
fi

if [ $menuNum -eq 3 ]
then

[ -e "$LPSTicket-fullCommits".txt ] && rm "$LPSTicket-fullCommits".txt

echo  "$commitHashesFull" >> "$LPSTicket-fullCommits".txt

fi

}
