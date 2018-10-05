.data

	x: .asciiz "X"
	o: .asciiz "O"
	empty: .asciiz " "
	nl: .asciiz "\n"
	
	col: .asciiz "|"
	
	a1: .byte -1
	a2: .byte 1
	a3: .byte 1
	
	b1: .byte 1
	b2: .byte 1
	b3: .byte 1
	
	c1: .byte 1
	c2: .byte 1
	c3: .byte 0
	
	string1: .asciiz  "Jogador X, digite onde deseja jogar: "
	string2: .asciiz  "Jogador O, digite onde deseja jogar: "
	
	error1: .asciiz "Valor digitado invalido\n"
	error2: .asciiz "Ja existe uma peca nessa posicao\n"
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


.end_macro 

########Inicio Do programa###########

	printTab #imprime o tabuleiro inicial
	
	li $v0, 4
	la $a0, nl
	syscall
	syscall
	
###############################

xInput: li $v0, 4
	la $a0, string1
	syscall
	li $v0, 5
	syscall #pede para o x digitar onde quer jogar
	li $v1, 0 #coloca erro como 0, para evitar conflitos
	move $t5, $v0
	vefInputValue ($t5) #verifica se o input esta dentro do range
	vefExistValue ($t5)
	beq $v1, 1, xInput #se nao estiver vai repetir a operação
endxInput:

###########################



	li $v0, 4
	la $a0, x
	syscall 

	

	
	
	
	
