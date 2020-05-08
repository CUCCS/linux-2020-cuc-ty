#!/usr/bin/env bash
  
dir=`pwd`
echo $dir

# 对JPEG格式图片压缩
function compress {
  quality=$1
  for img in `ls `
  do
    type=${img##*.}
    echo $type
    if [ $type == "jpg" ];then
      echo "compressing........";
      out=$dir/compress_$img
      convert -quality $quality_num $img $out
    fi
  done
}

# 对jpeg/png/svg格式图片压缩分辨率
function resolution {
  size=$1
  for img in `ls`
  do
    type=${img##*.}
    if [ $type == "jpg" ] || [ $type == "png" ] || [ $type == "svg" ];then
    out=$dir/resize_$img
    echo "resizing......";
    convert -resize $size"x"$size $img $out
    fi
  done

}

# 批量添加自定义文本水印
function watermark {
  color=$1
  size=$2
  text=$3
  for img in `ls`
  do
    type=${img##*.}
    echo $img
    if [ $type == "jpg" ] || [ $type == "png" ] || [ $type == "svg" ];then
    echo "adding......";
    out=$dir/add_${img%.*}.${img##*.}
    convert -fill $color -pointsize $size -draw "text 15,50 '$text'" $img $out
    fi
  done
}



# 批量重命名文件
function rename {
  for img in `ls`
  do
    type=${img##*.}
    if [ $type == "jpg" ] || [ $type == "png" ] || [ $type == "svg" ];then
    echo $img
    out=$dir/in_${img%.*}.${img##*.}
    echo $out
    echo "renaming.....";
    convert $img $out
    fi
  done
}

# 将png/svg格式图片转换为jpg格式图片
function transform {
  for img in `ls`
  do
    type=${img##*.}
    if [ $type == "png" ] || [ $type == "svg" ];then
    out=$dir/type_${img%.*}.jpeg
    echo $out
    echo "transforming......";
    convert $img $out
    fi
  done
}

# 帮助
function helps {
  echo "help informations:"
        echo "-c        对jpeg格式图片进行图片质量压缩"
        echo "-r        对jpeg/png/svg格式图片压缩分辨率"
        echo "-w        对图片批量添加自定义文本水印e"
        echo "-n        对文件批量重命名"
        echo "-t        将png/svg图片统一转换为jpg格式图片"
        echo "-h        查看帮助信息"
}

# 主函数
while [[ "$#" -ne 0 ]]; do
 case $1 in
        "-c")
                        compress $2
                        shift 2;;
        "-r")
                        resolution $2
                        shift 2;;
        
        "-w")
                        watermark $2 $3 $4
                        shift 4;;
        "-t")
                        transform
                        shift;;
        "-n")
                        rename
        "-h")
                        helps
                        shift;;
      shift;;
                esac
done