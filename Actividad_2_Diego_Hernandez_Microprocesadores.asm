.org 0000h
    ; Load the number we want to find the square root of
    ld b,49         

    ; Initialize C to 0 where the result will be stored
    ld c,0          

    ; Load the number into A to start comparisons
    ld a,b          

    ; If the number is 0, no need to continue, jump to the end
    cp 0            
    jr Z, finish    

    ; If the number is 1, the square root is 1, skip to the end
    cp 1            
    jr Z, finish    

    ; D is the current square root estimate, starting at 1
    ld d,1          

    ; E is the counter, also starting at 1
    ld e,1          
loop:
    ; Compare the number with the current square (D)
    ld a,b          
    cp d            

    ; If D is greater than the number, we've found the approximate root
    jr c, final_adjust  

    ; Otherwise, increment E to try the next number
    inc e           

    ; Prepare H and L for the simulated multiplication
    ld h,0          
    ld l,0          
multiply:
    ; Add E to itself repeatedly to simulate E * E
    ld a,l          
    add a,e         
    ld l,a          
    inc h           

    ; Keep multiplying until we reach the correct value
    ld a,e          
    cp h            
    jr nz, multiply 

    ; Store the result of the multiplication in D
    ld d,l          
    jr loop         

finish:
    ; Done! The exact or approximate square root is now in A, store it in C
    ld c,a          
    jr convert      

final_adjust:
    ; If we've overshot, adjust E to get the approximate root
    dec e           
    ld c,e          
    jr convert      

convert:
    ; Now we convert the number to BCD format
    ld a,b          
    ld l,0          
convert_loop:
    ; Subtract 10 repeatedly to count the tens place
    cp 10           
    jr c, done      
    sub 10          
    inc l           
    jr convert_loop 

done:
    ; Shift the tens place bits left to convert to BCD
    sla l           
    sla l           
    sla l           
    sla l           
    or l            

    ; Store the result in B and halt
    ld b,a          
    halt            

    .end

    ; Diego Hernandez Gomez 1709
