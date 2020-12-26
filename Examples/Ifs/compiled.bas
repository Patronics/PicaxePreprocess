'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 12:44AM, December 27, 2020----
'----SAVING AS compiled.bas ----

'---BEGIN IfTest.bas ---
; Test IFDEF, IFNDEF, ELSE, ELSEIFDEF, ELSEIFNDEF, ENDIF

; #REM [Commented out]
; This is a block comment. Stuff like [Commented out]
; #ERROR "is ignored... hopefully" [Commented out]
; #ENDREM [Commented out]

; #DEFINE TESTA 12
; #IFDEF TESTA ; Should be true
    sertxd("TESTA is defined")
; #ENDIF

; #DEFINE TESTB
; #IFDEF TESTB ; Should be true
    sertxd("TESTB is defined")
; #ENDIF

; #IFDEF TESTA ; Should be true
;     #IFDEF TESTB ; Should be true
        sertxd("TESTA and TESTB are defined")
;     #ENDIF
; ;     #IFDEF TESTC ; Should not be true [#IF CODE REMOVED]
;         sertxd("TESTA and TESTC are defined") [#IF CODE REMOVED]
;         #ERROR "TESTC should not be defined" [#IF CODE REMOVED]
; ;     #ELSEIFDEF TESTD ' Should not be true [#IF CODE REMOVED]
;         sertxd("TESTA and TESTD are defined and TESTC is not") [#IF CODE REMOVED]
;         #ERROR "TESTD should not be defined" [#IF CODE REMOVED]
;     #ELSEIFDEF TESTB ; Should be true
        sertxd("TESTA and TESTB are defined and TESTC and TESTD not")
; ;     #ELSEIFNDEF TESTD ; Should not be true [#IF CODE REMOVED]
;         sertxd("TESTA is defined and TESTB, TESTC and TESTD are not defined") [#IF CODE REMOVED]
;         #ERROR "Already should have evaluated something to True in this statement, so should ignore" [#IF CODE REMOVED]
; ;     #ELSEIFDEF TESTA ; Should not be true [#IF CODE REMOVED]
;         sertxd("TESTA is defined and TESTB, TESTC and are not defined") [#IF CODE REMOVED]
;         #ERROR "Already should have evaluated something to True in this statement, so should ignore" [#IF CODE REMOVED]
;     #ENDIF
; #ENDIF

; Test with values and comparisons
; #DEFINE VALUE 123
; #IF 123 > 12 ; Should be true
    sertxd("VALUE > 12")
;     #IF 123 = 123 ; Should be true
        sertxd("VALUE == 123")
; ;     #ELSE ; Should not be true [#IF CODE REMOVED]
;         sertxd("VALUE != 123") [#IF CODE REMOVED]
;         #ERROR "Should not have got here" [#IF CODE REMOVED]
;     #ENDIF
    sertxd("VALUE is still > 12")
; #ELSEIF 123 < 200 ; Should not be true [#IF CODE REMOVED]
;     sertxd("12 > VALUE < 200") [#IF CODE REMOVED]
;     #ERROR "Should not have got here" [#IF CODE REMOVED]
; ; #ELSE ; Should not de true [#IF CODE REMOVED]
;     sertxd("VALUE <= 12 or VALUE >= 200") [#IF CODE REMOVED]
;     #ERROR "Should not have got here" [#IF CODE REMOVED]
; #ENDIF

; #IF 123 <> 2 ; Should be true
    sertxd("VALUE <> 2")
; ; #ELSEIFDEF VALUE ' Should be false [#IF CODE REMOVED]
;     sertxd("VALUE is defined and != 2") [#IF CODE REMOVED]
;     #ERROR "Should not have got here" [#IF CODE REMOVED]
; #ENDIF

; #UNDEF TESTA
; ; #IFDEF TESTA ; Should no longer be defined [#IF CODE REMOVED]
;     sertxd("TESTA is defined") [#IF CODE REMOVED]
;     #ERROR "TESTA should not be still defined" [#IF CODE REMOVED]
; #ENDIF

; #IFNDEF TESTA ; Should be true
    sertxd("TESTA is NOT defined")
; #ENDIF
'---END IfTest.bas---
