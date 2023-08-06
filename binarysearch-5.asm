
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here

.data
    
    arr dw 0000h,1111h,2222h,3333h,4444h,5555h,6666h,7777h,8888h,9999h
    ;arr dw 20h,11h,22h,33h,44h,5h,66h,7h,8h,99h
    len dw ($-arr)/2;middel arr
    key dw 2222h ; and not found is not 2222h some 1234h
    msg1 db "key is found at "
    res db "  position ",10,13,"$"
    msg2 db 'key is not found!!!.$'
.code
    
start:
    
    mov ax,@data
    mov ds,ax
    mov bx,00
    mov dx,len
    mov cx,key
again:
    
    cmp bx,dx
    ja fail
    mov ax,bx
    add ax,dx
    shr ax,1 ;shift to right by 1
    mov si,ax
    add si,si 
    cmp cx,arr[si]
    jae big
    dec ax
    mov dx,ax
    jmp again
     
big:
    
    je success
    inc ax
    mov bx,ax
    jmp again    
    
success:
    
    add al,01
    add al,30h
    lea si,res
    mov [si], al
    lea dx,msg1
    jmp disp        
        
            
fail:
    
    lea dx,msg2
    
disp:
    mov ah,09h
    int 21h
    mov ah,4ch
    int 21h
    end                   

ret




