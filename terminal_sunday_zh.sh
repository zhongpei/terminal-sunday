#!/bin/bash

RED="\033[41m  \033[0m"
GREEN="\033[42m  \033[0m"
GAP=" "

if [ $# -lt 1 ]; then
  echo "用法: $0 出生日期 [用户名]"
  echo "示例: $0 1985-06-08 Joe"
  exit 1
fi

birthdate=$1
name=${2:-$USER}

life_expectancy=80
last_year_index=$((life_expectancy - 1))

case "$(uname)" in
  "Linux")
    birth_year=$(date -d "$birthdate" +"%Y")
    birth_timestamp=$(date -d "$birthdate" +%s)
    ;;
  "Darwin")
    birth_year=$(date -j -f "%Y-%m-%d" "$birthdate" +"%Y")
    birth_timestamp=$(date -j -f "%Y-%m-%d" "$birthdate" +%s)
    ;;
  *) echo "不支持的操作系统"; exit 1 ;;
esac

current_year=$(date +"%Y")
current_timestamp=$(date +%s)
years_passed=$((current_year - birth_year))
weeks_passed=$(( (current_timestamp - birth_timestamp) / 604800 ))
total_weeks=$((life_expectancy * 52))
weeks_remaining=$((total_weeks - weeks_passed))

echo -e "只剩下 $weeks_remaining 个星期\n"

for (( row=0; row<4; row++ )); do
    for (( col=0; col<20; col++ )); do
        year_index=$((row * 20 + col))
          if (( year_index == 0 )); then
            echo $birth_year
          fi
        if (( year_index < years_passed )); then
            echo -ne "${RED}${GAP}"
        else
            echo -ne "${GREEN}${GAP}"
        fi
    done
    echo
    if (( year_index != $last_year_index )); then
      echo
    fi
done

printf ' %.0s' {1..55}
last_year=$((birth_year + last_year_index))
echo $last_year

echo -e "\n 你打算如何度过这些星期日？"

