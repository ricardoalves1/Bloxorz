?-

G_mapa = "",
G_botoes = "",
G_Mapaxy = 16,
G_lermp = 1,
G_Nvl = 0,
G_Movimentos = 0,

%*********Bloco*********

G_Bloco is bitmap_image("../imagens/bloco.bmp", "../imagens/b-movel-mask.bmp"),
G_Final is bitmap_image("../imagens/fim.bmp", "../imagens/fim-mask.bmp"),
G_Bmovel is bitmap_image("../imagens/b-movel.bmp", "../imagens/b-movel-mask.bmp"),
G_Botao1 is bitmap_image("../imagens/botao1.bmp", "../imagens/botao1-mask.bmp"),
G_Botao2 is bitmap_image("../imagens/botao2.bmp", "../imagens/botao1-mask.bmp"),
G_Bloco_X = 630,
G_Bloco_Y = 50,
G_Count = 0,

%*******Caixa*********

G_Caixa0 is bitmap_image("../imagens/caixa-0.bmp", "../imagens/caixa-0mask.bmp"),
G_Caixa1 is bitmap_image("../imagens/caixa-1.bmp", "../imagens/caixa-1mask.bmp"),
G_Caixa2 is bitmap_image("../imagens/caixa-2.bmp", "../imagens/caixa-2mask.bmp"),
G_Caixa_T = 1,
G_Caixa_X = 0,
G_Caixa_Y = 0,
G_Lcaixa = 0,
G_Ccaixa = 0,

G_Aux = 0,
G_Cont = 0,
G_Pos_str = 0,

%*************************************************************
window( title("Bloxorz"), size(950, 600), paint_indirectly, not(clean_before_paint)).

win_func(paint):-
    	mostrar().

win_func(init):-
	window_brush(_,rgb(100,50,255)),
	menu( pop_up, action(selecionar_nivel), text("Selecionar Nivel")),
	menu( right, normal, action(ajuda), text("Ajuda")).

ajuda(press) :-
	message("Ajuda	", "O objetivo do jogo é fazer com que o bloco caia no quadrado vazio no final de cada fase.
Use as setas para se movimentar pelo mapa sem cair das bordas para não resetar seu progresso.
Em algumas fases existem botões no qual só será ativado se o bloco estiver em pé no botão, e outros que são ativados de qualquer lado do bloco.
Boa Sorte!", !).	

selecionar_nivel(init) :-
	menu( normal, action(select1), text("Nível 1")),
	menu( normal, action(select2), text("Nível 2")),
	menu( normal, action(select3), text("Nível 3")),
	menu( normal, action(select4), text("Nível 4")),
	menu( normal, action(select5), text("Nível 5")),
	menu( normal, action(select6), text("Nível 6")),
	menu( normal, action(select7), text("Nível 7")),
	menu( normal, action(select8), text("Nível 8")),
	menu( normal, action(select9), text("Nível 9")).

select1(press) :- G_Nvl := 0, update_window(_), retry().
select2(press):- G_Nvl := 1, update_window(_), retry().
select3(press):- G_Nvl := 2, update_window(_), retry().
select4(press):- G_Nvl := 3, update_window(_),retry().
select5(press):- G_Nvl := 4, update_window(_),retry().
select6(press):- G_Nvl := 5, update_window(_), retry().
select7(press):- G_Nvl := 6, update_window(_),retry().
select8(press):- G_Nvl := 7, update_window(_),retry().
select9(press):- G_Nvl := 8, update_window(_),retry().


retry():-
	G_Mapaxy := 16,
	G_Cont := 0,
	G_lermp := 1,
	G_Bloco_X := 630,
	G_Bloco_Y := 50,
	G_Caixa_T := 1,
	G_Count := 0,
	G_Movimentos := 0,
	wait(0.3).

%********************Mapa********************


mostrar():-
	nivel(),
	R is str_length(G_botoes),
	Char is charAt(G_mapa, G_Mapaxy), %Caractere G_Mapaxy em G_mapa
	
	color_text_back(_,rgb(100,50,255)),
	color_text(_, rgb(30,20,10)),
	font(10,30,"Courier"),
	text_out("Nível "+ print(G_Nvl+1), pos(15,10)), %Mostra o nível
	text_out(print(G_Movimentos), pos(860,10)),		%Mostra a quantidade de movimentos

	( G_Cont =:= 0 -> %Posição inicial da Caixa
		X := G_Lcaixa * 17 + G_Ccaixa,
		(G_Mapaxy =:= X ->	G_Cont := 1, G_Caixa_X := G_Bloco_X, G_Caixa_Y := G_Bloco_Y - 74)
	),

	( Char =:= "1" ->	%Bloco normal
		draw_bitmap( G_Bloco_X, G_Bloco_Y, G_Bloco, _, _)
	else
	( Char =:= "2" ->	%Espaco final
		draw_bitmap( G_Bloco_X, G_Bloco_Y, G_Final, _, _)
	else
	%Blocos ativados por botões
	( R >= 4 -> %Se tiver botão no mapa
		btn()
	))),

	G_Mapaxy := G_Mapaxy + 17,
	%Para colocar as imagens da direita pra esquerda e de cima para baixo 	

	(G_Mapaxy =:= 237 -> G_Mapaxy := 15
	else (G_Mapaxy =:= 236 -> G_Mapaxy := 14
	else (G_Mapaxy =:= 235 -> G_Mapaxy := 13
	else (G_Mapaxy =:= 234 -> G_Mapaxy := 12
	else (G_Mapaxy =:= 233 -> G_Mapaxy := 11
	else (G_Mapaxy =:= 232 -> G_Mapaxy := 10
	else (G_Mapaxy =:= 231 -> G_Mapaxy := 9
	else (G_Mapaxy =:= 230 -> G_Mapaxy := 8
	else (G_Mapaxy =:= 229 -> G_Mapaxy := 7
	else (G_Mapaxy =:= 228 -> G_Mapaxy := 6
	else (G_Mapaxy =:= 227 -> G_Mapaxy := 5
	else (G_Mapaxy =:= 226 -> G_Mapaxy := 4
	else (G_Mapaxy =:= 225 -> G_Mapaxy := 3
	else (G_Mapaxy =:= 224 -> G_Mapaxy := 2
	else (G_Mapaxy =:= 223 -> G_Mapaxy := 1
	else (G_Mapaxy =:= 222 -> G_Mapaxy := 0
	)))))))))))))))),

	G_Count := G_Count + 1,
	(G_Count =:= 13 -> %Quando o contador for 13, passa para a próxima coluna de blocos
		G_Bloco_Y := G_Bloco_Y - 350 + 6 + 25,
		G_Bloco_X := G_Bloco_X - 210 - 36 + 15,
		G_Count := 0
	),
	
	G_Bloco_X := G_Bloco_X + 15, % Posição X do bloco
	G_Bloco_Y := G_Bloco_Y + 25, % Posição Y do bloco

	( G_Mapaxy =:= 221 -> %Quando terminar o mapa coloca a caixa
		caixa()
	else
		mostrar()
	).

% Mudar o nível do jogo:
nivel():-	
	(G_lermp = 1 -> % Se for para ler o arquivo de texto
		File is open("1.txt","r"),
		(G_Nvl \= 0 ->					%Se o nível não for o 1
			prox_nivel(File, G_Nvl * 5)	%Chama a função para ler
		),							%linhas até chegar na desejada
		
		G_mapa := readln(File),
		G_Lcaixa := readln(File),
		Linha is first_ASCII(G_Lcaixa),
		G_Ccaixa := readln(File),
		Coluna is first_ASCII(G_Ccaixa),
		G_Lcaixa := Linha - 48,		%G_Lcaixa recebe o número da linha onde a caixa começa
		G_Ccaixa := Coluna - 48,	%G_Ccaixa recebe a coluna
		G_botoes := readln(File),

		close(File),		

		G_lermp := 0 % Para impedir que leia o arquivo desnecessariamente
	).

prox_nivel(File, X):-
	(X > 0 ->
	R is readln(File),
	X0 := X - 1,
	prox_nivel(File, X0)).



btn():-
	Char is charAt(G_mapa, G_Mapaxy),
	Letra is first_ASCII(Char), %Pegar o valor da letra para saber qual tipo vai ser o botão
	
	(Letra >= 65 , Letra =< 72 -> %Letra A até H
		draw_bitmap( G_Bloco_X, G_Bloco_Y, G_Botao1, _, _)
		
	else
	( Letra >= 73 , Letra =< 90 -> %Letra I até Z
		draw_bitmap( G_Bloco_X, G_Bloco_Y, G_Botao2, _, _)
	)),

	(Letra >= 97 , Letra =< 122 -> %Letras: a-z
		Pos = 0,
		G_Aux := 0,
		encontrar_char(Char, Pos, G_Aux), %Encontrar a posição do caractere na string
		%G_Aux recebe a posição do caractere que indica se o bloco irá aparecer ou não (inicialmente)
		
		Inicial is charAt(G_botoes, G_Aux), 
		%Inicial recebe o caractere que indica se o bloco irá aparecer ou não
		
		( Inicial =:= "1" ; Inicial =:= "2" ; Inicial =:= "5" ->
			draw_bitmap( G_Bloco_X, G_Bloco_Y, G_Bmovel, _, _)
		)
	).


encontrar_char(Char, Pos, Z):- %Retorna 1 posição depois do caractere na string G_botoes
	T is str_length(G_botoes),
	( Pos < T ->
		X is charAt(G_botoes, Pos),
		( Char =:= X  -> 
			Z := Pos + 1
		else
			encontrar_char(Char, Pos+1, Z)
		)
	).


caixa():- %Verifica qual o tipo da caixa e coloca a imagem
	( G_Caixa_T =:= 0 ->
		draw_bitmap( G_Caixa_X, G_Caixa_Y, G_Caixa0, _, _)
	else
		(G_Caixa_T =:= 1 ->
			draw_bitmap( G_Caixa_X, G_Caixa_Y, G_Caixa1, _, _)
		else
			draw_bitmap( G_Caixa_X, G_Caixa_Y, G_Caixa2, _, _)
		)
	).

%Verificar se a caixa está em um bloco ou já chegou ao final
verifica():-
	X := G_Lcaixa * 17 + G_Ccaixa, %Bloco onde a caixa está
	Char is charAt(G_mapa, X),
	Letra is first_ASCII(Char),

	( Char = "0" -> %Se a caixa estiver fora do bloco
		wait(0.3),
		message("Perdeu","Você Perdeu!", !),
		update_window(_),
		retry(),
		wait(0.3)
	else
	( Char = "2" -> %Se a caixa estiver no final
		(G_Caixa_T =:= 1 -> 
			G_Nvl := G_Nvl + 1,%Vai para o próximo
			( G_Nvl =< 8 ->	%enquanto não é o último
				retry()
			else	%Quando chegar ao fim do último nível
				G_Nvl := G_Nvl - 1,
				beep,
				message("Bloxorz","\tParabéns, Você Zerou o Jogo!\t\n\tO Jogo será reiniciado\t", !),
				update_window(_),
				G_Nvl := 0,
				retry()
			)
		)
	)),
	( G_Caixa_T =:= 0 -> %Condições de perda para a primeira parte da caixa (Tipos 0 e 2)
		X := X + 1,
		Ch is charAt(G_mapa, X),
		( Ch =:= "0" -> 
			wait(0.3),
			message("Perdeu","Você Perdeu!", !),
			update_window(_),
			retry(),
			wait(0.3)
		)
	else ( G_Caixa_T =:= 2 ->
			X := X + 17,
			Cha is charAt(G_mapa, X),
			( Cha =:= "0" ->
				wait(0.3),
				message("Perdeu","Você Perdeu!", !), 
				update_window(_),
				retry(),
				wait(0.3)
			)
		)
	),

	( Letra >= 97 , Letra =< 122 ->
		%Se a caixa estiver em um bloco que é ativado por um botão
		ativo(Char, 0)
	),
	
	%verificar a posição da caixa na string (CALCULOS)
	X := G_Lcaixa * 17 + G_Ccaixa,

	%verifica a segunda parte da caixa (Tipo 0)
	P := X + 1,
	C0 is charAt(G_mapa, P),
	Letra1 is first_ASCII(C0),
	( Letra1 >= 97 , Letra1 =< 122 ->
		( G_Caixa_T =:= 0 -> ativo(C0, 0) )
	),
	%verifica a segunda parte da caixa (Tipo 2)
	Q := X + 17,
	C2 is charAt(G_mapa, Q),
	Letra2 is first_ASCII(C2),
	( Letra2 >= 97 , Letra2 =< 122 ->
		( G_Caixa_T =:= 2 -> ativo(C2, 0) )
	).

	
ativo(Char, Pos):- %Verificar se o bloco está ativo
	G_Aux := 0,
	encontrar_char(Char, Pos, G_Aux),
	X is charAt(G_botoes, G_Aux),
	( X =:= "0" ; X =:= "3" ; X =:= "4" -> %Se a caixa estiver em um bloco que não foi ativado
		wait(0.3),
		message("Perdeu","Você Perdeu!", !),
		update_window(_),
		retry(),
		wait(0.3)
	).


%*********Botões**********

verifica_botao():- %Saber se a caixa está acionando um botão
	X := G_Lcaixa * 17 + G_Ccaixa,
	Char is charAt(G_mapa, X),
	Letra is first_ASCII(Char),
	( Letra >= 65 , Letra =< 72  -> %Se for botão
		G_Pos_str := 0,
		pos_letra(Letra),
		Aux1 is charAt(G_botoes, G_Pos_str),
		( Aux1 =:= "2" -> %desativa/ativa
			alteraS(G_botoes, G_Pos_str, "3", Str),
			G_botoes := Str
		else
		( Aux1 =:= "3" -> %ativa/desativa
			alteraS(G_botoes, G_Pos_str, "2", Str),
			G_botoes := Str
		else
		( Aux1 =:= "1" -> %desativa
			alteraS(G_botoes, G_Pos_str, "4", Str),
			G_botoes := Str
		else
		( Aux1 =:= "0" -> %ativa
			alteraS(G_botoes, G_Pos_str, "5", Str),
			G_botoes := Str
		))))),
	
	( G_Caixa_T =:= 0 -> %Segunda parte da caixa (Tipo 0)
		X1 := X + 1,
		Char1 is charAt(G_mapa, X1),
		Letra1 is first_ASCII(Char1),
		( Letra1 >= 65 , Letra1 =< 72 -> 
			G_Pos_str := 0,
			pos_letra(Letra1),
			Aux2 is charAt(G_botoes, G_Pos_str),
			( Aux2 =:= "2" -> %desativa/ativa
				alteraS(G_botoes, G_Pos_str, "3", Str),
				G_botoes := Str
			else
			( Aux2 =:= "3" -> %ativa/desativa
				alteraS(G_botoes, G_Pos_str, "2", Str),
				G_botoes := Str
			else
			( Aux2 =:= "1" -> %desativa
				alteraS(G_botoes, G_Pos_str, "4", Str),
				G_botoes := Str
			else
			( Aux2 =:= "0" -> %ativa
				alteraS(G_botoes, G_Pos_str, "5", Str),
				G_botoes := Str
			))))
		)
	else
	( G_Caixa_T =:= 2 -> %Segunda parte da caixa (Tipo 2)
		X2 := X + 17,
		Char2 is charAt(G_mapa, X2),
		Letra2 is first_ASCII(Char2),
		( Letra2 >= 65 , Letra2 =< 72 ->
			G_Pos_str := 0,
			pos_letra(Letra2),
			Aux1 is charAt(G_botoes, G_Pos_str),
			( Aux1 =:= "2" -> %desativa/ativa
				alteraS(G_botoes, G_Pos_str, "3", Str),
				G_botoes := Str
			else
			( Aux1 =:= "3" -> %ativa/desativa
				alteraS(G_botoes, G_Pos_str, "2", Str),
				G_botoes := Str
			else
			( Aux1 =:= "1" -> %desativa
				alteraS(G_botoes, G_Pos_str, "4", Str),
				G_botoes := Str
			else
			( Aux1 =:= "0" -> %ativa
				alteraS(G_botoes, G_Pos_str, "5", Str),
				G_botoes := Str
			))))
		)
	)),
	( Letra >= 73 , Letra =< 90 -> %Outro tipo de botão
		( G_Caixa_T =:= 1 ->
			G_Pos_str := 0,
			pos_letra(Letra),
			Aux1 is charAt(G_botoes, G_Pos_str),
			( Aux1 =:= "2" ->
				alteraS(G_botoes, G_Pos_str, "3", Str),
				G_botoes := Str
			else
			( Aux1 =:= "3" ->
				alteraS(G_botoes, G_Pos_str, "2", Str),
				G_botoes := Str
			else
			( Aux1 =:= "1" ->
				alteraS(G_botoes, G_Pos_str, "4", Str),
				G_botoes := Str
			else
			( Aux1 =:= "0" ->
				alteraS(G_botoes, G_Pos_str, "5", Str),
				G_botoes := Str
			))))

		)
	).


pos_letra(Letra1):-	%Procura uma letra na string e muda G_Pos_str para dois caracteres depois dessa letra
	Char is charAt(G_botoes, G_Pos_str),
	Letra2 is first_ASCII(Char),
	(Letra2 =:= Letra1 -> G_Pos_str := G_Pos_str + 2
	else
	G_Pos_str := G_Pos_str + 1, pos_letra(Letra1)).

alteraS(Si, P, X, Str) :- %Trocar um caractere na string
	T is str_length(Si),

	sub_string(Sub1, Si, 0, P),

	sub_string(Sub2, Si, P + 1, (T-P)-1),

	Str is Sub1 + X + Sub2.


%**********Movimentos**********

win_func(key_down(Key, Rep)):-

	(Key = 37 -> % Esquerda
	update_window(_),	
	G_Mapaxy := 16,
	G_Bloco_X := 630,
	G_Bloco_Y := 50,
	G_Count := 0,
	G_Movimentos := G_Movimentos + 1,
		(G_Caixa_T = 1 ->
			G_Caixa_T := 0,
			G_Caixa_X := G_Caixa_X - 71,
			G_Caixa_Y := G_Caixa_Y + 45,
			G_Ccaixa := G_Ccaixa - 2
		else (G_Caixa_T = 2 ->
				G_Caixa_X := G_Caixa_X - 36,
				G_Caixa_Y := G_Caixa_Y + 6,
				G_Ccaixa := G_Ccaixa - 1
			else
				G_Caixa_T := 1,
				G_Caixa_X := G_Caixa_X - 37,
				G_Caixa_Y := G_Caixa_Y - 27,
				G_Ccaixa := G_Ccaixa - 1
			)
		),
	caixa()	
  	else
	(Key = 39 -> % Direita
	update_window(_),
	G_Mapaxy := 16,
	G_Bloco_X := 630,
	G_Bloco_Y := 50,
	G_Count := 0,
	G_Movimentos := G_Movimentos + 1,
		(G_Caixa_T = 1 ->
			G_Caixa_T := 0,
			G_Caixa_X := G_Caixa_X + 37,
			G_Caixa_Y := G_Caixa_Y + 27,
			G_Ccaixa := G_Ccaixa + 1
		else (G_Caixa_T = 2 ->
				G_Caixa_X := G_Caixa_X + 36,
				G_Caixa_Y := G_Caixa_Y - 6,
				G_Ccaixa := G_Ccaixa + 1
			else
				G_Caixa_T := 1,
				G_Caixa_X := G_Caixa_X + 71,
				G_Caixa_Y := G_Caixa_Y - 45,
				G_Ccaixa := G_Ccaixa + 2
			)
		),
	caixa()
	else
	(Key = 38 -> % Cima
	update_window(_),
	G_Mapaxy := 16,
	G_Bloco_X := 630,
	G_Bloco_Y := 50,
	G_Count := 0,
	G_Movimentos := G_Movimentos + 1,
		(G_Caixa_T = 1 ->
			G_Caixa_T := 2,
			G_Caixa_X := G_Caixa_X - 30,
			G_Caixa_Y := G_Caixa_Y - 3,
			G_Lcaixa := G_Lcaixa - 2
		else (G_Caixa_T = 2 ->
				G_Caixa_T := 1,
				G_Caixa_X := G_Caixa_X - 15,
				G_Caixa_Y := G_Caixa_Y - 72,
				G_Lcaixa := G_Lcaixa - 1
			else
				G_Caixa_X := G_Caixa_X - 15,
				G_Caixa_Y := G_Caixa_Y - 25,
				G_Lcaixa := G_Lcaixa - 1
			)
		),
	caixa()
	else
	(Key = 40 -> % Baixo
	update_window(_),
	G_Mapaxy := 16,
	G_Bloco_X := 630,
	G_Bloco_Y := 50,
	G_Count := 0,
	G_Movimentos := G_Movimentos + 1,
		(G_Caixa_T = 1 ->
			G_Caixa_T := 2,
			G_Caixa_X := G_Caixa_X + 15,
			G_Caixa_Y := G_Caixa_Y + 72,
			G_Lcaixa := G_Lcaixa + 1
		else (G_Caixa_T = 2 ->
				G_Caixa_T := 1,
				G_Caixa_X := G_Caixa_X + 30,
				G_Caixa_Y := G_Caixa_Y + 3,
				G_Lcaixa := G_Lcaixa + 2
			else
				G_Caixa_X := G_Caixa_X + 15,
				G_Caixa_Y := G_Caixa_Y + 25,
				G_Lcaixa := G_Lcaixa + 1
			)
		),
	caixa()
	else
	(Key = 27 -> % ESC
		beep,
		yes_no("Bloxorz","Deseja fechar o jogo?", ?),
		close(_)
	else
	(Key = 82 -> % R
		update_window(_),
		retry()

	)))))),
	
	%A cada movimento verificar blocos e botões
	verifica(),
	verifica_botao().
