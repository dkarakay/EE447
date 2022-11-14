            AREA        main, READONLY, CODE
            THUMB
            EXTERN      InChar      ; Reference external subroutine 
            EXTERN      OutChar      ; Reference external subroutine 
            EXPORT      __main      ; Make available
				
__main
get     BL	InChar
		CMP	 R0,#0x20
		BEQ done
		BL OutChar
		B get
done	B done

            ALIGN
            END