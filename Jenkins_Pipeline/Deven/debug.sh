#!/bin/bash

while getopts "z:b:c" opt; do
  case $opt in
    a)
      # 当 -a 选项被指定时执行的逻辑
      echo "Option -a is specified $OPTARG"
      option="A"
      ;;
    b)
      # 当 -b 选项被指定时执行的逻辑
      echo "Option -b is specified with argument: $OPTARG"
      option="B"
      ;;
    c)
      # 当 -c 选项被指定时执行的逻辑
      echo "Option -c is specified"
      option="C"
      ;;
    \?)
      # 当未知选项或无效选项被指定时执行的逻辑
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

option=$1
echo "option : ${option}"

case $option in
  "-A")
    # 执行选项 -a 对应的逻辑
    echo "Executing logic for Option -a"
    ;;
  "-B")
    # 执行选项 -b 对应的逻辑
    echo "Executing logic for Option -b"
    ;;
  "-C")
    # 执行选项 -c 对应的逻辑
    echo "Executing logic for Option -c"
    ;;
esac