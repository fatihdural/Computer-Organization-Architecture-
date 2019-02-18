.data  
fileinput: .asciiz "input_hw1.txt"      # islem yapilacak dosya ismi.
buffer: .space 256 			# 256 bytelik yer olusturulur.

buf0:  .asciiz "zero"			# rakamlarin cevirimi icin karsiliklari stringler olusturulur.
buf1:  .asciiz "one"
buf2:  .asciiz "two"
buf3:  .asciiz "three"
buf4:  .asciiz "four"
buf5:  .asciiz "five"
buf6:  .asciiz "six"
buf7:  .asciiz "seven"
buf8:  .asciiz "eight"
buf9:  .asciiz "nine"

buf00:  .asciiz "Zero"			# buyuk harf icin de olusturulur.
buf11:  .asciiz "One"
buf22:  .asciiz "Two"
buf33:  .asciiz "Three"
buf44:  .asciiz "Four"
buf55:  .asciiz "Five"
buf66:  .asciiz "Six"
buf77:  .asciiz "Seven"
buf88:  .asciiz "Eight"
buf99:  .asciiz "Nine"

.text
.globl main				# main tanimlanir.
j main

procedure:			
beq $a0, '0', Label0			# donusturulmesi gereken rakamlar icin bir fonksiyon yazdik.
j Labell0				# bu fonksiyon alinan rakami tanir ve karsiligi olan stringi ekrana basar.
Label0:
beq $s1, 48, L0F			# eger metnin ilk harfiyse direk buyuk yazilir. jumplar ile fonksiyondan cikilir.
lb $a3,-2($a1)				
bne $a3, 46, L0				# noktadan sonra da buyuk yazar.
L0F:
la $a0, buf00
li $v0, 4				
syscall
j Labell0
L0:
la $a0, buf0
li $v0, 4
syscall
Labell0:

beq $a0, '1', Labelx
j Labelly
Labelx:
beq $s1, 48, L1F
lb $a3,-2($a1)
bne $a3, 46, L1
L1F:
la $a0, buf11
li $v0, 4
syscall
j Labelly
L1:
la $a0, buf1
li $v0, 4
syscall
Labelly:

beq $a0, '2', Label2
j Labell2
Label2:
beq $s1, 48, L2F
lb $a3,-2($a1)
bne $a3, 46, L2
L2F:
la $a0, buf22
li $v0, 4
syscall
j Labell2
L2:
la $a0, buf2
li $v0, 4
syscall
Labell2:

beq $a0, '3', Label3
j Labell3
Label3:
beq $s1, 48, L3F
lb $a3,-2($a1)
bne $a3, 46, L3
L3F:
la $a0, buf33
li $v0, 4
syscall
j Labell3
L3:
la $a0, buf3
li $v0, 4
syscall
Labell3:

beq $a0, '4', Label4
j Labell4
Label4:
beq $s1, 48, L4F
lb $a3,-2($a1)
bne $a3, 46, L4
L4F:
la $a0, buf44
li $v0, 4
syscall
j Labell4
L4:
la $a0, buf4
li $v0, 4
syscall
Labell4:

beq $a0, '5', Label5
j Labell5
Label5:
beq $s1, 48, L5F
lb $a3,-2($a1)
bne $a3, 46, L5
L5F:
la $a0, buf55
li $v0, 4
syscall
j Labell5
L5:
la $a0, buf5
li $v0, 4
syscall
Labell5:

beq $a0, '6', Label6
j Labell6
Label6:
beq $s1, 48, L6F
lb $a3,-2($a1)
bne $a3, 46, L6
L6F:
la $a0, buf66
li $v0, 4
syscall
j Labell6
L6:
la $a0, buf6
li $v0, 4
syscall
Labell6:

beq $a0, '7', Label7
j Labell7
Label7:
beq $s1, 48, L7F
lb $a3,-2($a1)
bne $a3, 46, L7
L7F:
la $a0, buf77
li $v0, 4
syscall
j Labell7
L7:
la $a0, buf7
li $v0, 4
syscall
Labell7:

beq $a0, '8', Label8
j Labell8
Label8:
beq $s1, 48, L8F
lb $a3,-2($a1)
bne $a3, 46, L8
L8F:
la $a0, buf88
li $v0, 4
syscall
j Labell8
L8:
la $a0, buf8
li $v0, 4
syscall
Labell8:

beq $a0, '9', Label9
j Labell9
Label9:
beq $s1, 48, L9F
lb $a3,-2($a1)
bne $a3, 46, L9
L9F:
la $a0, buf99
li $v0, 4
syscall
j Labell9
L9:
la $a0, buf9
li $v0, 4
syscall
Labell9:

jr $ra

main:

li $s1,48
li   $v0, 13      	# dosya acilir.
la   $a0, fileinput    
li   $a1, 0       
li   $a2, 0        
syscall            
move $s0, $v0      

li   $v0, 14      	# dosya okunur.
move $a0, $s0     
la   $a1, buffer   
li   $a2,  256 
syscall           

li $s4, 47		# rakamlar ascii karakter araciligiyla tanýnacagindan, kiyaslama amaciyla iki register assign edilir.
li $s5, 58

loop:   		# dongu girisi.
lb $a0,0($a1)
beq $a0, 0, out

slt $t0, $a0, $s5 	# $a0, $s5 den kücükse 
bne $t0, $zero, L
beq $t0, 0, X

L:
slt $t0, $s4, $a0 	# $a0, $s4 den büyükse 
beq $t0, 0, X		# Yani byte olarak okunan karakter ascii rakam aralýgýnda ise fonksiyona gondererek yazi halinde yaziyoruz.
bne $t0, $zero, F

F: 			# Algoritmama gore okunan byte taninir ve fonksiyona gonderilir.
beq $s1, 48, A
lb $a3,-1($a1)
bne $a3, 32, X
beq $a3, 32, A

A: lb $a3, 1($a1)
beq $a3, 46, B
bne $a3, 32, X

C:
jal procedure
j Z

B:
lb $a3, 2($a1)
beq $a3, 32, C
beq $a3, 0, C

X: 
li $v0, 11
syscall

Z:
addi $a1,$a1,1 	# bir sonraki karakteri okumak icin adresi arttir.
addi $s1,$s1,1
j loop		# dongu saglayacak atlayici.
out:		# dongu ve dosyanin bitisi. Exit.
