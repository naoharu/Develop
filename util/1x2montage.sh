#!/bin/bash
#
# 2���̉摜���㉺�ɕ��ׂĘA��
#
# ~$ ./1x2montage.sh �摜1 �摜2 
#
# �o�̓t�@�C���̍\���i�t�@�C�����Fout.jpg�j
#
# �摜1
# �摜2
 
 # �摜1�̉��ӂɔ�����t����
 tmp_height=`identify -format %h $1`
 width=`identify -format %w $1`
 height=`expr ${tmp_height} / 200`
 convert -quality 100 $1 -size ${width}x${height} xc:white -append temp1.jpg
  
  #�摜1�Ɖ摜2���c�ɘA��
  convert -append temp1.jpg $2 out.jpg
