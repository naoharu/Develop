#!/bin/bash
#
# 2枚の画像を上下に並べて連結
#
# ~$ ./1x2montage.sh 画像1 画像2 
#
# 出力ファイルの構成（ファイル名：out.jpg）
#
# 画像1
# 画像2
 
 # 画像1の下辺に白線を付ける
 tmp_height=`identify -format %h $1`
 width=`identify -format %w $1`
 height=`expr ${tmp_height} / 200`
 convert -quality 100 $1 -size ${width}x${height} xc:white -append temp1.jpg
  
  #画像1と画像2を縦に連結
  convert -append temp1.jpg $2 out.jpg
