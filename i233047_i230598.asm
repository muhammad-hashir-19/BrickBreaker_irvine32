Include irvine32.inc
Include macros.inc
Includelib winmm.lib
TITLE MASM PlaySound

PlaySound PROTO,
pszSound:PTR BYTE,
hmod:DWORD,
fdwSound:DWORD

.data

;/////////////////////////////MUSIC\\\\\\\\\\\\\\\\\\\\\\\\\
SND_FILENAME DWORD 20001h
musicfile DB "Ten.wav",0

;//////////////////////Game Name Display\\\\\\\\\\\\\\\\\\\\\\\\
display1 db " _______    _______     __     ______    __   __",0
display2 db "|   _   \  |   _   \   |  |   /  ____\  |  | / / ",0
display3 db "|  |_|  |  |  |_|   |  |  |  |  |       |  |/ /  ",0
display4 db "|   _   <  |   _   /   |  |  |  |       |     \  ",0
display5 db "|  |_|  |  |  | |  \   |  |  |  |_____  |  |\  \ ",0
display6 db "|_______/  |__| |___\  |__|   \______/  |__| \__\",0
display7 db  " _______    _______     ______      ____      __   __   ______    _______    " ,0
display8 db  "|   _   \  |   _   \   |   ___|    /    \    |  | / /  |   ___|  |   _   \   ",0
display9 db  "|  |_|  |  |  |_|   |  |  |___    /  /\  \   |  |/ /   |  |___   |  |_|   |  ",0
display10 db "|   _   <  |   _   /   |   ___|  /  ____  \  |     \   |   ___|  |   _   /   ",0
display11 db "|  |_|  |  |  | |  \   |  |___   | |    | |  |  |\  \  |  |___   |  | |  \   ",0
display12 db "|_______/  |__| |___\  |______|  |_|    |_|  |__| \__\ |______|  |__| |___\  ",0

;/////////////////////Start Screen Colors\\\\\\\\\\\\\\\\\\\\\\\\
RedOnCyan DD (red+(lightcyan*16))
RedOnYellow DD (red+(yellow*16))
RedOnBlack DD (red+(black*16))
YellowOnBlack DD (yellow+(black*16))
BlackOnCyan DD (black+(lightcyan*16))
BlackOnYellow DD (black+(yellow*16))
BlackOnGray DD (black+(lightgray*16))
BlueOnCyan DD (blue+(lightcyan*16))
BlueOnGray DD (blue+(lightgray*16))
BlueOnYellow DD (blue+(yellow*16))
BlueOnBlack DD (blue+(black*16))
BlueOnBlue DD (blue+(blue*16))
WhiteOnBlack DD (white+(black*16))
RedOnGray dd (red+(lightgray*16))
RedOnRed dd (red+(red*16))
GreenOnGray dd (green+(lightgray*16))
GreenOnBlack dd (green+(black*16))
GreenOnGreen dd (green+(green*16))
MagentaOnMagenta dd (lightmagenta+(lightmagenta*16))
MagentaOnBlack dd (magenta+(black*16))
BlueOnWhite DD (white + (blue * 16))
WhiteOnWhite DD (white + (white * 16))
WhiteOnBlue DD (white + (blue * 16))

;//////////////////////User Variables\\\\\\\\\\\\\\\\\\\\\\\\
username db 255 dup(?)
namelength dd ?
userchoice db ?

;///////////////////////////File\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
filename BYTE "output.txt", 0
fileHandle HANDLE ?

;///////////////////////////MENU\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
menu_title   db "***********  BRICK BREAKER  ***********", 0
menu_option1 db "|                                     |",0
menu_option2 db "|      oEnter 1 to Start Game         |", 0
menu_option3 db "|                                     |",0
menu_option4 db "|  oEnter 2 to view Instructions      |", 0
menu_option5 db "|                                     |",0
menu_option6 db "|  oEnter 3 to view High Scores       |", 0
menu_option7 db "|                                     |",0
menu_option8 db "|        oEnter 4 to Exit             |", 0
menu_option9 db "|                                     |",0
menu_option10 db "|_____________________________________|",0

;///////////////////////////INSTRUCTIONS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
instr_title   db "***********  BRICK BREAKER  ***********", 0
line db "=========================================================", 0
intro db "Welcome to Brick Breaker! Your goal is to break all the bricks using the ball.", 10, 0
objective db "Make sure the ball doesn't fall below your paddle, or you'll lose a life.", 10, 0
howToPlay db "------------------- How to Play --------------------------", 10, 0
rule1 db "1. Move the paddle left or right to keep the ball in play.", 10, 0
control db "   Use the following keys:", 10, 0
leftControl db "   - 'A' or Left Arrow  : Move paddle left", 10, 0
rightControl db "   - 'D' or Right Arrow : Move paddle right", 10, 0
rule2 db "2. Break all the bricks to complete the level.", 10, 0
rule3 db "3. Avoid missing the ball, or you'll lose a life.", 10, 0
features db "------------------- Game Features ------------------------", 10, 0
feature1 db "- Multiple levels with increasing difficulty.", 10, 0
feature2 db "----------------------------------------------------------", 10, 0
feature3 db "- High score tracking.", 10, 0
controlsSummary db "------------------- Controls Summary ---------------------", 10, 0
leftSummary db "   'A'               : Move paddle left", 10, 0
rightSummary db "   'D'                : Move paddle right", 10, 0
pauseControl db "   'P'                : Pause/Resume the game", 10, 0
quitControl    db "----------------------------------------------------------", 10, 0
outro db "Good luck and have fun breaking those bricks!", 10, 0
endLine db "=========================================================", 10, 0


;///////////////////////////LEVEL SELECTION\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
menu_title2   db "***********  BRICK BREAKER  ***********", 0
menu_option21 db "|                                     |",0
menu_option22 db "|      oEnter 1 for lvl 1 (EASY)      |", 0
menu_option23 db "|                                     |",0
menu_option24 db "|      oEnter 2 for lvl 2 (MED)       |", 0
menu_option25 db "|                                     |",0
menu_option26 db "|     oEnter 3 for lvl 3 (DIFF)       |", 0
menu_option27 db "|                                     |",0
menu_option28 db "|        oEnter 4 to go back          |", 0
menu_option29 db "|                                     |",0
menu_option210 db "|_____________________________________|",0


level1 db \
                " ___      _______  __   __  _______  ___     ",\   
                "|   |    |       ||  | |  ||       ||   |    ",\   
                "|   |    |    ___||  |_|  ||    ___||   |    ",\   
                "|   |    |   |___ |       ||   |___ |   |    ",\   
                "|   |___ |    ___||       ||    ___||   |___ ",\   
                "|       ||   |___  |     | |   |___ |       |",\   
                "|_______||_______|  |___|  |_______||_______|",0   
     
no1 db \
          " ____ ",\
          "|    |",\
          " |   |",\
          " |   |",\
          " |   |",\
          " |   |",\
          " |___|",0
no2 db \
          " _______ ",\
          "|       |",\
          "|____   |",\
          " ____|  |",\
          "| ______|",\
          "| |_____ ",\
          "|_______|",0

no3 db \
" _______ ",\
"|       |",\
"|___    |",\
" ___|   |",\
"|___    |",\
" ___|   |",\
"|_______|",0
     
;/////////////////////////Lost & Won\\\\\\\\\\\\\\\\\\\\\\\\\\
lost db \
                 "__   _____  _   _   _     ___  ____ _____ _ ",\
                 "\ \ / / _ \| | | | | |   / _ \/ ___|_   _| |",\
                 " \ V / | | | | | | | |  | | | \___ \ | | | |",\
                 "  | || |_| | |_| | | |__| |_| |___) || | |_|",\
                 "  |_| \___/ \___/  |_____\___/|____/ |_| (_)",0

won db \
                 "__   _____  _   _  __        _____  _   _   _ ",\
                 "\ \ / / _ \| | | | \ \      / / _ \| \ | | | |",\
                 " \ V / | | | | | |  \ \ /\ / / | | |  \| | | |",\
                 "  | || |_| | |_| |   \ V  V /| |_| | |\  | |_|",\
                 "  |_| \___/ \___/     \_/\_/  \___/|_| \_| (_)",0


inst1 db     " ___ _   _ ____ _____ ____  _   _  ____ _____ ___ ___  _   _ ____  ",0
inst2 db     "|_ _| \ | / ___|_   _|  _ \| | | |/ ___|_   _|_ _/ _ \| \ | / ___| ",0
inst3 db     " | ||  \| \___ \ | | | |_) | | | | |     | |  | | | | |  \| \___ \ ",0
inst4 db     " | || |\  |___) || | |  _ <| |_| | |___  | |  | | |_| | |\  |___) |",0
inst5 db     "|___|_| \_|____/ |_| |_| \_\\___/ \____| |_| |___\___/|_| \_|____/ ",0           

    

temp9 db ?
temp4 db ?


;///////////////////////////////////////////Lost & Won\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
NA1 db 'Player1',0
NA2 db 'Player2',0
NA3 db 'Player3',0
NA4 db 'Player4',0
NA5 db 'Player5',0
NA6 db 'Player5',0
NA7 db 'Player5',0
NA8 db 'Player5',0
NA9 db 'Player5',0
NA10 db 'Player5',0


scores db 0,0,0,0,0,0,0,0,0,0

;/////////////////////////lvl 1 data\\\\\\\\\\\\\\\\\\\\\\\\\\
    level_line1 db "||          ||||||||  \\        //   ||||||||  ||             //||  ",0
    level_line2 db "||          ||         \\      //    ||        ||            // ||  ",0
    level_line3 db "||          ||||||||    \\    //     ||||||||  ||               ||  ",0
    level_line4 db "||          ||           \\  //      ||        ||               ||  ",0
    level_line5 db "||||||||||  ||||||||      \\//       ||||||||  ||||||||||    |||||||", 0

    level_line12 db "||          ||||||||  \\        //   ||||||||  ||             /|||||  ",0
    level_line22 db "||          ||         \\      //    ||        ||             |  //  ",0
    level_line32 db "||          ||||||||    \\    //     ||||||||  ||               //   ",0
    level_line42 db "||          ||           \\  //      ||        ||              //     ",0
    level_line52 db "||||||||||  ||||||||      \\//       ||||||||  ||||||||||     ||||||", 0

    level_line13 db "||          ||||||||  \\        //   ||||||||  ||             ||||||  ",0
    level_line23 db "||          ||         \\      //    ||        ||                 ||  ",0
    level_line33 db "||          ||||||||    \\    //     ||||||||  ||             |||||| ",0
    level_line43 db "||          ||           \\  //      ||        ||                 ||  ",0
    level_line53 db "||||||||||  ||||||||      \\//       ||||||||  ||||||||||     ||||||", 0


    box2 db "                              ", 0
    boxs db "                                                                     ", 0
    box1 db "&#&##&", 0 
    spc1 db "      ",0
    paddle1 db "&#&##&#&##&&#&##&",0
    paddle2 db ")&#&##&#&#",0
    paddle3 db ")&#&##&#&#",0
    boxs1 db   "                 ",0
    box4 db "&#&##&&#&##&", 0
    spc2 db "            ",0
    box5 db "##&&&&&&", 0
    spc3 db "        ",0
    temp dword 0
    temp1 byte 0
    lives dword 3
     box_line1_x_start byte 36,0,56,69,76,85
     box_line1_x_end byte 47,0,67,74,83,96
     box_line1_y byte 5
     box_line1_status byte 1,0,1,1,1,1
     box_line2_x_start byte 36,43,0,63,72,85
     box_line2_x_end byte 41,54,0,70,83,96
     box_line2_y byte 7
     box_line2_status byte 1,1,0,1,1,1
     box_line3_x_start byte 36,0,56,69,76,85
     box_line3_x_end byte 47,0,67,74,83,96
     box_line3_y byte 9
     box_line3_status byte 1,0,1,1,1,1
     box_line4_x_start byte 36,0,0,0,0,0
     box_line4_x_end byte 47,0,0,0,0,0
     box_line4_y byte 11
     box_line4_status byte 1,0,0,0,0,0
     box_line5_x_start byte 36,43,56,63,72,85
     box_line5_x_end byte 41,54,61,70,83,96
     box_line5_y byte 13
     box_line5_status byte 0,1,1,1,1,1
     paddlex_start db 64
     paddley db 27
    topbottomline db "=========================================================================", 0             
    sideline db "||", 0             
    widt dword 10

     box_line1_status2 byte 2,0,2,2,2,2
     box_line2_status2 byte 2,2,0,2,2,2
     box_line3_status2 byte 2,0,2,2,2,2
     box_line4_status2 byte 2,0,0,0,0,0
     box_line5_status2 byte 0,2,2,2,2,2

     box_line1_status3 byte 3,0,3,3,3,3
     box_line2_status3 byte 3,3,0,250,3,3
     box_line3_status3 byte 3,0,3,3,3,250
     box_line4_status3 byte 3,0,0,0,0,0
     box_line5_status3 byte 0,3,3,3,3,3

    height dword 10
    color dword 4            
    front dword ?
    back dword ?
    cordinatexline byte 6
    cordinateballx byte 70
    cordinatebally byte 20
    input_buffer db 1,0
    ballX db 70
    ballY db 20
    ballDX db 1
    ballDY db 1
    ballChar db "o",0
    emptyChar db " ",0
    index_heart3 byte 87
    index_heart2 byte 80
    index_heart1 byte 73
    heart db " *** ***",0
    hear1 db "  *****",0
    hear2 db "   ***",0
    hear3 db "    *",0
    currentBrickIndex db 0
    brickHit db 0
    score dword 0
    scoreLabel db "Score: ", 0
    gameOver db 0
winMessage1 BYTE "Congratulations!", 0
winMessage2 BYTE "You reached the target score!", 0
winMessage3 BYTE "YOU WIN!", 0
finalScoreMessage BYTE "Final Score: ", 0
MAX_SCORE WORD 48;//real maxscore 98   ------------ lvl 1
MAX_SCORE2 WORD 128;//real maxscore 128  ------------ lvl 2
MAX_SCORE3 WORD 185;//real maxscore 220 ------------ lvl 3
check db 0
total_bricks byte 30
special_x_start byte 85
     special_x_end byte 96
     special_line byte 13
     special_status byte 1
     special_index byte ?
     special_hit byte 0
     brickbroken byte 0
     num byte 6


.code 
main PROC



;/////////////////////////////MUSIC\\\\\\\\\\\\\\\\\\\\\\\\\
INVOKE PlaySound, OFFSET musicfile, NULL, SND_FILENAME

call make_display
call username_prompt
call display_menu
call waitmsg
exit


main ENDP
make_display proc
        mov eax,WhiteOnBlue
        call SetTextColor
        mov cl,5
        call clrscr
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display1
        call WriteString
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display2
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display3
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display4
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display5
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display6
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display7
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display8
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display9
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display10
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display11
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,20
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset display12
        call Writestring
        call crlf
ret
make_display ENDP
       
username_prompt proc
       mov eax,200
       call delay
       mov eax,WhiteOnBlue
       call settextcolor
       mov dl,30
       mov dh,20
       call gotoxy

       mov edx,offset filename
       call CreateOutputFile
       mov fileHandle,eax
       mwrite "Enter you name: "
       mov eax,BlueOnGray
       call settextcolor
       mov edx,offset username
       mov ecx,lengthof username
       call readstring
       mov eax,filehandle
       mov namelength,eax
       mov edx,offset username
       mov ecx,namelength
       call writetofile
       mov eax,WhiteOnBlue
       call SetTextColor
       call crlf
       call waitmsg
       mov ecx,10
       L1:
       call crlf
       loop L1
ret
username_prompt ENDP

display_menu proc
        mov eax,WhiteOnBlue
        call SetTextColor
        mov cl,5
        call clrscr
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_title
        call WriteString
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option1
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option2
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option3
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option4
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option5
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option6
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option7
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option8
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option9
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option10
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mwrite "Enter your option: "
        call ReadDec
        mov userchoice,al

        mov al,userchoice

        cmp al,1
        jl invalidInput

        cmp al,4
        jg invalidInput

        cmp al,1
        je startGame

        cmp al,2
        je instructionslabel

        cmp al,3
        ;high scores

        cmp al,4
        exit

invalidInput:
        mwrite "Invalid input,Please try again"
        call crlf
        call display_menu

startGame:
       call start_game
       ret

instructionslabel:
       call instructions_page


ret
display_menu ENDP

start_game proc
       mov eax,WhiteOnBlue
        call SetTextColor
        mov cl,5
        call clrscr
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_title2
        call WriteString
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option21
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option22
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option23
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option24
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option25
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option26
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option27
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option28
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option29
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset menu_option210
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mwrite "Enter your option: "
        call ReadDec
        mov userchoice,al

        mov al,userchoice

        cmp al,1
        jl invalidInput

        cmp al,4
        jg invalidInput

        cmp al,1 
        je lvll1
        cmp al,2
        je lvll2
        cmp al,3
        je lvll3
        cmp al,4
        je lvll4

        lvll1:   ;-------------------------------------------lvl 1-----------------------------------------------------
        call clrscr
        mov eax,black+(black*16)
        call settextcolor
        call level_1
        call no_1
        mov dl,30
        mov dh,22
        call gotoxy
        mov eax,red+(black*16)
        call settextcolor
        call waitmsg
        call prep_level1
        call display_menu

        lvll2:   ;-------------------------------------------lvl 2-----------------------------------------------------
        call clrscr
        call level_1
        call no_2
        mov dl,30
        mov dh,22
        call gotoxy
        mov eax,red+(black*16)
        call settextcolor
        call waitmsg
       call prep_level2
         call display_menu


        lvll3:  ;-------------------------------------------lvl 3-----------------------------------------------------
        call clrscr
        call level_1
        call no_3
        mov dl,30
        mov dh,22
        call gotoxy
        mov eax,red+(black*16)
        call settextcolor
        call waitmsg
        call prep_level3
         call display_menu

        lvll4:
        call display_menu

invalidInput:
        mwrite "Invalid input,Please try again"
        call crlf
        call display_menu


ret
start_game ENDP

prep_level1 proc
mov lives,3
mov score,0
mov cordinatexline,6
mov cordinateballx,70
mov cordinatebally,20
mov ballX,70
mov ballY,20
mov gameover,0
mov paddlex_start,64
mov ballDX,1
mov ballDY,1

call clrscr
call Randomize
    mov ecx,1
    mov ebx,5
    mov eax,cyan+(black*16)
    call SetTextColor
        mov edx, offset level_line1
        call WriteString
        
                call crlf
        mov edx, offset level_line2
        call WriteString
            call crlf
        mov edx, offset level_line3
            call WriteString
       
        call crlf
        mov edx, offset level_line4
            call WriteString
       
        call crlf
        mov edx, offset level_line5
    call WriteString
            call crlf
    mov dh,cordinatexline
    mov dl,0
    call Gotoxy
    l1_level1:
    mov edx, offset box2
    call WriteString
    cmp ecx,1
    je topbottom_level1
    cmp ecx,26
    je en_level1
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset sideline
    call WriteString
    cmp cordinatexline,29
    je space_print_level1
    cmp cordinatexline,30
    je space_print_level1
    l2_level1:
        mov dh,cordinatexline
        mov dl,36
        call Gotoxy
        cmp ecx,3
        je ran3_level1
        cmp ecx,5
        je ran5_level1
        cmp ecx,7
        je ran7_level1
        cmp ecx,9
        je ran9_level1
        cmp ecx,11
        je ran11_level1
        jmp l3_level1

    space_print_level1:
        mov eax,black+(black*16)
        mov edx, offset boxs
        call WriteString
        mov eax,cyan+(black*16)
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level1

    l3_level1:
        mov dh,cordinatexline
        mov dl,101
        call Gotoxy
        mov eax,cyan+(black*16)
        call SetTextColor
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level1

    
    topbottom_level1:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov dh,cordinatexline
    mov edx, offset topbottomline
    call WriteString
    inc cordinatexline
    inc ecx
    mov ebx,5
    call crlf
    jmp l1_level1

        ;<----------------------------------------------------------------------------line1--------------------------------------->
    ran3_level1:
    boxx1_level1:
    mov esi, offset box_line1_status  
    mov al, [esi]                   
    cmp al, 0                  
    je boxx2_level1          
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    
    boxx2_level1:
    mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp eax,0
    je boxx3_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        
    boxx3_level1:
    mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx4_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString

    boxx4_level1:
    mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx5_level1
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov dh,cordinatexline
    mov dl,76
    call Gotoxy

    boxx5_level1:
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx6_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString

    boxx6_level1:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je l3_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level1
    
    
        ;<----------------------------------------------------------------------------line2--------------------------------------->
    ran5_level1:
    box21_level1:
    mov esi, offset box_line2_status  
    mov al, [esi]                   
    cmp al, 0                  
    je box22_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box22_level1:
    mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box23_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        

    box23_level1:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box24_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box24_level1:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box25_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box25_level1:
    mov dh,cordinatexline
    mov dl,72
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box26_level1
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString



    box26_level1:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level1
    
    

        ;<----------------------------------------------------------------------------line3--------------------------------------->
    ran7_level1:
    box31_level1:
    mov esi, offset box_line3_status  
    mov al, [esi]                   
    cmp al, 0                  
    je box32_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString

    
    box32_level1:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box33_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

        
    box33_level1:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box34_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString


    box34_level1:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box35_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
  

    box35_level1:
      mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box36_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box36_level1:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level1
    
    ;<----------------------------------------------------------------------------line4--------------------------------------->
    ran9_level1:
    box41_level1:
    mov esi, offset box_line4_status  
    mov al, [esi]                   
    cmp al, 0                  
    je box42_level1
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
 
    
    box42_level1:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box43_level1
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

        
    box43_level1:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box44_level1
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString


    box44_level1:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box45_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString


    box45_level1:
        mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box46_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box46_level1:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level1
    
    
    ;<----------------------------------------------------------------------------line5--------------------------------------->
    ran11_level1:
    
     
    box51_level1:
    mov esi, offset box_line5_status  
    mov al, [esi]                   
    cmp al, 0                  
    je box52_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
  

    box52_level1:
      mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box53_level1
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
 
        

    box53_level1:
     mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box54_level1
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box54_level1:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box55_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString



    box55_level1:
        mov dh,cordinatexline
    mov dl,72
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box56_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString




    box56_level1:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level1
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level1

    en_level1:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset topbottomline
    call WriteString
    call crlf
    mov dh,15
    mov dl,0
    call Gotoxy
    mwrite "*** *** *** *** *** ***"
    mov dh,16
    mov dl,0
    call Gotoxy
    mwrite " *****   *****   *****"
    mov dh,17
    mov dl,0
        call Gotoxy
    mwrite "  ***     ***     ***"
    mov dh,18
    mov dl,0    
    call Gotoxy
    mwrite "   *       *       * "
    
    call displayScore_level1
    
    GameLoop_level1:

    mov eax,80
    call delay
    call ReadKey
    jz noPaddleMove_level1
    cmp al,'p'
    je pauseGame_level1
    cmp al,'P'
    je pauseGame_level1
    cmp al,'a'
    je moveleft_level1
    cmp al,'A'
    je moveleft_level1
    cmp al,'d'
    je moveRight_level1
    cmp al,'D'
    je moveRight_level1
    jmp redrawPaddle_level1

pauseGame_level1:
call displayPauseMessage_level1
pauseLoop_level1:
call ReadKey
jz pauseLoop_level1
call clearPauseMessage_level1
jmp GameLoop_level1

moveLeft_level1:
call clearPaddle_level1
cmp paddlex_start,33
jle updateBallandPaddle_level1
sub paddlex_start,2
jmp updateBallandPaddle_level1

moveRight_level1:
call clearPaddle_level1
cmp paddlex_start,83
jge updateBallandPaddle_level1
add paddlex_start,2
jmp updateBallandPaddle_level1
noPaddleMove_level1:
call clearPaddle_level1


updateBallandPaddle_level1:
call updateBall_level1
call drawBall_level1
cmp gameOver,1
je exit1_level1
cmp check,1
je winlvl1_level1
call CheckScoreWinCondition_level1
call drawPaddle_level1
jmp GameLoop_level1


checkBall_level1:
call updateBall_level1
cmp gameOver,1
je exit1_level1


redrawPaddle_level1:
call clearPaddle_level1
call drawPaddle_level1
jmp GameLoop_level1

redrawOnlyPaddle_level1:
call drawPaddle_level1
jmp GameLoop_level1


ret
prep_level1 endp

displayPauseMessage_level1 proc
mov eax,white+(blue*16)
call settextcolor
mov dl,48
mov dh,29
call gotoxy
mwrite "Game Paused.Press any key to continue"
ret
displayPauseMessage_level1 endp

clearPauseMessage_level1 proc
mov eax,black+(black*16)
call settextcolor
mov dl,48
mov dh,29
call gotoxy
mwrite "                                     "
ret
clearPauseMessage_level1 endp

updateBall_level1 proc

call clearBall_level1
mov al,ballX
mov bl,ballDX
add al,bl

cmp al,34
jle leftBoundary_level1
cmp al,100
jge rightBoundary_level1
jmp checkBricks_level1

leftBoundary_level1:
mov al,34
neg ballDX
jmp checkBricks_level1

rightBoundary_level1:
mov al,100
neg ballDX
jmp checkBricks_level1

checkBricks_level1:
mov ballX,al
mov al,ballY
cmp al,1
jl checkY_level1
cmp al,14
jg checkY_level1

call checkLine1_level1
cmp brickHit,1
je brickCollision_level1

call checkLine2_level1
cmp brickHit,1
je brickCollision_level1

call checkLine3_level1
cmp brickHit,1
je brickCollision_level1

call checkLine4_level1
cmp brickHit,1
je brickCollision_level1

call checkLine5_level1
cmp brickHit,1
je brickCollision_level1

jmp checkY_level1

brickCollision_level1:
neg ballDY
mov brickHit,0



checkY_level1:
mov al,ballY
mov bl,ballDY
add al,bl
cmp al,3
jle reverseY_level1

cmp al,26
jge checkPaddleHit_level1
jmp finishUpdate_level1

reverseY_level1:
neg ballDY
mov al,ballY
mov bl,ballDY
add al,bl
jmp finishUpdate_level1

checkPaddleHit_level1:
mov bl,ballX
cmp bl,paddlex_start
jl missedPaddle_level1
mov cl,paddlex_start
add cl,17
cmp bl,cl
jg missedPaddle_level1

sub bl,paddlex_start

cmp bl,8
je middlePaddleHit_level1

cmp bl,4
jl leftPaddlehit_level1

cmp bl,12
jg rightPaddlehit_level1

jmp standardPaddleHit_level1

middlePaddleHit_level1:
mov ballDX,0
neg ballDY
jmp finishUpdate_level1

leftPaddleHit_level1:
mov ballDX,-1
neg ballDY
jmp finishUpdate_level1

rightPaddleHit_level1:
mov ballDX,1
neg ballDY
jmp finishUpdate_level1

standardPaddleHit_level1:
neg ballDY
jmp finishUpdate_level1

;neg ballDY
;mov al,26
;jmp finishUpdate

missedPaddle_level1:
cmp al,28
jge gameOverBall_level1
jmp finishUpdate_level1

display_less_level1:
    mov temp,4
    mov temp1,15
    cmp lives,2
    jne l11_level1
    lo_level1:
    mov dl,16 
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne lo_level1

    l11_level1:
    mov temp,4
    mov temp1,15
    cmp lives,1
    jne reverseY_level1
    l1_level1:
    mov dl,8
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne l1_level1
    jmp reverseY_level1

gameOverBall_level1:
dec lives
cmp lives,0
jne display_less_level1
mov gameOver,1

finishUpdate_level1:
mov ballY,al
ret

updateBall_level1 endp

checkLine1_level1 proc
cmp [ballDY],1
je first_above_level1
jmp first_down_level1
going_update1_level1:
    call updateScore_level1
    call clearBrickLine1_level1
    jmp nextBrick1_level1
first_down_level1:
mov brickHit,0
mov al,[box_line1_y]
inc al
cmp al,[ballY]
jne exitCheck1_level1
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick1_level1

first_above_level1:
mov brickHit,0
mov al,[box_line1_y]
cmp al,[ballY]
jne exitCheck1_level1
mov currentBrickIndex,0
mov ecx,6

checkBrick1_level1:
push ecx
movzx esi,currentBrickIndex
mov al,box_line1_status[esi]
cmp al,0
je nextBrick1_level1
mov al,ballX
cmp al,box_line1_x_start[esi]
jl nextBrick1_level1
cmp al,box_line1_x_end[esi]
jg nextBrick1_level1

dec box_line1_status[esi]
mov brickHit,1
mov cl,box_line1_status[esi]
cmp cl,0
je going_update1_level1
cmp cl,1
je going_update1_level1

nextBrick1_level1:
pop ecx
inc currentBrickIndex
loop checkBrick1_level1

exitCheck1_level1:
ret
checkLine1_level1 endp

checkLine2_level1 proc
cmp [ballDY],1
je second_above_level1
jmp second_down_level1
going_update2_level1:
    call updateScore_level1
    call clearBrickLine2_level1
    jmp nextBrick2_level1
second_down_level1:
mov brickHit,0
mov al,[box_line2_y]
inc al
cmp al,[ballY]
jne exitCheck2_level1
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick2_level1

second_above_level1:
mov brickHit,0
mov al,[box_line1_y]
inc al
cmp al,[ballY]
jne exitCheck2_level1
mov currentBrickIndex,0
mov ecx,6

checkBrick2_level1:
push ecx
movzx esi,currentBrickIndex
mov al,box_line2_status[esi]
cmp al,0
je nextBrick2_level1

mov al,ballX
cmp al,box_line2_x_start[esi]
jl nextBrick2_level1
cmp al,box_line2_x_end[esi]
jg nextBrick2_level1

dec box_line2_status[esi]
mov brickHit,1
mov cl,box_line2_status[esi]
cmp cl,0
je going_update2_level1
cmp cl,1
je going_update2_level1

nextBrick2_level1:
pop ecx
inc currentBrickIndex
loop checkBrick2_level1

exitCheck2_level1:
ret
checkLine2_level1 endp

checkLine3_level1 proc
cmp [ballDY],1
je third_above_level1
jmp third_down_level1
going_update3_level1:
    call updateScore_level1
    call clearBrickLine3_level1
    jmp nextBrick3_level1
third_down_level1:
mov brickHit,0
mov al,[box_line3_y]
inc al
cmp al,[ballY]
jne exitCheck3_level1
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick3_level1

third_above_level1:
mov brickHit,0
mov al,[box_line3_y]
cmp al,[ballY]
jne exitCheck3_level1
mov currentBrickIndex,0
mov ecx,6

checkBrick3_level1:
push ecx
movzx esi,currentBrickIndex
mov al,box_line3_status[esi]
cmp al,0
je nextBrick3_level1

mov al,ballX
cmp al,box_line3_x_start[esi]
jl nextBrick3_level1
cmp al,box_line3_x_end[esi]
jg nextBrick3_level1

dec box_line3_status[esi]
mov brickHit,1
mov cl,box_line3_status[esi]
cmp cl,0
je going_update3_level1
cmp cl,1
je going_update3_level1

nextBrick3_level1:
pop ecx
inc currentBrickIndex
loop checkBrick3_level1

exitCheck3_level1:
ret
checkLine3_level1 endp

checkLine4_level1 proc
cmp [ballDY],1
je fourth_above_level1
jmp fourth_down_level1
going_update4_level1:
    call updateScore_level1
    call clearBrickLine4_level1
    jmp nextBrick4_level1
fourth_down_level1:
mov brickHit,0
mov al,[box_line4_y]
inc al
cmp al,[ballY]
jne exitCheck4_level1
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick4_level1

fourth_above_level1:
mov brickHit,0
mov al,[box_line4_y]
cmp al,[ballY]
jne exitCheck4_level1
mov currentBrickIndex,0
mov ecx,6

checkBrick4_level1:
push ecx
movzx esi,currentBrickIndex
mov al,box_line4_status[esi]
cmp al,0
je nextBrick4_level1

mov al,ballX
cmp al,box_line4_x_start[esi]
jl nextBrick4_level1
cmp al,box_line4_x_end[esi]
jg nextBrick4_level1

dec box_line4_status[esi]
mov brickHit,1
mov cl,box_line4_status[esi]
cmp cl,0
je going_update4_level1
cmp cl,1
je going_update4_level1


nextBrick4_level1:
pop ecx
inc currentBrickIndex
loop checkBrick4_level1

exitCheck4_level1:
ret
checkLine4_level1 endp

checkLine5_level1 proc
cmp [ballDY],1
je fifth_above_level1
jmp fifth_down_level1
going_update5_level1:
    call updateScore_level1
    call clearBrickLine5_level1
    jmp nextBrick5_level1

fifth_down_level1:
mov brickHit,0
mov al,[box_line5_y]
inc al
cmp al,[ballY]
jne exitCheck5_level1
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick5_level1

fifth_above_level1:
mov brickHit,0
mov al,[box_line5_y]
dec al
cmp al,[ballY]
jne exitCheck5_level1
mov currentBrickIndex,0
mov ecx,6

checkBrick5_level1:
push ecx
movzx esi,currentBrickIndex
mov al,box_line5_status[esi]
cmp al,0
je nextBrick5_level1


mov al,ballX
cmp al,box_line5_x_start[esi]
jl nextBrick5_level1
cmp al,box_line5_x_end[esi]
jg nextBrick5_level1

dec box_line5_status[esi]
mov brickHit,1
mov cl,box_line5_status[esi]
cmp cl,0
je going_update5_level1
cmp cl,1
je going_update5_level1


nextBrick5_level1:
pop ecx
inc currentBrickIndex
loop checkBrick5_level1

exitCheck5_level1:
ret
checkLine5_level1 endp


clearBrickLine1_level1 proc

movzx esi,currentBrickIndex
movzx edx,box_line1_y
shl edx,8
movzx eax,box_line1_x_start[esi]
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
mov temp,ebx
dec temp
l9_level1:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l9_level1
sub eax,ebx
inc eax
mov box_line1_x_end[esi],0
mov box_line1_x_start[esi],0
mov box_line1_x_end[esi],0
ret
clearBrickLine1_level1 endp

clearBrickLine2_level1 proc
movzx esi,currentBrickIndex
movzx edx,box_line2_y
shl edx,8
movzx eax,box_line2_x_start[esi]
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l10_level1:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l10_level1
sub eax,ebx
inc eax
ret
clearBrickLine2_level1 endp

clearBrickLine3_level1 proc

movzx esi,currentBrickIndex
movzx edx,box_line3_y
shl edx,8
movzx eax,box_line3_x_start[esi]
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l11_level1:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l11_level1
sub eax,ebx
inc eax
ret
clearBrickLine3_level1 endp

clearBrickLine4_level1 proc
movzx esi,currentBrickIndex
movzx edx,box_line4_y
shl edx,8
movzx eax,box_line4_x_start[esi]
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
dec temp
l12_level1:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l12_level1
sub eax,ebx
inc eax
ret
clearBrickLine4_level1 endp

clearBrickLine5_level1 proc
movzx esi,currentBrickIndex
movzx edx,box_line5_y
shl edx,8
movzx eax,box_line5_x_start[esi]
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l13_level1:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l13_level1
sub eax,ebx
inc eax
ret
clearBrickLine5_level1 endp

clearBall_level1 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call settextcolor

mov edx,offset emptychar
call writestring
ret
clearBall_level1 endp

drawBall_level1 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,white+(black*16)
call settextcolor

mov edx,offset ballchar
call writestring
ret
drawBall_level1 endp


GetInput proc
mov edx,offset input_buffer
call ReadChar
mov al,[input_buffer]
ret
GetInput endp

clearPaddle_level1 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,black+(black*16)
call settextcolor
mov edx,offset boxs1
call writestring
ret
clearPaddle_level1 endp

drawPaddle_level1 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,white+(white*16)
call settextcolor
mov edx,offset paddle1
call writestring
ret
drawPaddle_level1 endp

updateScore_level1 proc
mov ebx,2;reseting score inc

mov al,ballY
    cmp al,[box_line1_y]
    jne checkLine22_level1
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore1_level1
    cmp esi,5
    je redScore1_level1
    cmp esi,1
    je blueScore1_level1
    cmp esi,4
    je blueScore1_level1
    jmp applyScore_level1

redScore1_level1:
    mov ebx, 4
    jmp applyScore_level1

blueScore1_level1:
    mov ebx, 5
    jmp applyScore_level1

    ; Line 2 (ballY == box_line2_y)
checkLine22_level1:
    mov al,ballY
    cmp al,[box_line2_y]
    jne checkLine33_level1
    
    movzx esi,currentBrickIndex
    cmp esi,1
    je redScore2_level1
    cmp esi,2
    je redScore2_level1
    cmp esi,5
    je redScore2_level1
    cmp esi,0
    je blueScore2_level1
    jmp applyScore_level1

redScore2_level1:
    mov ebx, 4
    jmp applyScore_level1

blueScore2_level1:
    mov ebx, 5
    jmp applyScore_level1

    ; Line 3 (ballY == box_line3_y)
checkLine33_level1:
    mov al,ballY
    cmp al,[box_line3_y]
    jne checkLine44_level1
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore3_level1
    cmp esi,3
    je redScore3_level1
    cmp esi,4
    je blueScore3_level1
    cmp esi,5
    je blueScore3_level1
    jmp applyScore_level1

redScore3_level1:
    mov ebx, 4
    jmp applyScore_level1

blueScore3_level1:
    mov ebx, 5
    jmp applyScore_level1
checkLine44_level1:
    mov al,ballY
    cmp al,[box_line4_y]
    jne checkLine55_level1
    
    movzx esi,currentBrickIndex
    cmp esi,4
    je redScore4_level1
    cmp esi,5
    je redScore4_level1
    cmp esi,2
    je blueScore4_level1
    jmp applyScore_level1
redScore4_level1:
    mov ebx, 4
    jmp applyScore_level1

blueScore4_level1:
    mov ebx, 5
    jmp applyScore_level1

    ; Line 5 (ballY == box_line5_y)
checkLine55_level1:
    mov al,ballY
    cmp al,[box_line5_y]
    jne applyScore_level1
    movzx esi,currentBrickIndex
    cmp esi,2
    je redScore5_level1
    jmp applyScore_level1

redScore5_level1:
    mov ebx, 4

applyScore_level1:
    add score, ebx
    call displayScore_level1

scoreExit_level1:
ret
updateScore_level1 endp

CheckScoreWinCondition_level1 PROC
    mov eax, score
    cmp ax, MAX_SCORE
    jae PlayerWins_level1
    ret

PlayerWins_level1:
    ;mov gameOver, 1
    call Winlvl1_level1
    ret
CheckScoreWinCondition_level1 ENDP

displayScore_level1 proc
mov dh,9
mov dl,3
call gotoxy
mov eax,white+(black*16)
call setTextcolor
mov edx,offset scoreLabel
call writestring
mov eax,score
call WriteDec
ret
displayScore_level1 endp

exit1_level1 proc
       call lost_game
       mov eax,red+(black*16)
    call settextcolor
    call waitmsg
    call display_menu
ret
exit1_level1 endp

winlvl1_level1 proc
    call won_game
    mov eax,red+(black*16)
    call settextcolor
    call waitmsg
    call display_menu
ret
winlvl1_level1 endp

prep_level2 proc;------------------------------------------------------------02---------------------------------------------------------------------
mov box_line1_status2[0],2
mov box_line1_status2[1],0
mov box_line1_status2[2],2
mov box_line1_status2[3],2
mov box_line1_status2[4],2
mov box_line1_status2[5],2
mov box_line2_status2[0],2
mov box_line2_status2[1],2
mov box_line2_status2[2],0
mov box_line2_status2[3],2
mov box_line2_status2[4],2
mov box_line2_status2[5],2
mov box_line3_status2[0],2
mov box_line3_status2[1],0
mov box_line3_status2[2],2
mov box_line3_status2[3],2
mov box_line3_status2[4],2
mov box_line3_status2[5],2
mov box_line4_status2[0],2
mov box_line4_status2[1],0
mov box_line4_status2[2],0
mov box_line4_status2[3],0
mov box_line4_status2[4],0
mov box_line4_status2[5],0
mov box_line5_status2[0],0
mov box_line5_status2[1],2
mov box_line5_status2[2],2
mov box_line5_status2[3],2
mov box_line5_status2[4],2
mov box_line5_status2[5],2
mov lives,3
mov score,0
mov cordinatexline,6
mov cordinateballx,70
mov cordinatebally,20
mov ballX,70
mov ballY,20
mov gameover,0
mov paddlex_start,64
mov ballDX,1
mov ballDY,1

call clrscr
call Randomize
    mov ecx,1
    mov ebx,5
    mov eax,cyan+(black*16)
    call SetTextColor
        mov edx, offset level_line1
        call WriteString
        
                call crlf
        mov edx, offset level_line2
        call WriteString
            call crlf
        mov edx, offset level_line3
            call WriteString
       
        call crlf
        mov edx, offset level_line4
            call WriteString
       
        call crlf
        mov edx, offset level_line5
    call WriteString
            call crlf
    mov dh,cordinatexline
    mov dl,0
    call Gotoxy
    l1_level2:
    mov edx, offset box2
    call WriteString
    cmp ecx,1
    je topbottom_level2
    cmp ecx,26
    je en_level2
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset sideline
    call WriteString
    cmp cordinatexline,29
    je space_print_level2
    cmp cordinatexline,30
    je space_print_level2
    l2_level2:
        mov dh,cordinatexline
        mov dl,36
        call Gotoxy
        cmp ecx,3
        je ran3_level2
        cmp ecx,5
        je ran5_level2
        cmp ecx,7
        je ran7_level2
        cmp ecx,9
        je ran9_level2
        cmp ecx,11
        je ran11_level2
        jmp l3_level2

    space_print_level2:
        mov eax,black+(black*16)
        mov edx, offset boxs
        call WriteString
        mov eax,cyan+(black*16)
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level2

    l3_level2:
        mov dh,cordinatexline
        mov dl,101
        call Gotoxy
        mov eax,cyan+(black*16)
        call SetTextColor
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level2

    
    topbottom_level2:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov dh,cordinatexline
    mov edx, offset topbottomline
    call WriteString
    inc cordinatexline
    inc ecx
    mov ebx,5
    call crlf
    jmp l1_level2

        ;<----------------------------------------------------------------------------line1--------------------------------------->
    ran3_level2:
    boxx1_level2:
    mov esi, offset box_line1_status2
    mov al, [esi]                   
    cmp al, 0                  
    je boxx2_level2             
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    
    boxx2_level2:
    mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp eax,0
    je boxx3_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        
    boxx3_level2:
    mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx4_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString

    boxx4_level2:
    mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx5_level2
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov dh,cordinatexline
    mov dl,76
    call Gotoxy

    boxx5_level2:
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx6_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString

    boxx6_level2:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je l3_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level2
    
    
        ;<----------------------------------------------------------------------------line2--------------------------------------->
    ran5_level2:
    box21_level2:
    mov esi, offset box_line2_status2
    mov al, [esi]                   
    cmp al, 0                  
    je box22_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box22_level2:
    mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box23_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        

    box23_level2:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box24_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box24_level2:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box25_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box25_level2:
    mov dh,cordinatexline
    mov dl,72
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box26_level2
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString



    box26_level2:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level2
    
    

        ;<----------------------------------------------------------------------------line3--------------------------------------->
    ran7_level2:
    box31_level2:
    mov esi, offset box_line3_status2 
    mov al, [esi]                   
    cmp al, 0                  
    je box32_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString

    
    box32_level2:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box33_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

        
    box33_level2:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box34_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString


    box34_level2:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box35_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
  

    box35_level2:
      mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box36_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box36_level2:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level2
    
    ;<----------------------------------------------------------------------------line4--------------------------------------->
    ran9_level2:
    box41_level2:
    mov esi, offset box_line4_status2  
    mov al, [esi]                   
    cmp al, 0                  
    je box42_level2
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
 
    
    box42_level2:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box43_level2
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

        
    box43_level2:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box44_level2
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString


    box44_level2:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box45_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString


    box45_level2:
        mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box46_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString


    box46_level2:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level2
    
    
    ;<----------------------------------------------------------------------------line5--------------------------------------->
    ran11_level2:
    
     
    box51_level2:
    mov esi, offset box_line5_status2  
    mov al, [esi]                   
    cmp al, 0                  
    je box52_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
  

    box52_level2:
      mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box53_level2
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
 
        

    box53_level2:
     mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box54_level2
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString

    box54_level2:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box55_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString



    box55_level2:
        mov dh,cordinatexline
    mov dl,72
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box56_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString




    box56_level2:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level2
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level2

    en_level2:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset topbottomline
    call WriteString
    call crlf
    mov dh,15
    mov dl,0
    call Gotoxy
    mwrite "*** *** *** *** *** ***"
    mov dh,16
    mov dl,0
    call Gotoxy
    mwrite " *****   *****   *****"
    mov dh,17
    mov dl,0
        call Gotoxy
    mwrite "  ***     ***     ***"
    mov dh,18
    mov dl,0    
    call Gotoxy
    mwrite "   *       *       * "
    
    call displayScore2_level2
    
    GameLoop_level2:

    mov eax,65
    call delay
    call ReadKey
    jz noPaddleMove_level2
    cmp al,'p'
    je pauseGame_level2
    cmp al,'P'
    je pauseGame_level2
    cmp al,'a'
    je moveleft_level2
    cmp al,'A'
    je moveleft_level2
    cmp al,'d'
    je moveRight_level2
    cmp al,'D'
    je moveRight_level2
    jmp redrawPaddle_level2

pauseGame_level2:
call displayPauseMessage_level1
pauseLoop_level2:
call ReadKey
jz pauseLoop_level2
call clearPauseMessage_level1
jmp GameLoop_level2

moveLeft_level2:
call clearPaddle2_level2
cmp paddlex_start,33
jle updateBallandPaddle_level2
sub paddlex_start,2
jmp updateBallandPaddle_level2

moveRight_level2:
call clearPaddle2_level2
cmp paddlex_start,90
jge updateBallandPaddle_level2
add paddlex_start,2
;jmp redrawOnlyPaddle_level2
jmp updateBallandPaddle_level2
noPaddleMove_level2:
call clearPaddle2_level2


updateBallandPaddle_level2:
call updateBall2_level2
call drawBall_level2
cmp gameOver,1
je exit1_level1
cmp check,1
je winlvl1_level1
call CheckScoreWinCondition2_level2
call drawPaddle2_level2

jmp GameLoop_level2


checkBall_level2:
call updateBall2_level2
cmp gameOver,1
je exit1_level1


redrawPaddle_level2:
call clearPaddle2_level2
call drawPaddle2_level2
jmp GameLoop_level2

redrawOnlyPaddle_level2:
call drawPaddle2_level2
jmp GameLoop_level2

ret
prep_level2 endp

updateBall2_level2 proc

call clearBall_level2
mov al,ballX
mov bl,ballDX
add al,bl

cmp al,34
jle leftBoundary_level2
cmp al,100
jge rightBoundary_level2
jmp checkBricks_level2

leftBoundary_level2:
mov al,34
neg ballDX
jmp checkBricks_level2

rightBoundary_level2:
mov al,100
neg ballDX
jmp checkBricks_level2

checkBricks_level2:
mov ballX,al
mov al,ballY
cmp al,1
jl checkY_level2
cmp al,14
jg checkY_level2

call checkLine12_level2
cmp brickHit,1
je brickCollision_level2

call checkLine22_level2
cmp brickHit,1
je brickCollision_level2

call checkLine32_level2
cmp brickHit,1
je brickCollision_level2

call checkLine4_level2
cmp brickHit,1
je brickCollision_level2

call checkLine5_level2
cmp brickHit,1
je brickCollision_level2

jmp checkY_level2

brickCollision_level2:
neg ballDY
mov brickHit,0



checkY_level2:
mov al,ballY
mov bl,ballDY
add al,bl
cmp al,3
jle reverseY_level2

cmp al,26
jge checkPaddleHit_level2
jmp finishUpdate_level2

reverseY_level2:
neg ballDY
mov al,ballY
mov bl,ballDY
add al,bl
jmp finishUpdate_level2

checkPaddleHit_level2:
mov bl,ballX
cmp bl,paddlex_start
jl missedPaddle_level2
mov cl,paddlex_start
add cl,10
cmp bl,cl
jg missedPaddle_level2

sub bl,paddlex_start

cmp bl,5
je middlePaddleHit_level2

cmp bl,3
jl leftPaddlehit_level2

cmp bl,7
jg rightPaddlehit_level2

jmp standardPaddleHit_level2

middlePaddleHit_level2:
mov ballDX,0
neg ballDY
jmp finishUpdate_level2

leftPaddleHit_level2:
mov ballDX,-1
neg ballDY
jmp finishUpdate_level2

rightPaddleHit_level2:
mov ballDX,1
neg ballDY
jmp finishUpdate_level2

standardPaddleHit_level2:
neg ballDY
jmp finishUpdate_level2


;neg ballDY
;mov al,26
;jmp finishUpdate

missedPaddle_level2:
cmp al,28
jge gameOverBall_level2
jmp finishUpdate_level2

display_less_level2:
    mov temp,4
    mov temp1,15
    cmp lives,2
    jne l11_level2
    lo_level2:
    mov dl,16 
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne lo_level2

    l11_level2:
    mov temp,4
    mov temp1,15
    cmp lives,1
    jne reverseY_level2
    l1_level2:
    mov dl,8
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne l1_level2
    jmp reverseY_level2

gameOverBall_level2:
dec lives
cmp lives,0
jne display_less_level2
mov gameOver,1

finishUpdate_level2:
mov ballY,al
ret

updateBall2_level2 endp

checkLine12_level2 proc
cmp [ballDY],1
je first_above_level2
jmp first_down_level2
going_update1_level2:
    call updateScore2_level2
    call clearBrickLine1_level2
    jmp nextBrick1_level2
first_down_level2:
mov brickHit,0
mov al,[box_line1_y]
inc al
cmp al,[ballY]
jne exitCheck1_level2
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick1_level2

first_above_level2:
mov brickHit,0
mov al,[ballY]
inc al
cmp al,[box_line1_y]
jne exitCheck1_level2
mov currentBrickIndex,0
mov ecx,6

checkBrick1_level2:
push ecx
movzx esi,currentBrickIndex
mov al,box_line1_status2[esi]
cmp al,0
je nextBrick1_level2
mov al,ballX
cmp al,box_line1_x_start[esi]
jl nextBrick1_level2
cmp al,box_line1_x_end[esi]
jg nextBrick1_level2

dec box_line1_status2[esi]
mov brickHit,1
mov cl,box_line1_status2[esi]
cmp cl,0
je going_update1_level2
cmp cl,1
je going_update1_level2

nextBrick1_level2:
pop ecx
inc currentBrickIndex
loop checkBrick1_level2

exitCheck1_level2:
ret
checkLine12_level2 endp

checkLine22_level2 proc
cmp [ballDY],1
je second_above_level2
jmp second_down_level2
going_update2_level2:
    call updateScore2_level2
    call clearBrickLine22_level2
    jmp nextBrick2_level2
second_down_level2:
mov brickHit,0
mov al,[box_line2_y]
inc al
cmp al,[ballY]
jne exitCheck2_level2
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick2_level2

second_above_level2:
mov brickHit,0
mov al,[box_line1_y]
inc al
cmp al,[ballY]
jne exitCheck2_level2
mov currentBrickIndex,0
mov ecx,6

checkBrick2_level2:
push ecx
movzx esi,currentBrickIndex
mov al,box_line2_status2[esi]
cmp al,0
je nextBrick2_level2

mov al,ballX
cmp al,box_line2_x_start[esi]
jl nextBrick2_level2
cmp al,box_line2_x_end[esi]
jg nextBrick2_level2

dec box_line2_status2[esi]
mov brickHit,1
mov cl,box_line2_status2[esi]
cmp cl,0
je going_update2_level2
cmp cl,1
je going_update2_level2

nextBrick2_level2:
pop ecx
inc currentBrickIndex
loop checkBrick2_level2

exitCheck2_level2:
ret
checkLine22_level2 endp

checkLine32_level2 proc
cmp [ballDY],1
je third_above_level2
jmp third_down_level2
going_update3_level2:
    call updateScore2_level2
    call clearBrickLine32_level2
    jmp nextBrick3_level2
third_down_level2:
mov brickHit,0
mov al,[box_line3_y]
inc al
cmp al,[ballY]
jne exitCheck3_level2
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick3_level2

third_above_level2:
mov brickHit,0
mov al,[box_line3_y]
cmp al,[ballY]
jne exitCheck3_level2
mov currentBrickIndex,0
mov ecx,6

checkBrick3_level2:
push ecx
movzx esi,currentBrickIndex
mov al,box_line3_status2[esi]
cmp al,0
je nextBrick3_level2

mov al,ballX
cmp al,box_line3_x_start[esi]
jl nextBrick3_level2
cmp al,box_line3_x_end[esi]
jg nextBrick3_level2

dec box_line3_status2[esi]
mov brickHit,1
mov cl,box_line3_status2[esi]
cmp cl,0
je going_update3_level2
cmp cl,1
je going_update3_level2

nextBrick3_level2:
pop ecx
inc currentBrickIndex
loop checkBrick3_level2

exitCheck3_level2:
ret
checkLine32_level2 endp

checkLine4_level2 proc
cmp [ballDY],1
je fourth_above_level2
jmp fourth_down_level2
going_update4_level2:
    call updateScore2_level2
    call clearBrickLine42_level2
    jmp nextBrick4_level2
fourth_down_level2:
mov brickHit,0
mov al,[box_line4_y]
inc al
cmp al,[ballY]
jne exitCheck4_level2
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick4_level2

fourth_above_level2:
mov brickHit,0
mov al,[ballY]
inc al
cmp al,[box_line4_y]
jne exitCheck4_level2
mov currentBrickIndex,0
mov ecx,6

checkBrick4_level2:
push ecx
movzx esi,currentBrickIndex
mov al,box_line4_status2[esi]
cmp al,0
je nextBrick4_level2

mov al,ballX
cmp al,box_line4_x_start[esi]
jl nextBrick4_level2
cmp al,box_line4_x_end[esi]
jg nextBrick4_level2

dec box_line4_status2[esi]
mov brickHit,1
mov cl,box_line4_status2[esi]
cmp cl,0
je going_update4_level2
cmp cl,1
je going_update4_level2


nextBrick4_level2:
pop ecx
inc currentBrickIndex
loop checkBrick4_level2

exitCheck4_level2:
ret
checkLine4_level2 endp

checkLine5_level2 proc
cmp [ballDY],1
je fifth_above_level2
jmp fifth_down_level2
going_update5_level2:
    call updateScore2_level2
    call clearBrickLine52_level2
    jmp nextBrick5_level2

fifth_down_level2:
mov brickHit,0
mov al,[box_line5_y]
inc al
cmp al,[ballY]
jne exitCheck5_level2
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick5_level2

fifth_above_level2:
mov brickHit,0
mov al,[box_line5_y]
dec al
cmp al,[ballY]
jne exitCheck5_level2
mov currentBrickIndex,0
mov ecx,6

checkBrick5_level2:
push ecx
movzx esi,currentBrickIndex
mov al,box_line5_status2[esi]
cmp al,0
je nextBrick5_level2


mov al,ballX
cmp al,box_line5_x_start[esi]
jl nextBrick5_level2
cmp al,box_line5_x_end[esi]
jg nextBrick5_level2

dec box_line5_status2[esi]
mov brickHit,1
mov cl,box_line5_status2[esi]
cmp cl,0
je going_update5_level2
cmp cl,1
je going_update5_level2


nextBrick5_level2:
pop ecx
inc currentBrickIndex
loop checkBrick5_level2

exitCheck5_level2:
ret
checkLine5_level2 endp

clearBrickLine1_level2 proc

movzx esi,currentBrickIndex
movzx edx,box_line1_y
shl edx,8
movzx eax,box_line1_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line1_status2[esi]
cmp al,1
je changeColor1_level2
cmp al,0
je clearBrick1_level2

changeColor1_level2:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
dec temp
l14_level2:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l14_level2
ret

clearBrick1_level2:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
mov temp,ebx
dec temp
l9_level2:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l9_level2
sub eax,ebx
inc eax
mov box_line1_x_end[esi],0
mov box_line1_x_start[esi],0
mov box_line1_x_end[esi],0
ret
clearBrickLine1_level2 endp

clearBrickLine22_level2 proc
movzx esi,currentBrickIndex
movzx edx,box_line2_y
shl edx,8
movzx eax,box_line2_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line2_status2[esi]
cmp al,1
je changeColor2_level2
cmp al,0
je clearBrick2_level2

changeColor2_level2:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l15_level2:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l15_level2
ret

clearBrick2_level2:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l10_level2:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l10_level2
sub eax,ebx
inc eax
ret
clearBrickLine22_level2 endp

clearBrickLine32_level2 proc

movzx esi,currentBrickIndex
movzx edx,box_line3_y
shl edx,8
movzx eax,box_line3_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line3_status2[esi]
cmp al,1
je changeColor3_level2
cmp al,0
je clearBrick3_level2

changeColor3_level2:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l16_level2:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l16_level2
ret

clearBrick3_level2:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l11_level2:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l11_level2
sub eax,ebx
inc eax
ret
clearBrickLine32_level2 endp

clearBrickLine42_level2 proc
movzx esi,currentBrickIndex
movzx edx,box_line4_y
shl edx,8
movzx eax,box_line4_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line4_status2[esi]
cmp al,1
je changeColor4_level2
cmp al,0
je clearBrick4_level2

changeColor4_level2:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line4_x_start[esi]
movzx eax,box_line4_x_end[esi]
mov temp,ebx
dec temp
l17_level2:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l17_level2
ret

clearBrick4_level2:

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line4_x_start[esi]
movzx eax,box_line4_x_end[esi]
mov temp,ebx
dec temp
l12_level2:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l12_level2
sub eax,ebx
inc eax
ret
clearBrickLine42_level2 endp

clearBrickLine52_level2 proc
movzx esi,currentBrickIndex
movzx edx,box_line5_y
shl edx,8
movzx eax,box_line5_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line5_status2[esi]
cmp al,1
je changeColor5_level2
cmp al,0
je clearBrick5_level2

changeColor5_level2:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l18_level2:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l18_level2
ret

clearBrick5_level2:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l13_level2:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l13_level2
sub eax,ebx
inc eax
ret
clearBrickLine52_level2 endp

clearBall_level2 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call settextcolor

mov edx,offset emptychar
call writestring
ret
clearBall_level2 endp

drawBall_level2 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,white+(black*16)
call settextcolor

mov edx,offset ballchar
call writestring
ret
drawBall_level2 endp


GetInput2 proc
mov edx,offset input_buffer
call ReadChar
mov al,[input_buffer]
ret
GetInput2 endp

clearPaddle2_level2 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,black+(black*16)
call settextcolor
mov edx,offset paddle2
call writestring
ret
clearPaddle2_level2 endp

drawPaddle2_level2 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,white+(white*16)
call settextcolor
mov edx,offset paddle2
call writestring
ret
drawPaddle2_level2 endp

updateScore2_level2 proc
mov ebx,3;reseting score inc

mov al,ballY
    cmp al,[box_line1_y]
    jne checkLine222_level2
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore1_level2
    cmp esi,5
    je redScore1_level2
    cmp esi,1
    je blueScore1_level2
    cmp esi,4
    je blueScore1_level2
    jmp applyScore_level2

redScore1_level2:
    mov ebx, 5
    jmp applyScore_level2

blueScore1_level2:
    mov ebx, 6
    jmp applyScore_level2

    ; Line 2 (ballY == box_line2_y)
checkLine222_level2:
    mov al,ballY
    cmp al,[box_line2_y]
    jne checkLine33_level2
    
    movzx esi,currentBrickIndex
    cmp esi,1
    je redScore2_level2
    cmp esi,2
    je redScore2_level2
    cmp esi,5
    je redScore2_level2
    cmp esi,0
    je blueScore2_level2
    jmp applyScore_level2

redScore2_level2:
    mov ebx, 5
    jmp applyScore_level2

blueScore2_level2:
    mov ebx, 6
    jmp applyScore_level2

    ; Line 3 (ballY == box_line3_y)
checkLine33_level2:
    mov al,ballY
    cmp al,[box_line3_y]
    jne checkLine44_level2
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore3_level2
    cmp esi,3
    je redScore3_level2
    cmp esi,4
    je blueScore3_level2
    cmp esi,5
    je blueScore3_level2
    jmp applyScore_level2

redScore3_level2:
    mov ebx, 5
    jmp applyScore_level2

blueScore3_level2:
    mov ebx, 6
    jmp applyScore_level2
checkLine44_level2:
    mov al,ballY
    cmp al,[box_line4_y]
    jne checkLine55_level2
    
    movzx esi,currentBrickIndex
    cmp esi,4
    je redScore4_level2
    cmp esi,5
    je redScore4_level2
    cmp esi,2
    je blueScore4_level2
    jmp applyScore_level2

redScore4_level2:
    mov ebx, 5
    jmp applyScore_level2

blueScore4_level2:
    mov ebx, 6
    jmp applyScore_level2

    ; Line 5 (ballY == box_line5_y)
checkLine55_level2:
    mov al,ballY
    cmp al,[box_line5_y]
    jne applyScore_level2
    movzx esi,currentBrickIndex
    cmp esi,2
    je redScore5_level2
    jmp applyScore_level2

redScore5_level2:
    mov ebx, 5

applyScore_level2:
    add score, ebx
    call displayScore2_level2

scoreExit_level2:
ret
updateScore2_level2 endp

displayScore2_level2 proc
mov dh,9
mov dl,3
call gotoxy
mov eax,white+(black*16)
call setTextcolor
mov edx,offset scoreLabel
call writestring
mov eax,score
call WriteDec
ret
displayScore2_level2 endp

CheckScoreWinCondition2_level2 PROC
    mov eax, score
    cmp ax, MAX_SCORE2
    jae PlayerWins_level2
    ret

PlayerWins_level2:
    ;mov gameOver, 1
    call Winlvl1_level1
    ret
CheckScoreWinCondition2_level2 ENDP



prep_level3 proc;------------------------------------------------------------03---------------------------------------------------------------------
mov box_line1_status3[0],3
mov box_line1_status3[1],0
mov box_line1_status3[2],3
mov box_line1_status3[3],3
mov box_line1_status3[4],3
mov box_line1_status3[5],3
mov box_line2_status3[0],3
mov box_line2_status3[1],3
mov box_line2_status3[2],0
mov box_line2_status3[3],250
mov box_line2_status3[4],3
mov box_line2_status3[5],3
mov box_line3_status3[0],3
mov box_line3_status3[1],0
mov box_line3_status3[2],3
mov box_line3_status3[3],3
mov box_line3_status3[4],3
mov box_line3_status3[5],250
mov box_line4_status3[0],3
mov box_line4_status3[1],0
mov box_line4_status3[2],0
mov box_line4_status3[3],0
mov box_line4_status3[4],0
mov box_line4_status3[5],0
mov box_line5_status3[0],0
mov box_line5_status3[1],3
mov box_line5_status3[2],3
mov box_line5_status3[3],3
mov box_line5_status3[4],3
mov box_line5_status3[5],3
mov lives,3
mov score,0
mov cordinatexline,6
mov cordinateballx,70
mov cordinatebally,20
mov ballX,70
mov ballY,20
mov gameover,0
mov paddlex_start,64
mov ballDX,1
mov ballDY,1


call clrscr
call Randomize
random_bricks_level3:
mov eax,5
call RandomRange
mov [special_line],al
mov eax,6
call RandomRange
mov [special_index],al
cmp special_line,0
je l111_level3
cmp special_line,1
je l222_level3
cmp special_line,2
je l333_level3
cmp special_line,3
je l444_level3
cmp special_line,4
je l555_level3
l111_level3:
    cmp special_index,1
    je random_bricks_level3
     jmp assigning_level3
l222_level3:
    cmp special_index,2
    je random_bricks_level3
    cmp special_index,5
    je random_bricks_level3
     jmp assigning_level3
l333_level3:
    cmp special_index,2
    je random_bricks_level3
    jmp assigning_level3
l444_level3:
    cmp special_index,0
    jne random_bricks_level3
     jmp assigning_level3
l555_level3:
    cmp special_index,0
    je random_bricks_level3
     jmp assigning_level3

assigning_level3:
    cmp special_line,0
    je random_bricks1_level3
    cmp special_line,1
    je random_bricks2_level3
    cmp special_line,2
    je random_bricks3_level3
    cmp special_line,3
    je random_bricks4_level3
    cmp special_line,4
    je random_bricks5_level3

    random_bricks1_level3:
    movzx esi,special_index
    mov box_line1_status3[esi],1
    mov al,box_line1_y
    mov [special_line],al
    mov al,box_line1_x_start[esi]
    mov [special_x_start],al
    mov al,box_line1_x_end[esi]
    mov [special_x_end],al
    jmp mai_level3
    random_bricks2_level3:
       movzx esi,special_index
     mov box_line2_status3[esi],1
         mov al,box_line2_y
    mov [special_line],al
    mov al,box_line2_x_start[esi]
    mov [special_x_start],al
    mov al,box_line2_x_end[esi]
    mov [special_x_end],al
    jmp mai_level3
    random_bricks3_level3:
       movzx esi,special_index
       mov box_line3_status3[esi],1
           mov al,box_line3_y
    mov [special_line],al
    mov al,box_line3_x_start[esi]
    mov [special_x_start],al
    mov al,box_line3_x_end[esi]
    mov [special_x_end],al
    jmp mai_level3
    random_bricks4_level3:
       movzx esi,special_index
      mov box_line4_status3[esi],1
          mov al,box_line4_y
    mov [special_line],al
    mov al,box_line4_x_start[esi]
    mov [special_x_start],al
    mov al,box_line4_x_end[esi]
    mov [special_x_end],al
    jmp mai_level3
    random_bricks5_level3:
       movzx esi,special_index
      mov box_line5_status3[esi],1
          mov al,box_line5_y
    mov [special_line],al
     mov al,box_line5_x_start[esi]
    mov [special_x_start],al
    mov al,box_line5_x_end[esi]
    mov [special_x_end],al
    mai_level3:
    mov ecx,1
    mov ebx,5
    mov eax,cyan+(black*16)
    call SetTextColor
        mov edx, offset level_line13
        call WriteString
        
                call crlf
        mov edx, offset level_line23
        call WriteString
            call crlf
        mov edx, offset level_line33
            call WriteString
       
        call crlf
        mov edx, offset level_line43
            call WriteString
       
        call crlf
        mov edx, offset level_line53
    call WriteString
            call crlf
    mov dh,cordinatexline
    mov dl,0
    call Gotoxy
    l1_level3:
    mov edx, offset box2
    call WriteString
    cmp ecx,1
    je topbottom_level3
    cmp ecx,26
    je en_level3
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset sideline
    call WriteString
    cmp cordinatexline,29
    je space_print_level3
    cmp cordinatexline,30
    je space_print_level3
    l2_level3:
        mov dh,cordinatexline
        mov dl,36
        call Gotoxy
        cmp ecx,3
        je ran3_level3
        cmp ecx,5
        je ran5_level3
        cmp ecx,7
        je ran7_level3
        cmp ecx,9
        je ran9_level3
        cmp ecx,11
        je ran11_level3
        jmp l3_level3

    space_print_level3:
        mov eax,black+(black*16)
        mov edx, offset boxs
        call WriteString
        mov eax,cyan+(black*16)
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level3

    l3_level3:
        mov dh,cordinatexline
        mov dl,101
        call Gotoxy
        mov eax,cyan+(black*16)
        call SetTextColor
        mov edx, offset sideline
        call WriteString
        inc cordinatexline
        inc ecx
        mov ebx,5
        call crlf
        jmp l1_level3

    
    topbottom_level3:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov dh,cordinatexline
    mov edx, offset topbottomline
    call WriteString
    inc cordinatexline
    inc ecx
    mov ebx,5
    call crlf
    jmp l1_level3

        ;<----------------------------------------------------------------------------line1--------------------------------------->
    ran3_level3:
    boxx1_level3:
    mov esi, offset box_line1_status3  
    mov al, [esi]                   
    cmp al, 0                  
    je boxx2_level3                 
    cmp al, 1                 
    je special11_level3             
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp boxx2_level3
    
    special11_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line1_status3[0],1

    boxx2_level3:
    mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp eax,0
    je boxx3_level3
    cmp al, 1                 
    je special12_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
     jmp boxx3_level3

     special12_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        mov box_line1_status3[1],1

    boxx3_level3:
    mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx4_level3
    cmp al,1
    je special13_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp boxx4_level3

     special13_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line1_status3[2],1

    boxx4_level3:
    mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx5_level3
    cmp al,1
    je special14_level3
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    jmp boxx5_level3

     special14_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line1_status3[3],1

    boxx5_level3:
    add esi,1
    mov al, [esi] 
    cmp al,0
    je boxx6_level3
    cmp al,1
    je special15_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    jmp boxx6_level3

     special15_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    mov box_line1_status3[4],1

    boxx6_level3:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    add esi,1
    mov al, [esi] 
    cmp al,0
    je l3_level3
    cmp al,1
    je special16_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level3

     special16_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line1_status3[5],1

    jmp l3_level3
    
    
        ;<----------------------------------------------------------------------------line2--------------------------------------->
    ran5_level3:
    box21_level3:
    mov esi, offset box_line2_status3
    mov al, [esi]                   
    cmp al, 0                  
    je box22_level3
    cmp al, 1                  
    je special21_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    jmp box22_level3

    special21_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line2_status3[0],1

    box22_level3:
    mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box23_level3
    cmp al, 1                  
    je special22_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp box23_level3

    special22_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line2_status3[1],1

    box23_level3:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box24_level3
    cmp al, 1                  
    je special23_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
       jmp box24_level3

    special23_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line2_status3[2],1

    box24_level3:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box25_level3
    cmp al, 1                  
    je special24_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    jmp box25_level3

    special24_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    mov box_line2_status3[3],1

    box25_level3:
    mov dh,cordinatexline
    mov dl,72
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box26_level3
    cmp al, 1                  
    je special25_level3
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp box26_level3

    special25_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line2_status3[4],1

    box26_level3:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level3
    cmp al, 1                  
    je special26_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp l3_level3

    special26_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line2_status3[5],1
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy
    jmp l3_level3
    
    

        ;<----------------------------------------------------------------------------line3--------------------------------------->
    ran7_level3:
    box31_level3:
    mov esi, offset box_line3_status3  
    mov al, [esi]                   
    cmp al, 0                  
    je box32_level3
    cmp al, 1                  
    je special31_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp box32_level3
    
    special31_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line3_status3[0],1

    box32_level3:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box33_level3
    cmp al, 1                  
    je special32_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        jmp box33_level3
    
    special32_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line3_status3[1],1
        
    box33_level3:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box34_level3
    cmp al, 1                  
    je special33_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        jmp box34_level3
    
    special33_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line3_status3[2],1

    box34_level3:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box35_level3
    cmp al, 1                  
    je special34_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
  
      jmp box35_level3
    
    special34_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line3_status3[3],1

    box35_level3:
      mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi 
    mov al, [esi]                   
    cmp al, 0                  
    je box36_level3 
    cmp al, 1                  
    je special35_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
        jmp box36_level3
    
    special35_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    mov box_line3_status3[4],1

    box36_level3:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level3
    cmp al, 1                  
    je special36_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        mov dh,cordinatexline
    mov dl,101
    call Gotoxy
        jmp l3_level3
    
    special36_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line3_status3[5],1

    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level3
    
    ;<----------------------------------------------------------------------------line4--------------------------------------->
    ran9_level3:
    box41_level3:
    mov esi, offset box_line4_status3  
    mov al, [esi]                   
    cmp al, 0                  
    je box42_level3
    cmp al, 1                  
    je special41_level3
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    jmp box42_level3
     special41_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line4_status3[0],1
    
    box42_level3:
       mov dh,cordinatexline
    mov dl,49
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box43_level3
    cmp al, 1                  
    je special42_level3
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        jmp box43_level3
     special42_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
      mov box_line4_status3[1],1
      
    box43_level3:
        mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box44_level3
    cmp al, 1                  
    je special43_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        jmp box44_level3
     special43_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line4_status3[2],1

    box44_level3:
        mov dh,cordinatexline
    mov dl,69
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box45_level3
    cmp al, 1                  
    je special44_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        jmp box45_level3

     special44_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    mov box_line4_status3[3],1

    box45_level3:
        mov dh,cordinatexline
    mov dl,76
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box46_level3
    cmp al, 1                  
    je special45_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
        jmp box46_level3
     special45_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
    mov box_line4_status3[4],1

    box46_level3:
        mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level3
    cmp al, 1                  
    je special46_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        mov dh,cordinatexline
    mov dl,101
    call Gotoxy
    jmp l3_level3
    
    special46_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line4_status3[5],1
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level3
    
    
    ;<----------------------------------------------------------------------------line5--------------------------------------->
    ran11_level3:
    
     
    box51_level3:
    mov esi, offset box_line5_status3  
    mov al, [esi]                   
    cmp al, 0                  
    je box52_level3
    cmp al, 1                  
    je special51_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
    jmp box52_level3
    
    special51_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line5_status3[0],1

    box52_level3:
      mov dh,cordinatexline
    mov dl,43
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box53_level3
    cmp al, 1              
    je special52_level3
    mov eax,cyan + (cyan*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        jmp box53_level3
    
    special52_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
 mov box_line5_status3[1],1
        

    box53_level3:
     mov dh,cordinatexline
    mov dl,56
    call Gotoxy
   inc esi  
    mov al, [esi]                   
    cmp al, 0                  
    je box54_level3
    cmp al, 1                  
    je special53_level3
    mov eax,red + (red*16)
    call SetTextColor
    mov edx, offset box1
    call WriteString
        jmp box54_level3
    
    special53_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line5_status3[2],1

    box54_level3:
    mov dh,cordinatexline
    mov dl,63
    call Gotoxy
   inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box55_level3
    cmp al, 1                  
    je special54_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box5
    call WriteString
        jmp box55_level3
    
    special54_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line5_status3[3],1

    box55_level3:
        mov dh,cordinatexline
    mov dl,72
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je box56_level3
    cmp al, 1                 
    je special55_level3
    mov eax,green + (green*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        jmp box56_level3
    
    special55_level3:
    mov eax,white + (white*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line5_status3[4],1


    box56_level3:
    mov dh,cordinatexline
    mov dl,85
    call Gotoxy
    inc esi
    mov al, [esi]                   
    cmp al, 0                  
    je l3_level3
    cmp al, 1                  
    je special56_level3
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
        mov dh,cordinatexline
    mov dl,101
    call Gotoxy
        jmp l3_level3
    
    special56_level3:
    mov eax,blue + (blue*16)
    call SetTextColor
    mov edx, offset box4
    call WriteString
    mov box_line5_status3[5],1
    mov dh,cordinatexline
    mov dl,101
    call Gotoxy

    jmp l3_level3

    en_level3:
    mov eax,cyan+(black*16)
    call SetTextColor
    mov edx, offset topbottomline
    call WriteString
    call crlf
    mov dh,15
    mov dl,0
    call Gotoxy
    mwrite "*** *** *** *** *** ***"
    mov dh,16
    mov dl,0
    call Gotoxy
    mwrite " *****   *****   *****"
    mov dh,17
    mov dl,0
        call Gotoxy
    mwrite "  ***     ***     ***"
    mov dh,18
    mov dl,0    
    call Gotoxy
    mwrite "   *       *       * "
    
    call displayScore3_level3

    GameLoop_level3:

    mov eax,65
    call delay
    call ReadKey
    jz noPaddleMove_level3
    cmp al,'p'
    je pauseGame_level1
    cmp al,'P'
    je pauseGame_level1

    cmp al,'a'
    je moveleft_level3
    cmp al,'A'
    je moveleft_level3
    cmp al,'d'
    je moveRight_level3
    cmp al,'D'
    je moveRight_level3
    jmp redrawPaddle_level3

  pauseGame_level1:
call displayPauseMessage_level1
pauseLoop_level1:
call ReadKey
jz pauseLoop_level1
call clearPauseMessage_level1
jmp GameLoop_level3

moveLeft_level3:
call clearPaddle3_level3
cmp paddlex_start,33
jle updateBallandPaddle_level3
sub paddlex_start,2
jmp updateBallandPaddle_level3

moveRight_level3:
call clearPaddle3_level3
cmp paddlex_start,90
jge updateBallandPaddle_level3
add paddlex_start,2
;jmp redrawOnlyPaddle
jmp updateBallandPaddle_level3
noPaddleMove_level3:
call clearPaddle3_level3


updateBallandPaddle_level3:
call updateBall3_level3
call drawBall3_level3
cmp gameOver,1
je exit1_level1
cmp check,1
je winlvl1_level1
call CheckScoreWinCondition3_level3
call drawPaddle3_level3
jmp GameLoop_level3


checkBall_level3:
call updateBall3_level3
cmp gameOver,1
je exit1_level1


redrawPaddle_level3:
call clearPaddle3_level3
call drawPaddle3_level3
jmp GameLoop_level3

redrawOnlyPaddle3_level3:
call drawPaddle3_level3
jmp GameLoop_level3


ret
prep_level3 endp

updateBall3_level3 proc

call clearBall3_level3
mov al,ballX
mov bl,ballDX
add al,bl

cmp al,34
jle leftBoundary_level3
cmp al,100
jge rightBoundary_level3
jmp checkBricks_level3

leftBoundary_level3:
mov al,34
neg ballDX
jmp checkBricks_level3

rightBoundary_level3:
mov al,100
neg ballDX
jmp checkBricks_level3

checkBricks_level3:
mov ballX,al
mov al,ballY
cmp al,1
jl checkY_level3
cmp al,14
jg checkY_level3

cmp [special_hit],0
jne lines_level3
call special1_level3
cmp [special_hit],1
jne lines_level3
call specialbricks1_level3
cmp brickHit,1
je brickCollision_level3

lines_level3:
call checkLine13_level3
cmp brickHit,1
je brickCollision_level3

call checkLine23_level3
cmp brickHit,1
je brickCollision_level3

call checkLine33_level3
cmp brickHit,1
je brickCollision_level3

call checkLine43_level3
cmp brickHit,1
je brickCollision_level3

call checkLine53_level3
cmp brickHit,1
je brickCollision_level3

jmp checkY_level3

brickCollision_level3:
neg ballDY
mov brickHit,0



checkY_level3:
mov al,ballY
mov bl,ballDY
add al,bl
cmp al,3
jle reverseY_level3

cmp al,26
jge checkPaddleHit_level3
jmp finishUpdate_level3

reverseY_level3:
neg ballDY
mov al,ballY
mov bl,ballDY
add al,bl
jmp finishUpdate_level3

checkPaddleHit_level3:
mov bl,ballX
cmp bl,paddlex_start
jl missedPaddle_level3
mov cl,paddlex_start
add cl,10
cmp bl,cl
jg missedPaddle_level3

sub bl,paddlex_start

cmp bl,5
je middlePaddleHit_level3

cmp bl,3
jl leftPaddlehit_level3

cmp bl,7
jg rightPaddlehit_level3

jmp standardPaddleHit_level3

middlePaddleHit_level3:
mov ballDX,0
neg ballDY
jmp finishUpdate_level3

leftPaddleHit_level3:
mov ballDX,-1
neg ballDY
jmp finishUpdate_level3

rightPaddleHit_level3:
mov ballDX,1
neg ballDY
jmp finishUpdate_level3

standardPaddleHit_level3:
neg ballDY
jmp finishUpdate_level3


;neg ballDY
;mov al,26
;jmp finishUpdate

missedPaddle_level3:
cmp al,28
jge gameOverBall_level3
jmp finishUpdate_level3

display_less_level3:
    mov temp,4
    mov temp1,15
    cmp lives,2
    jne l11_level3
    lo_level3:
    mov dl,16 
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne lo_level3

    l11_level3:
    mov temp,4
    mov temp1,15
    cmp lives,1
    jne reverseY_level3
    l1_level3:
    mov dl,8
    mov dh,temp1          
    call Gotoxy
    mwrite"       "    
    dec temp
    inc temp1
    cmp temp,0
    jne l1_level3
    jmp reverseY_level3

gameOverBall_level3:
dec lives
cmp lives,0
jne display_less_level3
mov gameOver,1

finishUpdate_level3:
mov ballY,al
ret

updateBall3_level3 endp

specialbricks1_level3 proc
mov al,5
cmp [total_bricks],al
jle win_level3
jmp l11_level3
special_update1_level3:
    call clearBrickLine13_level3
    inc brickbroken
    jmp nextBrick1_level3
special_update2_level3:
    call clearBrickLine23_level3
    inc brickbroken
    jmp nextBrick2_level3
special_update3_level3:
    call clearBrickLine33_level3
    inc brickbroken
    jmp nextBrick3_level3
special_update4_level3:
    call clearBrickLine43_level3
    inc brickbroken
    jmp nextBrick4_level3
special_update5_level3:
    call clearBrickLine53_level3
    inc brickbroken
    jmp nextBrick5_level3
l11_level3:
    mov currentBrickIndex,0
    mov ecx,6
    jmp specialBrick1_level3


win_level3:
call Winlvl1_level1

specialBrick1_level3:
cmp [line],1
je l1_level3
cmp [line],2
je l2_level3
cmp [line],3
je l3_level3
cmp [line],4
je l4_level3
cmp [line],5
je l5_level3

l1_level3:
movzx esi,currentBrickIndex
mov al,box_line1_status3[esi]
cmp al,0
je nextBrick1_level3
cmp al,3
jg nextBrick1_level3
mov box_line1_status3[esi],0
mov brickHit,1
jmp special_update1_level3

l2_level3:
movzx esi,currentBrickIndex
mov al,box_line2_status3[esi]
cmp al,0
je nextBrick2_level3
cmp al,3
jg nextBrick2_level3
mov box_line2_status3[esi],0
mov brickHit,1
jmp special_update2_level3

l3_level3:
movzx esi,currentBrickIndex
mov al,box_line3_status3[esi]
cmp al,0
je nextBrick3_level3
cmp al,3
jg nextBrick3_level3
mov box_line3_status3[esi],0
mov brickHit,1
jmp special_update3_level3

l4_level3:
movzx esi,currentBrickIndex
mov al,box_line4_status3[esi]
cmp al,0
je nextBrick4_level3
cmp al,3
jg nextBrick4_level3
mov box_line4_status3[esi],0
mov brickHit,1
jmp special_update4_level3

l5_level3:
movzx esi,currentBrickIndex
mov al,box_line5_status3[esi]
cmp al,0
je nextBrick5_level3
cmp al,3
jg nextBrick5_level3
mov box_line5_status3[esi],0
mov brickHit,1
jmp special_update5_level3

nextBrick1_level3:
cmp [brickbroken],5
je exitspecial1_level3
dec ecx
inc currentBrickIndex
cmp ecx,0
je goingl2_level3
jmp specialBrick1_level3

nextBrick2_level3:
cmp [brickbroken],5
je exitspecial1_level3
dec ecx
inc currentBrickIndex
cmp ecx,0
je goingl2_level3
jmp specialBrick1_level3

nextBrick3_level3:
cmp [brickbroken],5
je exitspecial1_level3
pop ecx
dec ecx
inc currentBrickIndex
cmp ecx,0
je goingl2_level3
jmp specialBrick1_level3

nextBrick4_level3:
cmp [brickbroken],5
je exitspecial1_level3
dec ecx
inc currentBrickIndex
cmp ecx,0
je goingl2_level3
jmp specialBrick1_level3

nextBrick5_level3:
cmp [brickbroken],5
je exitspecial1_level3
dec ecx
inc currentBrickIndex
cmp ecx,0
je exitspecial1_level3
jmp specialBrick1_level3

goingl2_level3:
    inc line
    mov currentBrickIndex,0
    mov ecx,6
    jmp specialBrick1_level3


exitspecial1_level3:
ret
specialbricks1_level3 endp


special1_level3 proc
cmp [ballDY],1
je special_above_level3
jmp special_down_level3
special_update1_level3:
    mov [special_hit],1
    call updateScorespecial_level3
    call clearBrickspecial1_level3
    jmp nextBrick1_level3
special_down_level3:
mov brickHit,0
mov al,[special_line]
inc al
cmp al,[ballY]
jne exitspecial1_level3
mov currentBrickIndex,0
mov ecx,6
jmp specialBrick1_level3

special_above_level3:
mov brickHit,0
mov al,[special_line]
cmp al,[ballY]
jne exitspecial1_level3
mov currentBrickIndex,0
mov ecx,6

specialBrick1_level3:

push ecx
movzx esi,currentBrickIndex
mov al,special_status
cmp al,0
je nextBrick1_level3
mov al,ballX
cmp al,special_x_start[esi]
jl nextBrick1_level3
cmp al,special_x_end[esi]
jg nextBrick1_level3

dec special_status[esi]
mov brickHit,1
mov cl,special_status[esi]
cmp cl,0
je special_update1_level3

nextBrick1_level3:
pop ecx
cmp [special_hit],1
je exitspecial1_level3
inc currentBrickIndex
loop specialBrick1_level3

exitspecial1_level3:
ret
special1_level3 endp


clearBrickspecial1_level3 proc
mov num,6
movzx esi,num
movzx edx,special_line
shl edx,8
movzx eax,special_x_start
or edx,eax
call Gotoxy

mov al,box_line5_status3[esi]
cmp al,0
je clearspecial_level3

clearspecial_level3:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,[special_x_start]
movzx eax,[special_x_end]
mov temp,ebx
mov temp,ebx
dec temp
l9_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l9_level3
sub eax,ebx
inc eax
mov [special_x_start],0
mov [special_x_end],0
mov box_line5_x_start[esi],0
mov box_line5_x_end[esi],0
ret
clearBrickspecial1_level3 endp


checkLine13_level3 proc
cmp [ballDY],1
je first_above_level3
jmp first_down_level3
going_update1_level3:
    call updateScore3_level3
    call clearBrickLine13_level3
    jmp nextBrick1_level3
first_down_level3:
mov brickHit,0
mov al,[box_line1_y]
inc al
cmp al,[ballY]
jne exitCheck1_level3
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick1_level3

first_above_level3:
mov brickHit,0
mov al,[ballY]
dec al
cmp al,[box_line1_y]
jne exitCheck1_level3
mov currentBrickIndex,0
mov ecx,6

checkBrick1_level3:
push ecx
movzx esi,currentBrickIndex
mov al,box_line1_status3[esi]
cmp al,0
je nextBrick1_level3
mov al,ballX
inc al
cmp al,box_line1_x_start[esi]
jl nextBrick1_level3
mov al,ballX
cmp al,box_line1_x_end[esi]
jg nextBrick1_level3

dec box_line1_status3[esi]
mov brickHit,1
mov cl,box_line1_status3[esi]
cmp cl,0
je going_update1_level3
cmp cl,1
je going_update1_level3
cmp cl,2
je going_update1_level3

nextBrick1_level3:
pop ecx
inc currentBrickIndex
loop checkBrick1_level3

exitCheck1_level3:
ret
checkLine13_level3 endp

checkLine23_level3 proc
cmp [ballDY],1
je second_above_level3
jmp second_down_level3
going_update2_level3:
    call updateScore3_level3
    call clearBrickLine23_level3
    jmp nextBrick2_level3
second_down_level3:
mov brickHit,0
mov al,[box_line2_y]
inc al
cmp al,[ballY]
jne exitCheck2_level3
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick2_level3

second_above_level3:
mov brickHit,0
mov al,[ballY]
inc al
cmp al,[box_line2_y]
jne exitCheck2_level3
mov currentBrickIndex,0
mov ecx,6

checkBrick2_level3:
push ecx
movzx esi,currentBrickIndex
mov al,box_line2_status3[esi]
cmp al,0
je nextBrick2_level3

mov al,ballX
inc al
cmp al,box_line2_x_start[esi]
jl nextBrick2_level3
mov al,ballX
cmp al,box_line2_x_end[esi]
jg nextBrick2_level3

dec box_line2_status3[esi]
mov brickHit,1
mov cl,box_line2_status3[esi]
cmp cl,0
je going_update2_level3
cmp cl,1
je going_update2_level3
cmp cl,2
je going_update2_level3

nextBrick2_level3:
pop ecx
inc currentBrickIndex
loop checkBrick2_level3

exitCheck2_level3:
ret
checkLine23_level3 endp

checkLine33_level3 proc
cmp [ballDY],1
je third_above_level3
jmp third_down_level3
going_update3_level3:
    call updateScore3_level3
    call clearBrickLine33_level3
    jmp nextBrick3_level3
third_down_level3:
mov brickHit,0
mov al,[box_line3_y]
inc al
cmp al,[ballY]
jne exitCheck3_level3
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick3_level3

third_above_level3:
mov brickHit,0
mov al,[ballY]
cmp al,[box_line3_y]
jne exitCheck3_level3
mov currentBrickIndex,0
mov ecx,6

checkBrick3_level3:
push ecx
movzx esi,currentBrickIndex
mov al,box_line3_status3[esi]
cmp al,0
je nextBrick3_level3

mov al,ballX
inc al
cmp al,box_line3_x_start[esi]
jl nextBrick3_level3
mov al,ballX
cmp al,box_line3_x_end[esi]
jg nextBrick3_level3

dec box_line3_status3[esi]
mov brickHit,1
mov cl,box_line3_status3[esi]
cmp cl,0
je going_update3_level3
cmp cl,1
je going_update3_level3
cmp cl,2
je going_update3_level3

nextBrick3_level3:
pop ecx
inc currentBrickIndex
loop checkBrick3_level3

exitCheck3_level3:
ret
checkLine33_level3 endp

checkLine43_level3 proc
cmp [ballDY],1
je fourth_above_level3
jmp fourth_down_level3
going_update4_level3:
    call updateScore3_level3
    call clearBrickLine43_level3
    jmp nextBrick4_level3
fourth_down_level3:
mov brickHit,0
mov al,[box_line4_y]
inc al
cmp al,[ballY]
jne exitCheck4_level3
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick4_level3

fourth_above_level3:
mov brickHit,0
mov al,[box_line4_y]
cmp al,[ballY]
jne exitCheck4_level3
mov currentBrickIndex,0
mov ecx,6

checkBrick4_level3:
push ecx
movzx esi,currentBrickIndex
mov al,box_line4_status3[esi]
cmp al,0
je nextBrick4_level3

mov al,ballX
inc al
cmp al,box_line4_x_start[esi]
jl nextBrick4_level3
mov al,ballX
cmp al,box_line4_x_end[esi]
jg nextBrick4_level3

dec box_line4_status3[esi]
mov brickHit,1
mov cl,box_line4_status3[esi]
cmp cl,0
je going_update4_level3
cmp cl,1
je going_update4_level3
cmp cl,2
je going_update4_level3


nextBrick4_level3:
pop ecx
inc currentBrickIndex
loop checkBrick4_level3

exitCheck4_level3:
ret
checkLine43_level3 endp

checkLine53_level3 proc
mov [box_line5_y],13
cmp [ballDY],1
je fifth_above_level3
jmp fifth_down_level3
going_update5_level3:
    call updateScore3_level3
    call clearBrickLine53_level3
    jmp nextBrick5_level3

fifth_down_level3:
mov brickHit,0
mov al,[box_line5_y]
inc al
cmp al,[ballY]
jne exitCheck5_level3
mov currentBrickIndex,0
mov ecx,6
jmp checkBrick5_level3

fifth_above_level3:
mov brickHit,0
mov al,[box_line5_y]
dec al
cmp al,[ballY]
jne exitCheck5_level3
mov currentBrickIndex,0
mov ecx,6

checkBrick5_level3:
push ecx
movzx esi,currentBrickIndex
mov al,box_line5_status3[esi]
cmp al,0
je nextBrick5_level3


mov al,ballX
inc al
cmp al,box_line5_x_start[esi]
jl nextBrick5_level3
mov al,ballX
cmp al,box_line5_x_end[esi]
jg nextBrick5_level3

dec box_line5_status3[esi]
mov brickHit,1
mov cl,box_line5_status3[esi]
cmp cl,0
je going_update5_level3
cmp cl,1
je going_update5_level3
cmp cl,2
je going_update5_level3


nextBrick5_level3:
pop ecx
inc currentBrickIndex
loop checkBrick5_level3

exitCheck5_level3:
ret
checkLine53_level3 endp

clearBrickLine13_level3 proc

movzx esi,currentBrickIndex
movzx edx,box_line1_y
shl edx,8
movzx eax,box_line1_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line1_status3[esi]
cmp al,2
je changeColor12_level3
cmp al,1
je changeColor11_level3
cmp al,0
je clearBrick1_level3

changeColor11_level3:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
dec temp
l14_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l14_level3
ret
changeColor12_level3:
mov eax,lightred+(lightred*16)
call settextcolor
movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
dec temp
l144_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l144_level3
ret

clearBrick1_level3:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line1_x_start[esi]
movzx eax,box_line1_x_end[esi]
mov temp,ebx
mov temp,ebx
dec temp
l9_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l9_level3
sub eax,ebx
inc eax
mov box_line1_x_end[esi],0
mov box_line1_x_start[esi],0
mov box_line1_x_end[esi],0
ret
clearBrickLine13_level3 endp

clearBrickLine23_level3 proc
movzx esi,currentBrickIndex
movzx edx,box_line2_y
shl edx,8
movzx eax,box_line2_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line2_status3[esi]
cmp al,2
je changeColor22_level3
cmp al,1
je changeColor21_level3
cmp al,0
je clearBrick2_level3

changeColor21_level3:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l15_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l15_level3
ret
changeColor22_level3:
mov eax,lightred+(lightred*16)
call settextcolor
movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l155_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l155_level3
ret

clearBrick2_level3:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line2_x_start[esi]
movzx eax,box_line2_x_end[esi]
mov temp,ebx
dec temp
l10_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l10_level3
sub eax,ebx
inc eax
ret
clearBrickLine23_level3 endp

clearBrickLine33_level3 proc

movzx esi,currentBrickIndex
movzx edx,box_line3_y
shl edx,8
movzx eax,box_line3_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line3_status3[esi]
cmp al,2
je changeColor32_level3
cmp al,1
je changeColor31_level3
cmp al,0
je clearBrick3_level3

changeColor32_level3:
mov eax,lightred+(lightred*16)
call settextcolor
movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l16_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l16_level3
ret

changeColor31_level3:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l166_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l166_level3
ret

clearBrick3_level3:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line3_x_start[esi]
movzx eax,box_line3_x_end[esi]
mov temp,ebx
dec temp
l11_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l11_level3
sub eax,ebx
inc eax
ret
clearBrickLine33_level3 endp

clearBrickLine43_level3 proc
movzx esi,currentBrickIndex
movzx edx,box_line4_y
shl edx,8
movzx eax,box_line4_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line4_status3[esi]
cmp al,2
je changeColor42_level3
cmp al,1
je changeColor41_level3
cmp al,0
je clearBrick4_level3

changeColor41_level3:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line4_x_start[esi]
movzx eax,box_line4_x_end[esi]
mov temp,ebx
dec temp
l17_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l17_level3
ret
changeColor42_level3:
mov eax,lightred+(lightred*16)
call settextcolor
movzx ebx,box_line4_x_start[esi]
movzx eax,box_line4_x_end[esi]
mov temp,ebx
dec temp
l177_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l177_level3
ret

clearBrick4_level3:

mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line4_x_start[esi]
movzx eax,box_line4_x_end[esi]
mov temp,ebx
dec temp
l12_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l12_level3
sub eax,ebx
inc eax
ret
clearBrickLine43_level3 endp

clearBrickLine53_level3 proc
movzx esi,currentBrickIndex
movzx edx,box_line5_y
shl edx,8
movzx eax,box_line5_x_start[esi]
or edx,eax
call Gotoxy

mov al,box_line5_status3[esi]
cmp al,2
je changeColor52_level3
cmp al,1
je changeColor51_level3
cmp al,0
je clearBrick5_level3

changeColor51_level3:
mov eax,yellow+(yellow*16)
call settextcolor
movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l18_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l18_level3
ret
changeColor52_level3:
mov eax,lightred+(lightred*16)
call settextcolor
movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l188_level3:
mov edx,offset emptyChar
call WriteString
inc temp
cmp eax,temp
jne l188_level3
ret

clearBrick5_level3:
mov eax,black+(black*16)
call setTextcolor

movzx ebx,box_line5_x_start[esi]
movzx eax,box_line5_x_end[esi]
mov temp,ebx
dec temp
l13_level3:
mov edx,offset emptyChar
call writestring
inc temp
cmp eax,temp
jne l13_level3
sub eax,ebx
inc eax
ret
clearBrickLine53_level3 endp

clearBall3_level3 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,black+(black*16)
call settextcolor

mov edx,offset emptychar
call writestring
ret
clearBall3_level3 endp

drawBall3_level3 proc
movzx edx,ballY
shl edx,8
movzx eax,ballX
or edx,eax
call Gotoxy

mov eax,white+(black*16)
call settextcolor

mov edx,offset ballchar
call writestring
ret
drawBall3_level3 endp


GetInput3 proc
mov edx,offset input_buffer
call ReadChar
mov al,[input_buffer]
ret
GetInput3 endp

clearPaddle3_level3 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,black+(black*16)
call settextcolor
mov edx,offset paddle3
call writestring
ret
clearPaddle3_level3 endp

drawPaddle3_level3 proc
movzx edx,paddley
shl edx,8
movzx eax,paddlex_start
or edx,eax
call Gotoxy
mov eax,white+(white*16)
call settextcolor
mov edx,offset paddle3
call writestring
ret
drawPaddle3_level3 endp

updateScorespecial_level3 proc
mov ebx,45
add score, ebx
call displayScore3_level3

scoreExit_level3:
ret
updateScorespecial_level3 endp


updateScore3_level3 proc
mov ebx,3;reseting score inc

mov al,ballY
    cmp al,[box_line1_y]
    jne checkLine223_level3
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore1_level3
    cmp esi,5
    je redScore1_level3
    cmp esi,1
    je blueScore1_level3
    cmp esi,4
    je blueScore1_level3
    jmp applyScore_level3

redScore1_level3:
    mov ebx, 5
    jmp applyScore_level3

blueScore1_level3:
    mov ebx, 6
    jmp applyScore_level3

    ; Line 2 (ballY == box_line2_y)
checkLine223_level3:
    mov al,ballY
    cmp al,[box_line2_y]
    jne checkLine333_level3
    
    movzx esi,currentBrickIndex
    cmp esi,1
    je redScore2_level3
    cmp esi,2
    je redScore2_level3
    cmp esi,5
    je redScore2_level3
    cmp esi,0
    je blueScore2_level3
    jmp applyScore_level3

redScore2_level3:
    mov ebx, 5
    jmp applyScore_level3

blueScore2_level3:
    mov ebx, 6
    jmp applyScore_level3

    ; Line 3 (ballY == box_line3_y)
checkLine333_level3:
    mov al,ballY
    cmp al,[box_line3_y]
    jne checkLine44_level3
    
    movzx esi,currentBrickIndex
    cmp esi,0
    je redScore3_level3
    cmp esi,3
    je redScore3_level3
    cmp esi,4
    je blueScore3_level3
    cmp esi,5
    je blueScore3_level3
    jmp applyScore_level3

redScore3_level3:
    mov ebx, 5
    jmp applyScore_level3

blueScore3_level3:
    mov ebx, 6
    jmp applyScore_level3
checkLine44_level3:
    mov al,ballY
    cmp al,[box_line4_y]
    jne checkLine55_level3
    
    movzx esi,currentBrickIndex
    cmp esi,4
    je redScore4_level3
    cmp esi,5
    je redScore4_level3
    cmp esi,2
    je blueScore4_level3
    jmp applyScore_level3

redScore4_level3:
    mov ebx, 5
    jmp applyScore_level3

blueScore4_level3:
    mov ebx, 6
    jmp applyScore_level3

    ; Line 5 (ballY == box_line5_y)
checkLine55_level3:
    mov al,ballY
    cmp al,[box_line5_y]
    jne applyScore_level3
    movzx esi,currentBrickIndex
    cmp esi,2
    je redScore5_level3
    jmp applyScore_level3

redScore5_level3:
    mov ebx, 5

applyScore_level3:
    add score, ebx
    call displayScore3_level3

scoreExit_level3:
ret
updateScore3_level3 endp

displayScore3_level3 proc
mov dh,9
mov dl,3
call gotoxy
mov eax,white+(black*16)
call setTextcolor
mov edx,offset scoreLabel
call writestring
mov eax,score
call WriteDec
ret
displayScore3_level3 endp



CheckScoreWinCondition3_level3 PROC
    mov eax, score
    cmp ax, MAX_SCORE3
    jae PlayerWins_level3
    ret

PlayerWins_level3:
    ;mov gameOver, 1
    call winlvl1_level1
    ret
CheckScoreWinCondition3_level3 ENDP

instructions_page proc
       mov eax,WhiteOnBlue
        call SetTextColor
	mov eax,white+(blue*16)
	call settextcolor
	    call clrscr
        mov cl,0
        mov dl,24
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset inst1
        call WriteString
        call crlf
        mov eax,200
        call delay
        mov dl,24
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset inst2
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,24
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset inst3
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,24
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset inst4
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,24
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset inst5
        call Writestring
        call crlf



        mov eax,WhiteOnBlue
        call settextcolor
        mov cl,5
        inc cl
        mov dl,38
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset instr_title
        call WriteString
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset line
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,18
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset intro
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,22
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset objective
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset howToPlay
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset rule1
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset control
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset leftControl
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset rightControl
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset rule2
        call Writestring
        call crlf
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset rule3
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset features
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset feature1
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset feature2
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset feature3
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset controlsSummary
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,37
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset leftSummary
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,37
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset rightSummary
        call Writestring
        call crlf
        mov dl,37
        mov dh,cl
        mov eax,200
        call delay
        mov dl,37
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset pauseControl
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset quitControl
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,36
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset outro
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        mov eax,200
        call delay
        mov dl,30
        mov dh,cl
        inc cl
        call Gotoxy
        mov edx,offset endLine
        call Writestring
        call crlf
        mov dl,30
        mov dh,cl
        call waitmsg
        call display_menu

ret
instructions_page ENDP
level_1 proc
	mov temp9,5
	mov dh,temp9
	mov dl,30
	inc temp9
	call gotoxy
	mov eax,RedOnBlack
	call settextcolor
	mov esi,offset level1
	mov ecx,lengthof level1
	mov ebx,0
	L1:

		cmp ebx,45
		jne exitlvl1
			mov eax,100
			call delay
			call crlf
			mov ebx,0
			mov dh,temp9
	        mov dl,30
 	        inc temp9
	        call gotoxy
		exitlvl1:
		
		mov eax,0
		mov al,[esi]
		call writechar
		inc esi
		inc ebx

		loop L1
ret
level_1 ENDP

no_1 proc
	mov temp9,12
	mov dh,temp9
	mov dl,50
	inc temp9
	call gotoxy
	mov eax,YellowOnBlack
	call settextcolor
	mov esi,offset no1
	mov ecx,lengthof no1
	mov ebx,0
	L1:
		cmp ebx,6
		jne exitno1
			mov eax,100
			call delay
			call crlf
			mov ebx,0
			mov dh,temp9
	        mov dl,50
 	        inc temp9
	        call gotoxy
		exitno1:
		
		mov eax,0
		mov al,[esi]
		call writechar
		inc esi
		inc ebx

		loop L1
ret
no_1 ENDP

no_2 proc
	mov temp9,12
	mov dh,temp9
	mov dl,50
	inc temp9
	call gotoxy
	mov eax,BlueOnBlack
	call settextcolor
	mov esi,offset no2
	mov ecx,lengthof no2
	mov ebx,0
	L1:
		cmp ebx,9
		jne exitno2
			mov eax,100
			call delay
			call crlf
			mov ebx,0
			mov dh,temp9
	        mov dl,50
 	        inc temp9
	        call gotoxy
		exitno2:
		
		mov eax,0
		mov al,[esi]
		call writechar
		inc esi
		inc ebx

		loop L1
ret
no_2 ENDP

no_3 proc
	mov temp9,12
	mov dh,temp9
	mov dl,50
	inc temp9
	call gotoxy
	mov eax,GreenOnBlack
	call settextcolor
	mov esi,offset no3
	mov ecx,lengthof no3
	mov ebx,0
	L1:
		cmp ebx,9
		jne exitno3
			mov eax,100
			call delay
			call crlf
			mov ebx,0
			mov dh,temp9
	        mov dl,50
 	        inc temp9
	        call gotoxy
		exitno3:
		
		mov eax,0
		mov al,[esi]
		call writechar
		inc esi
		inc ebx

		loop L1
ret
no_3 ENDP

lost_game proc
	mov esi,offset lost
	mov ecx,lengthof lost
	mov ebx,0
	mov eax,RedOnBlack
	call settextcolor
	call clrscr
	mov temp1,7
	mov dh,temp1
	mov dl,35
	inc temp1
	call gotoxy
	L1:
		cmp ebx,44
		jne skip1
		mov dh,temp1
	    mov dl,35
	    inc temp1
	    call gotoxy
		mov ebx,0
		skip1:
		mov eax,0
		mov al,[esi]
		call writechar
		inc ebx
		inc esi
		loop L1
		mov dh,15
		mov dl,45
		call gotoxy
		mov eax,YellowOnBlack
		call settextcolor
		mWrite"YOUR SCORE WAS : "
		mov eax,BlueOnBlack
		call settextcolor
		mov dh,15
		mov dl,65
		call gotoxy
		mov eax,score
		call writedec
		mov ecx,10
		N1:
		call crlf
		loop N1
ret
lost_game ENDP

won_game proc
	mov esi,offset won
	mov ecx,lengthof won
	mov ebx,0
	mov eax,RedOnBlack
	call settextcolor
	call clrscr
	mov temp1,7
	mov dh,temp1
	mov dl,35
	inc temp1
	call gotoxy
	L1:
		cmp ebx,46
		jne skip1
		mov dh,temp1
	    mov dl,35
	    inc temp1
	    call gotoxy
		mov ebx,0
		skip1:
		mov eax,0
		mov al,[esi]
		call writechar
		inc ebx
		inc esi
		loop L1
		mov dh,15
		mov dl,45
		call gotoxy
		mov eax,YellowOnBlack
		call settextcolor
		mWrite"YOUR SCORE WAS : "
		mov eax,BlueOnBlack
		call settextcolor
		mov dh,15
		mov dl,65
		call gotoxy
		mov eax,score
		call writedec
		mov ecx,10
		N1:
		call crlf
		loop N1
ret
won_game ENDP

END main
comment @
NA1 db 'Player1',0
NA2 db 'Player2',0
NA3 db 'Player3',0
NA4 db 'Player4',0
NA5 db 'Player5',0


scores db 0,0,0,0,0,0,0,0,0,0
namesFile db "output.txt",0    ; File for player names
scoresFile db "FileName.txt",0  ; File for scores
; Modified sorting procedure with optimized jumps
SortLeaderboard PROC
    pushad              ; Save all registers

    mov ecx, 4          ; outer loop counter (n-1 iterations)
    
outer_start:
    mov esi, 0         ; index for inner loop

compare_loop:
    ; Compare adjacent scores
    movzx eax, byte ptr [scores + esi]        ; current score
    movzx ebx, byte ptr [scores + esi + 1]    ; next score
    
    ; If current score is less than next score, swap them
    cmp eax, ebx
    jge no_swap        ; if current >= next, don't swap
    
    ; Swap scores
    mov dl, [scores + esi]
    mov dh, [scores + esi + 1]
    mov [scores + esi], dh
    mov [scores + esi + 1], dl
    
    ; Now swap the corresponding names
    push esi
    
    ; Determine which names to swap
    cmp esi, 0
    jne check_second
    mov edi, OFFSET NA1
    mov edx, OFFSET NA2
    jmp swap_names

check_second:
    cmp esi, 1
    jne check_third
    mov edi, OFFSET NA2
    mov edx, OFFSET NA3
    jmp swap_names

check_third:
    cmp esi, 2
    jne check_fourth
    mov edi, OFFSET NA3
    mov edx, OFFSET NA4
    jmp swap_names

check_fourth:
    mov edi, OFFSET NA4
    mov edx, OFFSET NA5

swap_names:
    ; Swap the names
    push ecx
    xor ecx, ecx        ; Initialize counter for name swapping
    
swap_char:
    mov al, [edi + ecx]
    mov bl, [edx + ecx]
    mov [edi + ecx], bl
    mov [edx + ecx], al
    inc ecx
    cmp ecx, 8          ; Compare with name length
    jl swap_char
    
    pop ecx
    pop esi

no_swap:
    inc esi
    cmp esi, ecx        ; compare with outer loop counter
    jl compare_loop     ; if not done, continue inner loop
    
    dec ecx             ; decrease outer loop counter
    jnz outer_start     ; if not zero, continue outer loop

sort_done:
    popad               ; Restore all registers
    ret
SortLeaderboard ENDP
@