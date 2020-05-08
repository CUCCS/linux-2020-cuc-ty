#!/usr/bin/env bash

# 统计不同年龄区间范围的球员数量和百分比
function age {
  count_0_20=0
  count_20_30=0
  count_30_=0
  i=0
  for i in ${age[@]};do
    if [ $i -lt 20 ]
    then
    ((count_0_20++))
    elif [ $i -gt 30 ]
    then
    ((count_20_30++))
    else
    ((count_30_++))
    fi
  done
 
  printf "20岁以下的球员有%-5d个，占百分比%-10.6f%% \n" $count_0_20 $(echo "scale=10; $count_0_20/$count*100" | bc -l| awk '{printf "%f", $0}') 
  printf "20-30岁的球员有%-5d个，占百分比%-10.6f%% \n" $count_20_30 $(echo "scale=10;$count_20_30/$count*100" |bc -l | awk '{printf "%f",$0}')
  printf "30岁以上的球员有%-5d个，占百分比%-10.6f%% \n" $count_30_ $(echo "scale=10;$count_30_/$count*100" |bc -l | awk '{printf "%f",$0}')
}

# 计算不同场上位置的球员数量和百分比
function position {
  array=($(awk -vRS=' ' '!a[$1]++' <<< ${position[@]})) 
  echo ${array[@]}
  i=0
  declare -A member
  for((i=0;i<${#array[@]};i++))
  {
    m=${array[$i]}
    member["$m"]=0
  }
  for each in ${position[@]};do
    case $each in
    ${array[0]})
    ((member["${array[0]}"]++));;
    ${array[1]}) 
    ((member["${array[1]}"]++));;
    ${array[2]}) 
    ((member["${array[2]}"]++));;
    ${array[3]}) 
    ((member["${array[3]}"]++));;
    ${array[4]})
    ((member["${array[4]}"]++));;
    esac
  done
  for((i=0;i<${#array[@]};i++))
  {
    temp=${member["${array[$i]}"]}
    printf "%-10s : %10d %10.8f %% \n" ${array[$i]} $temp $(echo "scale=10; $temp/$count*100" | bc -l| awk '{printf "%f", $0}')
  }
}

# 统计名字最长和最短的球员
function name_length {
  i=0
  longest_name=0
  shortest_name=100
  while [[ i -lt $count ]];do
    name=${player[$i]//\*/}
    n=${#name}
    if [[ n -gt longest_name ]];then
      longest_name=$n
      longest_num=$i
    elif [[ n -lt shortest_name ]];then
      shortest_name=$n
      shortest_num=$i
    fi
    ((i++))
  done
  # echo $longest_num
  # echo $shortest_num
  echo "名字最长的球员是 ${player[longest_num]//\*/ }"
  echo "名字最短的球员是 ${player[shortest_num]}"
}

# 统计年龄最大和最小的球员
function old {
  oldest=0
  youngest=100
  i=0
  while [[ i -lt $count ]];do
    a=age[$i]
    if [[ a -lt $youngest ]];then
      youngest=$a
      max_num=$i
    elif [[ a -gt $oldest ]];then
      oldest=$a
      min_num=$i
    fi
    ((i++))
  done
  # echo $max_num
  # echo $min_num
  echo "年龄最大的球员是 ${player[max_num]//\*/ }"
  echo "年龄最小的球员是 ${player[min_num]//\*/ }"
}



# 主程序
count=0	
#按行读取文件
while read line
do
((count++))
if [ $count -gt 1 ];then
  str=(${line// /*})	
  position[$(($count-2))]=${str[4]}
  age[$(($count-2))]=${str[5]}
  player[$(($count-2))]=${str[8]}
fi
done < worldcupplayerinfo.tsv
count=$(($count-1))
echo "数组元素个数为: $count"
echo "......"
age
echo "......"
position
echo "......"
name_length
echo "......"
old

