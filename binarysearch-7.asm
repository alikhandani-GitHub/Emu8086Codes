
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here 

.data
    
    ;arr dw 0000h,1111h,2222h,3333h,4444h,5555h,6666h,7777h,8888h,9999h And use line 60 in 31h
    
    arr dw 0,1,2,3,4,5,6,7,8,9 ;create array
    ;arr dw 0,1,20,34,42,57,62,74,88,90  ;create array            
    len dw 10 ; dw is 16 bit and dx is 16 bit
    ;($-arr)/2 ;is len array and use it ;middel arr
    key dw 4 ;and not found is not 2h some 14h
    msg1 db "key is found at "
    res db "  position in array ",10,13,"$"
    msg2 db 'key is not found!!!.$' 
    
.code
    
    mov ax,@data
    mov ds,ax
    mov bx,0
    mov dx,len
    mov cx,key  
    
again:
    
    cmp bx,dx
    ja fail
    mov ax,bx
    add ax,dx ; ax = 10(len)
    shr ax,1 ;shift to right by 1
    mov si,ax
    add si,si 
    cmp cx,arr[si]
    jnb big ; jae big is some jea and means cx >= arr[si]
    dec ax
    mov dx,ax
    jmp again
     
big:
    
    je success    ; equal
    inc ax
    mov bx,ax
    jmp again    
    
success:
    
    add al,01
    add al,'0';becuse a good print if not use a '0' and bad print
    lea si,res
    mov [si], al
    lea dx,msg1
    jmp disp         
            
fail:
    
    lea dx,msg2
    
disp: 
    
    ; print 
    mov ax,0900h ; and can use mov ah,09h
    int 21h  
    ; end
    mov ax,4c00h ; and can use mov ah,4ch
    int 21h
    end main            