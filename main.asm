.model small
.stack 100h
.data
    msg1 db 10,13,'Birinci sayi: $'
    msg2 db 10,13,'Ikinci sayi: $'
    msg3 db 10,13,'Islem (+,-,*,/): $'
    msg4 db 10,13,'Sonuc: $'
    sayi1 db ?
    sayi2 db ?

.code
main proc
    mov ax, @data                      ; Verileri hafızaya tanıtıyoruz
    mov ds, ax

    mov ah, 09h
    lea dx, msg1
    int 21h
    mov ah, 01h                        ; Klavyeden ilk tusu bekliyoz
    int 21h
    sub al, 30h                        ; Sayıyı ASCII'den kurtarıp gercek sayı yapıyoz
    mov sayi1, al

    mov ah, 09h
    lea dx, msg2
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h                        ; Gene sayı kurtarma
    mov sayi2, al

    mov ah, 09h
    lea dx, msg3
    int 21h
    mov ah, 01h
    int 21h
    mov bl, al                         ; yapcagimiz islemi bl'ye kitliyoruz

    mov ah, 09h
    lea dx, msg4
    int 21h

    cmp bl, '+'                        ; eğer kullanici + bastiysa
    je toplama                         ; toplamaya zıpla
    cmp bl, '-'
    je cikarma
    cmp bl, '*'
    je carpma
    cmp bl, '/'
    je bolme
    jmp cikis                          ; Yanlış tuş falan bastıysa exit

toplama:
    mov al, sayi1
    add al, sayi2                      ; İki sayıyı birbiriyle topluyoruz
    jmp yazdir

cikarma:
    mov al, sayi1
    sub al, sayi2                      ; Birinden diğerini eksiltiyoz
    jmp yazdir

carpma:
    mov al, sayi1
    mul sayi2                          ; İkisini carpıyoz
    jmp yazdir

bolme:
    mov al, sayi1
    mov ah, 0                          ; Kalan kısmını temizledik
    div sayi2                          ; Bölme işlemi 
    jmp yazdir

yazdir:
    add al, 30h                        ; Ekrana basmak icin tekrar ASCII yapıyoz
    mov dl, al
    mov ah, 02h                        ; Tek bir harf yazma servisi bu
    int 21h

cikis:
    mov ah, 4ch                        ; Programı kapatıyoruz
    int 21h
main endp
end main
