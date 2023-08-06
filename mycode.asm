
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
    
    count equ 5
    cr equ 10
    lf equ 13
.data
    number db 5 dup(?)
    message db 'enter the char:$'
    inputc db 'enter the key:$'
.code
     main proc far
        mov ax,@data
        mov ds,ax
        mov si,offset number ;si=number[0]
        mov cx,count
input:
        mov ah,09
        mov dx,offset message
        int 21h
        mov ah,01
        int 21h
        mov [si],al
        mov ah,02
        mov dl,cr
        int 21h
        mov dl,lf
        int 21h
        inc si
        loop input  
        
        ;begin sort label
BeginSort:

        mov bl,0
        mov dx,0
        mov si,offset number ;home array
        mov di,offset number ;home array
        inc di ;array+1 if si[o] and di[0+1]
        mov cx,count
        dec cx;becuse 5 loop is 4 and 5-1
Process:

        mov dl,[si] ;dl = first home
        cmp dl,[di] ;cmp [i] and [i+1] if i>i+1 is swap else dontswap  
        ja swap
        jmp dontswap
swap:
        mov dh,[di];swap
        mov [di],dl;swap
        mov [si],dh;swap
        mov bl,1; bl is flag and bl=1 the swap
dontswap:
        inc si
        inc di         
        loop process
        
        cmp bl,1 ;bl=1 and enter beginsort
        je BeginSort
        jmp search                  
search:
        mov ax,0  ; ax=0 becuse middel item in ax
        mov ah,09 ;print 
        mov dx,offset inputc
        int 21h             
        
        mov ah,1 ;ah is enter user
        int 21h ; give puse key the user
        
        mov  bh,al ; search key in bh
        
        mov bl,2 ; /2 and find middel item
        mov dl,0 ; start index array                        
        mov dh,4 ; end index array
        
start:
        mov ax,0 
        mov si,offset number ;si = first element array 
        cmp dl,dh  ; the dl<dh and continue else endofsearch
        jle continue
        jmp endofsearch
continue:
        mov al,dl ; start element in al
        add al,dh ; add first and end element and in al = 0+4
        div bl ;4/2 = 2
        mov ah,0 ;baghimande in ah and not important and ah = 0
        add si,ax  ; si += ax is first+middel 
        cmp bh,[si] ;element key == middel element in found else if element key < middel element in down part else if > in toppart
        je found
        jl downpart
        ja toppart
found:
        mov ah,02 ; function-2 the puse21 print index
        add al,30h ; start asccii numbers in 48 and 48 is 30h and becuse start array is 1 and 30+1 
        mov dl,al ; al is middel element
        int 21h
        jmp finish  ; end of program      
downpart:
        mov dh, al ; dh = al is middel element 
        dec dh  ; dh-- and search dl to mid-1
        jmp start
toppart:
        mov dl,al ; dl = al
        inc dl  ; dl++  and search in dh to mid+1
        jmp start
endofsearch:      ; is not key search in array
        mov ah,02
        mov dl, 'N'  ; not find element
        int 21h                        
finish:
        main endp
 
 end main        
;ret




