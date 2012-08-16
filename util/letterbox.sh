#!/bin/bash
#
# letterbox.sh
# 一般的なデジタルカメラのアスペクト比（3:2）の画像を、レターボックスで正方形にする。
#
# 使い方
# ~$ ./letterbox.sh 入力画像ファイル
#
 
# 入力画像と同じ横幅、1/4の縦幅の、黒い帯画像の生成
width=`identify -format %w $1`
tmp_h=` identify -format %h $1`
height=`expr ${tmp_h} / 4`
convert -size ${width}x${height} xc:black black_line.jpg
 
# 画像の下辺に黒い帯をつける
convert -quality 100 $1 black_line.jpg -append temp.jpg
 
# 画像の上辺に黒い帯をつけて、入力ファイル名の先頭に"LB_"をつけて出力する
convert -quality 100 black_line.jpg  temp.jpg -append  "LB_${1}"
 
# 一時ファイルを削除
rm black_line.jpg
rm temp.jpg