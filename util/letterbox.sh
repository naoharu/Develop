#!/bin/bash
#
# letterbox.sh
# ��ʓI�ȃf�W�^���J�����̃A�X�y�N�g��i3:2�j�̉摜���A���^�[�{�b�N�X�Ő����`�ɂ���B
#
# �g����
# ~$ ./letterbox.sh ���͉摜�t�@�C��
#
 
 # ���͉摜�Ɠ��������A1/4�̏c���́A�����щ摜�̐���
 width=`identify -format %w $1`
 tmp_h=` identify -format %h $1`
 height=`expr ${tmp_h} / 4`
 convert -size ${width}x${height} xc:black black_line.jpg
  
  # �摜�̉��ӂɍ����т�����
  convert -quality 100 $1 black_line.jpg -append temp.jpg
   
   # �摜�̏�ӂɍ����т����āA���̓t�@�C�����̐擪��"LB_"�����ďo�͂���
   convert -quality 100 black_line.jpg  temp.jpg -append  "LB_${1}"
    
    # �ꎞ�t�@�C�����폜
    rm black_line.jpg
    rm temp.jpg
