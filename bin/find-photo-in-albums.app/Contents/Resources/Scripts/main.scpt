FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     �� 	 
��   	 V P Jacques Rioux's script  https://discussions.apple.com/message/29601534#29601534    
 �   �   J a c q u e s   R i o u x ' s   s c r i p t     h t t p s : / / d i s c u s s i o n s . a p p l e . c o m / m e s s a g e / 2 9 6 0 1 5 3 4 # 2 9 6 0 1 5 3 4      l     ��  ��      modified by leonie     �   &   m o d i f i e d   b y   l e o n i e      l     ��  ��      version 2019     �      v e r s i o n   2 0 1 9      l     ��������  ��  ��        l     ��  ��    8 2 Select the photo in Photos, then run this script      �   d   S e l e c t   t h e   p h o t o   i n   P h o t o s ,   t h e n   r u n   t h i s   s c r i p t        l     ��   ��    : 4 ?by pressing the "Run" button in the script editor       � ! ! h  �� b y   p r e s s i n g   t h e   " R u n "   b u t t o n   i n   t h e   s c r i p t   e d i t o r     " # " l     �� $ %��   $ ( " ?or run it from the scripts menu.    % � & & D  �� o r   r u n   i t   f r o m   t h e   s c r i p t s   m e n u . #  ' ( ' l     �� ) *��   ) ] W The script will show first a panel with the filename of the photo it is searching for.    * � + + �   T h e   s c r i p t   w i l l   s h o w   f i r s t   a   p a n e l   w i t h   t h e   f i l e n a m e   o f   t h e   p h o t o   i t   i s   s e a r c h i n g   f o r . (  , - , l     �� . /��   . A ; Then it will show a second panel with the list of albums.     / � 0 0 v   T h e n   i t   w i l l   s h o w   a   s e c o n d   p a n e l   w i t h   t h e   l i s t   o f   a l b u m s .   -  1 2 1 l     �� 3 4��   3 a [ if you do not see the panels, click the script Editor icon in the Dock, if it is bouncing.    4 � 5 5 �   i f   y o u   d o   n o t   s e e   t h e   p a n e l s ,   c l i c k   t h e   s c r i p t   E d i t o r   i c o n   i n   t h e   D o c k ,   i f   i t   i s   b o u n c i n g . 2  6 7 6 l     ��������  ��  ��   7  8 9 8 l    u :���� : O     u ; < ; k    t = =  > ? > I   	������
�� .miscactvnull��� ��� null��  ��   ?  @ A @ l  
 
�� B C��   B _ Y Add the photo you want to search for to a top level album as the first item in the album    C � D D �   A d d   t h e   p h o t o   y o u   w a n t   t o   s e a r c h   f o r   t o   a   t o p   l e v e l   a l b u m   a s   t h e   f i r s t   i t e m   i n   t h e   a l b u m A  E F E l  
 
��������  ��  ��   F  G H G r   
  I J I m   
  K K � L L  S e a r c h i n g   f o r :   J o      ���� 0 resultcaption   H  M N M Q    > O P Q O k    ( R R  S T S l   ��������  ��  ��   T  U V U r     W X W 1    ��
�� 
selc X o      ���� 0 sel   V  Y Z Y l   & [ \ ] [ Z   & ^ _���� ^ =    ` a ` o    ���� 0 sel   a J    ����   _ R    "�� b��
�� .ascrerr ****      � **** b m     ! c c � d d . T h e   s e l e c t i o n     i s   e m p t y��  ��  ��   \   no selection     ] � e e    n o   s e l e c t i o n   Z  f�� f l  ' '��������  ��  ��  ��   P R      �� g h
�� .ascrerr ****      � **** g o      ���� 0 
errtexttwo 
errTexttwo h �� i��
�� 
errn i o      ���� 0 	errnumtwo 	errNumtwo��   Q k   0 > j j  k l k I  0 ;�� m��
�� .sysodlogaskr        TEXT m b   0 7 n o n b   0 5 p q p b   0 3 r s r m   0 1 t t � u u & N o   p h o t o s   s e l e c t e d   s o   1 2���� 0 	errnumtwo 	errNumtwo q o   3 4��
�� 
ret  o o   5 6���� 0 
errtexttwo 
errTexttwo��   l  v�� v L   < >����  ��   N  w x w l  ? ?��������  ��  ��   x  y z y r   ? B { | { m   ? @ } } � ~ ~   u n k n o w n   f i l e n a m e | o      ���� 0 	imagename   z   �  Q   C n � � � � k   F Y � �  � � � l  F L � � � � r   F L � � � n   F J � � � 4   G J�� �
�� 
cobj � m   H I����  � o   F G���� 0 sel   � o      ���� 
0 target   �   the image to seach for    � � � � .   t h e   i m a g e   t o   s e a c h   f o r �  ��� � O   M Y � � � r   Q X � � � l  Q V ����� � n   Q V � � � 1   R V��
�� 
filn � o   Q R���� 
0 target  ��  ��   � o      ���� 0 	imagename   � o   M N���� 
0 target  ��   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 
errtexttwo 
errTexttwo � �� ���
�� 
errn � o      ���� 0 	errnumtwo 	errNumtwo��   � I  a n�� ���
�� .sysodlogaskr        TEXT � b   a j � � � b   a h � � � b   a f � � � m   a d � � � � � X C a n n o t   g e t   t h e   f i l e n a m e   o f   t h e   f i r s t   i m a g e :   � o   d e���� 0 	errnumtwo 	errNumtwo � o   f g��
�� 
ret  � o   h i���� 0 
errtexttwo 
errTexttwo��   �  ��� � r   o t � � � l  o r ����� � b   o r � � � o   o p���� 0 resultcaption   � o   p q���� 0 	imagename  ��  ��   � o      ���� 0 resultcaption  ��   < m      � �r                                                                                  Phts  alis      128GB                          BD ����
Photos.app                                                     ����            ����  
 cu             Applications  /:Applications:Photos.app/   
 P h o t o s . a p p    1 2 8 G B  Applications/Photos.app   / ��  ��  ��   9  � � � l     ��������  ��  ��   �  � � � l  v � ����� � Q   v � � � � � I  y ��� � �
�� .sysodisAaleR        TEXT � o   y z���� 0 resultcaption   � �� � �
�� 
btns � J   } � � �  � � � m   } � � � � � �  C a n c e l �  ��� � m   � � � � � � �  O K��   � �� � �
�� 
as A � m   � ���
�� EAlTinfA � �� ���
�� 
givu � m   � ����� ��   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 errtext errText � �� ���
�� 
errn � o      ���� 0 errnum errNum��   � Z   � � � ����� � l  � � ����� � =  � � � � � o   � ����� 0 errnum errNum � m   � ���������  ��   � k   � � � �  � � � l  � ��� � ���   �   User cancelled.    � � � �     U s e r   c a n c e l l e d . �  ��� � L   � �����  ��  ��  ��  ��  ��   �  � � � l     �� � ���   � #  From Jacques Rioux's script:    � � � � :   F r o m   J a c q u e s   R i o u x ' s   s c r i p t : �  � � � l  �� ����� � O   �� � � � k   �� � �  � � � l  � ��� � ���   �   set sel to selection    � � � � *   s e t   s e l   t o   s e l e c t i o n �  � � � l  � � � � � � Z  � � � ����� � =  � � � � � o   � ����� 0 sel   � J   � �����   � L   � �����  ��  ��   �   no selection     � � � �    n o   s e l e c t i o n   �  � � � Q   � � � � � r   � � � � � n   � � � � � 1   � ���
�� 
ID   � n   � � � � � 4   � ��� �
�� 
cobj � m   � �����  � o   � ����� 0 sel   � o      �� 0 thisid thisId � R      �~ � �
�~ .ascrerr ****      � **** � o      �}�} 0 errtext errText � �| ��{
�| 
errn � o      �z�z 0 errnum errNum�{   � k   � � �  � � � I  � ��y ��x
�y .sysodlogaskr        TEXT � b   � � � � � b   � �   b   � � b   � � m   � � � < E r r o r :   c a n n o t   g e t   t h e   i m a g e   I D o   � ��w�w 0 errnum errNum o   � ��v
�v 
ret  o   � ��u�u 0 errtext errText � m   � � �		  T r y i n g   a g a i n�x   � 

 l  � ��t�s�r�t  �s  �r   �q l  � Q   � k   � �  I  � ��p�o
�p .sysodelanull��� ��� nmbr m   � ��n�n �o   �m r   � � n   � � 1   � ��l
�l 
ID   n   � � 4   � ��k
�k 
cobj m   � ��j�j  o   � ��i�i 0 sel   o      �h�h 0 thisid thisId�m   R      �g 
�g .ascrerr ****      � **** o      �f�f 0 
errtexttwo 
errTexttwo  �e!�d
�e 
errn! o      �c�c 0 	errnumtwo 	errNumtwo�d   k  "" #$# I �b%�a
�b .sysodlogaskr        TEXT% b  &'& b  ()( b  	*+* m  ,, �-- L S k i p p i n g   i m a g e   d u e   t o   r e p e a t e d   e r r o r :  + o  �`�` 0 	errnumtwo 	errNumtwo) o  	
�_
�_ 
ret ' o  �^�^ 0 
errtexttwo 
errTexttwo�a  $ ./. R  �]0�\
�] .ascrerr ****      � ****0 m  11 �22  g i v i n g   u p�\  / 3�[3 L  �Z�Z  �[    second attempt    �44  s e c o n d   a t t e m p t�q   � 565 l �Y�X�W�Y  �X  �W  6 787 r  "9:9 J  �V�V  : o      �U�U 0 
thesenames 
theseNames8 ;�T; Q  #�<=>< r  &F?@? n  &BABA 1  >B�S
�S 
pnamB l &>C�R�QC 6 &>DED 2 &+�P
�P 
IPalE E  .=FGF n  /7HIH 1  37�O
�O 
ID  I 2 /3�N
�N 
IPmiG o  8<�M�M 0 thisid thisId�R  �Q  @ o      �L�L 0 
thesenames 
theseNames= R      �KJK
�K .ascrerr ****      � ****J o      �J�J 0 errtext errTextK �IL�H
�I 
errnL o      �G�G 0 errnum errNum�H  > k  N�MM NON I N_�FP�E
�F .sysodlogaskr        TEXTP b  N[QRQ b  NWSTS b  NUUVU b  NSWXW m  NQYY �ZZ 8 E r r o r :   c a n n o t   g e t   t h e   a l b u m sX o  QR�D�D 0 errnum errNumV o  ST�C
�C 
ret T o  UV�B�B 0 errtext errTextR m  WZ[[ �\\  T r y i n g   a g a i n�E  O ]�A] Q  `�^_`^ k  c�aa bcb I ch�@d�?
�@ .sysodelanull��� ��� nmbrd m  cd�>�> �?  c e�=e r  i�fgf n  i�hih 1  ���<
�< 
pnami l i�j�;�:j 6 i�klk 2 in�9
�9 
IPall E  q�mnm n  rzopo 1  vz�8
�8 
ID  p 2 rv�7
�7 
IPmin o  {�6�6 0 thisid thisId�;  �:  g o      �5�5 0 
thesenames 
theseNames�=  _ R      �4qr
�4 .ascrerr ****      � ****q o      �3�3 0 
errtexttwo 
errTexttwor �2s�1
�2 
errns o      �0�0 0 	errnumtwo 	errNumtwo�1  ` k  ��tt uvu I ���/w�.
�/ .sysodlogaskr        TEXTw b  ��xyx b  ��z{z b  ��|}| m  ��~~ � L S k i p p i n g   i m a g e   d u e   t o   r e p e a t e d   e r r o r :  } o  ���-�- 0 	errnumtwo 	errNumtwo{ o  ���,
�, 
ret y o  ���+�+ 0 
errtexttwo 
errTexttwo�.  v ��� R  ���*��)
�* .ascrerr ****      � ****� m  ���� ���  g i v i n g   u p�)  � ��(� L  ���'�'  �(  �A  �T   � m   � ���r                                                                                  Phts  alis      128GB                          BD ����
Photos.app                                                     ����            ����  
 cu             Applications  /:Applications:Photos.app/   
 P h o t o s . a p p    1 2 8 G B  Applications/Photos.app   / ��  ��  ��   � ��� l     �&�%�$�&  �%  �$  � ��� l ����#�"� Z  �����!�� > ����� o  ��� �  0 
thesenames 
theseNames� J  ����  � k  ���� ��� r  ����� J  ���� ��� 1  ���
� 
txdl� ��� o  ���
� 
ret �  � J      �� ��� o      �� 0 otid oTid� ��� 1  ���
� 
txdl�  � ��� r  ����� J  ���� ��� c  ����� o  ���� 0 
thesenames 
theseNames� m  ���
� 
TEXT� ��� o  ���� 0 otid oTid�  � J      �� ��� o      �� 0 t  � ��� 1  ���
� 
txdl�  � ��� l ������  �   return oTid   � ���    r e t u r n   o T i d�  �!  � r  ����� m  ���� ���  N o   a l b u m� o      �� 0 t  �#  �"  � ��� l ����� I ����

� .miscactvnull��� ��� null�  �
  �  �  � ��� l     �	���	  �  �  � ��� l ���� r  ��� c  ��� b  ��� b  
��� o  �� 0 resultcaption  � m  	�� ��� 8 ,   f o u n d   i t   i n   t h e s e   a l b u m s : 
� o  
�� 0 t  � m  �
� 
TEXT� o      �� 0 resultcaption  �  �  � ��� l �� ��� I �����
�� .JonspClpnull���     ****� o  ���� 0 resultcaption  ��  �   ��  � ��� l 0���� I 0����
�� .sysodlogaskr        TEXT� o  ���� 0 resultcaption  � ����
�� 
btns� J  $�� ���� m  "�� ���  O K��  � �����
�� 
dflt� m  '*�� ���  O K��  � H B you can press the Enter key or the return Key to close the dialog   � ��� �   y o u   c a n   p r e s s   t h e   E n t e r   k e y   o r   t h e   r e t u r n   K e y   t o   c l o s e   t h e   d i a l o g� ���� l 13���� L  13�� o  12���� 0 resultcaption  �   l�onie   � ���    l � o n i e��       ������  � ��
�� .aevtoappnull  �   � ****� �����������
�� .aevtoappnull  �   � ****� k    3��  8��  ���  ��� ��� ��� ��� ��� ��� �����  ��  ��  � ���������� 0 
errtexttwo 
errTexttwo�� 0 	errnumtwo 	errNumtwo�� 0 errtext errText�� 0 errnum errNum� 8 ��� K������ c��� t���� }�������� ��� � ����������������������,1���������Y[~�������������������
�� .miscactvnull��� ��� null�� 0 resultcaption  
�� 
selc�� 0 sel  �� 0 
errtexttwo 
errTexttwo� ������
�� 
errn�� 0 	errnumtwo 	errNumtwo��  
�� 
ret 
�� .sysodlogaskr        TEXT�� 0 	imagename  
�� 
cobj�� 
0 target  
�� 
filn
�� 
btns
�� 
as A
�� EAlTinfA
�� 
givu�� 
�� .sysodisAaleR        TEXT�� 0 errtext errText� ������
�� 
errn�� 0 errnum errNum��  ����
�� 
ID  �� 0 thisid thisId
�� .sysodelanull��� ��� nmbr�� 0 
thesenames 
theseNames
�� 
IPal�  
�� 
IPmi
�� 
pnam
�� 
txdl�� 0 otid oTid
�� 
TEXT�� 0 t  
�� .JonspClpnull���     ****
�� 
dflt�� ��4� r*j O�E�O *�,E�O�jv  	)j�Y hOPW X  �%�%�%j OhO�E�O ��k/E�O� 	�a ,E�UW X  a �%�%�%j O��%E�UO !�a a a lva a a la  W X  �a   hY hO� ��jv  hY hO ��k/a ,E` W MX  a �%�%�%a  %j O lj !O��k/a ,E` W X  a "�%�%�%j O)ja #OhOjvE` $O %*a %-a &[a '-a ,\Z_ @1a (,E` $W aX  a )�%�%�%a *%j O +lj !O*a %-a &[a '-a ,\Z_ @1a (,E` $W X  a +�%�%�%j O)ja ,OhUO_ $jv F*a -,�lvE[�k/E` .Z[�l/*a -,FZO_ $a /&_ .lvE[�k/E` 0Z[�l/*a -,FZOPY 	a 1E` 0O*j O�a 2%_ 0%a /&E�O�j 3O�a a 4kva 5a 6a 7 O� ascr  ��ޭ