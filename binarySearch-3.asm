
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here

.data
    
    array db 2,3,1,5,7,8,11,16,17,20
    index db 10
    
    
.code
   main proc far
    mov ax,@data
    mov ds,ax 
    lea si,array ;si = array
    mov al,[si]  ; al = array[0]
L1: 

    cmp bl,[si+1]
        
  

ret




