#!/bin/bash
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

doublet_run()
{

    declare -A doubblet
    doubblet[hh]=0
    doubblet[ht]=0
    doubblet[th]=0
    doubblet[tt]=0
    n=0
    i=0
    for j in ${!doubblet[@]}
    do  
        key_val[$i]=$j
        ((i++))
    done
    while [[ $n -lt 10 ]]
    do
        rslt="$(flip),$(flip)"
        #echo $rslt
        case "$rslt" in
            "h,h") 
            n=${doubblet[hh]}
            doubblet[hh]=$((${doubblet[hh]}+1))
            ((n++))
            ;;
            
            "h,t") 
            n=${doubblet[ht]}
            doubblet[ht]=$((${doubblet[ht]}+1))
            ((n++))
            ;;
            
            "t,h") 
            n=${doubblet[th]}
            doubblet[th]=$((${doubblet[th]}+1))
            ((n++))
            ;;
            
            "t,t") 
            n=${doubblet[tt]}
            doubblet[tt]=$((${doubblet[tt]}+1))
            ((n++))
            ;;
        esac
    done
    #echo ${doubblet[@]}
    doubler_rslt=($(percent ${doubblet[@]}))
    #echo ${doubler_rslt[@]}
    index=0
    mx=0
    for i in ${!doubler_rslt[@]}
    do
        mx=$(max $mx ${doubler_rslt[$i]})
        
        if [[ $mx == ${doubler_rslt[$i]} ]]
        then
            index=$i
        fi
    done
    #echo $mx $index
    echo ${key_val[$index]} "is the winner and percent is $mx"
}


triplet_run()
{
    declare -A triplet
    triplet[hhh]=0
    triplet[hht]=0
    triplet[hth]=0
    triplet[thh]=0
    triplet[htt]=0
    triplet[tht]=0
    triplet[tth]=0
    triplet[ttt]=0

    n=0
    i=0
    for j in ${!triplet[@]}
    do  
        key_val[$i]=$j
        ((i++))
    done
    while [[ $n -lt 10 ]]
    do
        rslt="$(flip),$(flip),$(flip)"
        #echo $rslt
        case "$rslt" in
            "h,h,h")
            n=triplet[hhh]
            triplet[hhh]=$((${triplet[hhh]}+1))
            ((n++))
            ;;
            "h,h,t")
            n=triplet[hht]
            triplet[hht]=$((${triplet[hht]}+1))
            ((n++))
            ;;
            
            "h,t,h")
            n=triplet[hth]
            triplet[hth]=$((${triplet[hth]}+1))
            ((n++))
            ;;

            "t,h,h")
            n=triplet[thh]
            triplet[thh]=$((${triplet[thh]}+1))
            ((n++))
            ;;
            
            "h,t,t")
            n=triplet[htt]
            triplet[htt]=$((${triplet[htt]}+1))
            ((n++))
            ;;

            "t,h,t")
            n=triplet[tht]
            triplet[tht]=$((${triplet[tht]}+1))
            ((n++))
            ;;


            "t,t,h")
            n=triplet[tth]
            triplet[tth]=$((${triplet[tth]}+1))
            ((n++))
            ;;

            "t,t,t")
            n=triplet[ttt]
            triplet[ttt]=$((${triplet[ttt]}+1))
            ((n++))
            ;;
        esac
    done
iter=0
while [[ $iter -lt 1 ]]
do
    read -p " enter yout choice 1:singlet 2:doubblet 3:triplet 4:to exit" wish
    case "$wish" in 
        "1")
            echo $(singlet_run)
        ;;
        "2")
            echo $(doublet_run)
        ;;
        "3")
        echo $(triplet_run)
        ;;
        "4")
            iter=$wish
    esac
done
