assume cs:code,ds:data
data segment
        a db 10h,20h,30h,40h,50h ; element positions 0 1 2 3 4
        n db n-a    ; n = 5
        key db 60h  ; search element
        msg1 db "Search unsuccessful$"
        msg2 db "Key found at position "
        pos db ?, "$"                    
data ends

code segment
start:
        mov ax,data
        mov ds,ax

        mov al,0              ; low = 0
        mov dl,n              ; high = n
        dec dl                ; decrement dl to n-1
again:
        cmp al,dl             ; compare low(al) and high(dl)
        ja failed             ; if low>high jump above
        mov cl,al             ; else mov al(low) to cl as al will keep changing
        add al,dl             ; add low and high
        shr al,1              ; divide by 2
        mov ah,00h            ; making all high reg 00 in order to use ax
        mov si,ax              
        mov bl,[si]           ; si points to bl
        cmp bl,key            
        jae loc1              ; jump above or equal to i.e a[mid]>=key
        inc al                ; if above condition has failed
        jmp again             ; continue
 loc1:
        je success            ; jump equal to
        dec al                ; if a[mid]<key
        mov dl,al             ; move new high to dl
        mov al,cl
        jmp again
 failed:
        lea dx,msg1
        jmp display                                               
 success:
        inc al                ; since array is from 0 to n-1
        add al,30h            ; ascii value
        mov pos,al
        lea dx,msg2
 display:
        mov ah,09h
        int 21h


        mov ah,4ch
        int 21h
        code ends
        end start
