#!/bin/bash -x
flip()
{
    if [[ $((RANDOM%2)) == 0 ]]
    then
        echo "h"
    else
        echo "t"
    fi
}
percent() 
{
    array=($@)
    sum=0
    for i in ${array[@]}
    do
        sum=$(($sum+$i))
    done
    declare -a per
    for ((i=0;i<${#array[@]};i++))
    do
        per[i]=$(echo "scale=2;${array[$i]}*100/$sum" | bc)
    done
    echo ${per[@]}
   

}

max ()
{
    status=$(echo "$1 > $2" | bc)
    if [[ $status -ne 0 ]]
    then 
        echo $1
    else
        echo $2
    fi
}

singlet_run()
{
    declare -A singlet
    singlet[heads]=0
    singlet[tails]=0
    n=0
    i=0
    for j in ${!singlet[@]}
    do  
        key_val[$i]=$j
        ((i++))
    done
    while [[ $n -lt 10 ]]
    do
        rslt="$(flip)"
        #echo $rslt
        case "$rslt" in
            "h") 
            n=${singlet[heads]}
            singlet[heads]=$((${singlet[heads]}+1))
            ((n++))
            ;;
            "t")
            n=${singlet[tails]}
            singlet[tails]=$((${singlet[tails]}+1))
            ((n++))
            ;;
        esac
    done
    @echo ${singlet[@]}
    singlet_rslt=($(percent ${singlet[@]}))
    #echo ${singlet_rslt[@]}
    index=0
    mx=0
    for i in ${!singlet_rslt[@]}
    do
        mx=$(max $mx ${singlet_rslt[$i]})
        
        if [[ $mx == ${singlet_rslt[$i]} ]]
        then
            index=$i
        fi
    done
    #echo $mx $index
    echo ${key_val[$index]} "is the winner and percent is $mx"

}
iter=0
while [[ $iter -lt 1 ]]
do
    read -p " enter yout choice 1:singlet 2:doubblet 3:triplet 4:to exit" wish
    case "$wish" in 
        "1")
            echo $(singlet_run);;
	*)
	    echo $Error
   esac 	
done

