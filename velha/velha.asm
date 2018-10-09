.data

	x: .asciiz "X"
	o: .asciiz "O"
	empty: .asciiz " "
	nl: .asciiz "\n"
	
	col: .asciiz "|"
	
	a1: .byte 0
	a2: .byte 0
	a3: .byte 0
	
	b1: .byte 0
	b2: .byte 0
	b3: .byte 0
	
	c1: .byte 0
	c2: .byte 0
	c3: .byte 0
	
	cont: .byte 0
	
	string1: .asciiz  "Jogador X, digite onde deseja jogar: "
	string2: .asciiz  "Jogador O, digite onde deseja jogar: "
	
	error1: .asciiz "Valor digitado invalido\n"
	error2: .asciiz "Ja existe uma peca nessa posicao\n"
	
	win1: .asciiz "X Ganhou!"
	win2: .asciiz "O Ganhou!"
	
	velha1: .asciiz "Deu velha"
	
.text

	li $s7, 1

.macro printTab_c (%pic)

	beq $s7, 10, setCont
	bne $s7, 10, endSetCont
	
setCont:

	li $s7, 1

endSetCont:
	
	

	beqz %pic, p_e # se 0, imprime vazio
	beq %pic, 1, p_x # se 1, imprime x
	beq %pic, -1, p_o #se 2, imprime 0
	
p_e:
	li $v0, 1
	move $a0, $s7
	syscall
	j exit

#####################

p_x:
	li $v0, 4
	la $a0, x
	syscall
	j exit

####################

p_o:
	li $v0, 4
	la $a0, o
	syscall
	j exit
###################

exit:
	li $t7, 1
	add $s7, $s7, $t7
	

.end_macro

.macro printTab_col #imprime a coluna
	li $v0, 4
	la $a0, col
	syscall
.end_macro 

.macro printTab #imprime o tabuleiro
	
	lb $t7, a1
	printTab_c ($t7) # X
	printTab_col     # X|
	lb $t7, a2
	printTab_c ($t7) # X/X
	printTab_col	 #X|X|
	lb $t7, a3
	printTab_c ($t7) # X/X|X
	
	li $v0, 4
	la $a0, nl
	syscall
	
	lb $t7, b1
	printTab_c ($t7) # X
	printTab_col     # X|
	lb $t7, b2
	printTab_c ($t7) # X/X
	printTab_col	 #X|X|
	lb $t7, b3
	printTab_c ($t7) # X/X|X
	
	li $v0, 4
	la $a0, nl
	syscall
	
	lb $t7, c1
	printTab_c ($t7) # X
	printTab_col     # X|
	lb $t7, c2
	printTab_c ($t7) # X/X
	printTab_col	 #X|X|
	lb $t7, c3
	printTab_c ($t7) # X/X|X
	
	li $v0, 4
	la $a0, nl
	syscall
	
.end_macro

.macro vefInputValue (%val) #verifica se o valor esta no range

	bgt %val, 9, setError
	blt %val, 1, setError
	b endError
	
setError:
	li $v0, 4
	la $a0, error1
	syscall
	li $v1, 1
endError:

.end_macro

.macro vefExistValue(%pos)

	beq %pos, 1, x_a1 #verifica a1
	beq %pos, 2, x_a2 #verifica a2
	beq %pos, 3, x_a3 #verifica a3
	
	beq %pos, 4, x_b1 #verifica b1
	beq %pos, 5, x_b2 #verifica b2
	beq %pos, 6, x_b3 #verifica b3
	
	beq %pos, 7, x_c1 #verifica c1
	beq %pos, 8, x_c2 #verifica c2
	beq %pos, 9, x_c3 #verifica c3
	
	b end_vef
	
x_a1: ###############
	lb $a3, a1
	bne $a3, 0, error_set
	b end_vef
#####################
x_a2:
	lb $a3, a2
	bne $a3, 0, error_set
	b end_vef
######################
x_a3:
	lb $a3, a3
	bne $a3, 0, error_set
	b end_vef
#####################


x_b1: ###############
	lb $a3, b1
	bne $a3, 0, error_set
	b end_vef
#####################
x_b2:
	lb $a3, b2
	bne $a3, 0, error_set
	b end_vef
######################
x_b3:
	lb $a3, b3
	bne $a3, 0, error_set
	b end_vef
#####################

x_c1: ###############
	lb $a3, c1
	bne $a3, 0, error_set
	b end_vef
#####################
x_c2:
	lb $a3, c2
	bne $a3, 0, error_set
	b end_vef
######################
x_c3:
	lb $a3, c3
	bne $a3, 0, error_set
	b end_vef
#####################

error_set:###########

	li $v0, 4
	la $a0, error2
	syscall
	li $v1, 1
#######################
end_vef:
	
.end_macro

.macro x_put (%pos)

	beq %pos, 1, x_a1 #verifica a1
	beq %pos, 2, x_a2 #verifica a2
	beq %pos, 3, x_a3 #verifica a3
	
	beq %pos, 4, x_b1 #verifica b1
	beq %pos, 5, x_b2 #verifica b2
	beq %pos, 6, x_b3 #verifica b3
	
	beq %pos, 7, x_c1 #verifica c1
	beq %pos, 8, x_c2 #verifica c2
	beq %pos, 9, x_c3 #verifica c3
	
	b end_put

##################
x_a1:
	li $t9, 1
	sb $t9, a1
	j end_put
#################

x_a2:
	li $t9, 1
	sb $t9, a2
	j end_put
#################
x_a3:
	li $t9, 1
	sb $t9, a3
	j end_put
#################
x_b1:
	li $t9, 1
	sb $t9, b1
	j end_put
#################

x_b2:
	li $t9, 1
	sb $t9, b2
	j end_put
#################
x_b3:
	li $t9, 1
	sb $t9, b3
	j end_put
#################

x_c1:
	li $t9, 1
	sb $t9, c1
	j end_put
#################

x_c2:
	li $t9, 1
	sb $t9, c2
	j end_put
#################
x_c3:
	li $t9, 1
	sb $t9, c3
	j end_put
#################
end_put:

	lb $t8, cont
	add $t8, $t8, 1
	
	beq $t8, 9, velha
	
	sb $t8, cont
	j end_all
	
velha:
	li $v0, 4
	la $a0, velha1
	syscall
	
	li $v0, 10
	syscall 
	
end_all:

.end_macro

.macro o_put (%pos)

	beq %pos, 1, o_a1 #verifica a1
	beq %pos, 2, o_a2 #verifica a2
	beq %pos, 3, o_a3 #verifica a3
	
	beq %pos, 4, o_b1 #verifica b1
	beq %pos, 5, o_b2 #verifica b2
	beq %pos, 6, o_b3 #verifica b3
	
	beq %pos, 7, o_c1 #verifica c1
	beq %pos, 8, o_c2 #verifica c2
	beq %pos, 9, o_c3 #verifica c3
	
	b end_put
	
##################
o_a1:
	li $t9, -1
	sb $t9, a1
	j end_put
#################

o_a2:
	li $t9, -1
	sb $t9, a2
	j end_put
#################
o_a3:
	li $t9, -1
	sb $t9, a3
	j end_put
#################
o_b1:
	li $t9, -1
	sb $t9, b1
	j end_put
#################

o_b2:
	li $t9, -1
	sb $t9, b2
	j end_put
#################
o_b3:
	li $t9, -1
	sb $t9, b3
	j end_put
#################

o_c1:
	li $t9, -1
	sb $t9, c1
	j end_put
#################

o_c2:
	li $t9, -1
	sb $t9, c2
	j end_put
#################
o_c3:
	li $t9, -1
	sb $t9, c3
	j end_put
#################
end_put:
	lb $t8, cont
	add $t8, $t8, 1
	
	beq $t8, 9, velha
	
	sb $t8, cont
	j end_all
	
velha:
	li $v0, 4
	la $a0, velha1
	syscall
	
	li $v0, 10
	syscall 
	
end_all:
	
	
.end_macro

.macro vefwin #Vefirica se alguem ganhou

	#1---
	lb $s0, a1
	lb $s1, a2
	lb $s2, a3
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin

	#2---
	
	lb $s0, b1
	lb $s1, b2
	lb $s2, b3
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	#3---
	
	lb $s0, c1
	lb $s1, c2
	lb $s2, c3
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	#1|||
	
	lb $s0, a1
	lb $s1, b1
	lb $s2, c1
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	#2|||
	
	lb $s0, a2
	lb $s1, b2
	lb $s2, c2
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	
	#3|||
	
	lb $s0, a3
	lb $s1, b3
	lb $s2, c3
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	#d1
	
	lb $s0, a1
	lb $s1, b2
	lb $s2, c3
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	#d2
	
	lb $s0, a3
	lb $s1, b2
	lb $s2, c1
	
	add $s3, $s0, $s1
	add $s3, $s3, $s2
	
	beq $s3, 3, xWin
	beq $s3, -3, oWin
	
	
	j end_vef
	
	
xWin:

	li $v0, 4
	la $a0, win1
	syscall
	li $v0, 10
	syscall

oWin:

	li $v0, 4
	la $a0, win2
	syscall
	li $v0, 10
	syscall
	
	
end_vef:


.end_macro 
########Inicio Do programa###########

	printTab #imprime o tabuleiro inicial
	
	li $v0, 4
	la $a0, nl
	syscall
	syscall
	
###############################
sInput:

xInput: li $v0, 4
	la $a0, string1
	syscall
	li $v0, 5
	syscall #pede para o x digitar onde quer jogar
	li $v1, 0 #coloca erro como 0, para evitar conflitos
	move $t5, $v0
	vefInputValue ($t5) #verifica se o input esta dentro do range
	vefExistValue ($t5)
	beq $v1, 1, xInput #se nao estiver vai repetir o input
	x_put ($t5)
endxInput:

###########################
	
	vefwin

	printTab
	
	li $v0, 4
	la $a0, nl
	syscall
	syscall
	
##########################

oInput: li $v0, 4
	la $a0, string2
	syscall
	li $v0, 5
	syscall
	li $v1, 0
	move $t5, $v0
	vefInputValue($t5)
	vefExistValue($t5)
	beq $v1, 1, oInput
	o_put ($t5)
endoInput:

###########################
	vefwin

	printTab
	
	li $v0, 4
	la $a0, nl
	syscall
	syscall
	
##########################
	
	j sInput
