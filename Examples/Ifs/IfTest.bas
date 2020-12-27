; Test IFDEF, IFNDEF, ELSE, ELSEIFDEF, ELSEIFNDEF, ENDIF
; PE6: 14M2 is 281 bytes
; Preprocessor with the same compilers: 14M2 is also 281 bytes. Hopefully this means they match.
#REM
This is a block comment. Stuff like
#ERROR "is ignored... hopefully"
#ENDREM

#DEFINE TESTA 12
#IFDEF TESTA ; Should be true
    sertxd("TESTA is defined")
#ENDIF

#DEFINE TESTB
#IFDEF TESTB ; Should be true
    sertxd("TESTB is defined")
#ENDIF

#IFDEF TESTA ; Should be true
    #IFDEF TESTB ; Should be true
        sertxd("TESTA and TESTB are defined")
    #ENDIF
    #IFDEF TESTC ; Should not be true
        sertxd("TESTA and TESTC are defined")
        #ERROR "TESTC should not be defined"
    #ELSEIFDEF TESTD ' Should not be true
        sertxd("TESTA and TESTD are defined and TESTC is not")
        #ERROR "TESTD should not be defined"
    #ELSEIFDEF TESTB ; Should be true
        sertxd("TESTA and TESTB are defined and TESTC and TESTD not")
#rem ; #elseifndef is not a standared preprocessor directive, but it was not hard to include seeing as #elseifdef is implemented.
    #ELSEIFNDEF TESTZ ; Should not be true
        sertxd("TESTA is defined and TESTB, TESTC and TESTD are not defined")
        #ERROR "Already should have evaluated something to True in this statement, so should ignore"
#endrem
    #ELSEIFDEF TESTA ; Should not be true
        sertxd("TESTA is defined and TESTB, TESTC and are not defined")
        #ERROR "Already should have evaluated something to True in this statement, so should ignore"
    #ENDIF
#ENDIF

; Test with values and comparisons
#DEFINE VALUE 123
#IF VALUE > 12 ; Should be true
    sertxd("VALUE > 12")
    #IF VALUE = 123 ; Should be true
        sertxd("VALUE == 123")
    #ELSE ; Should not be true
        sertxd("VALUE != 123")
        #ERROR "Should not have got here"
    #ENDIF
    sertxd("VALUE is still > 12")
#ELSEIF VALUE < 200 ; Should not be true
    sertxd("12 > VALUE < 200")
    #ERROR "Should not have got here"
#ELSE ; Should not de true
    sertxd("VALUE <= 12 or VALUE >= 200")
    #ERROR "Should not have got here"
#ENDIF

#IF VALUE <> 2 ; Should be true
    sertxd("VALUE <> 2")
#ELSEIFDEF VALUE ' Should be false
    sertxd("VALUE is defined and != 2")
    #ERROR "Should not have got here"
#ENDIF

#rem ; Even though #undef is in the manual, it does not appear to be implemented in PE6. Uncomment to test with 
#UNDEF TESTA
#IFDEF TESTA ; Should no longer be defined
    sertxd("TESTA is defined")
    #ERROR "TESTA should not be still defined"
#ENDIF

#IFNDEF TESTA ; Should be true
    sertxd("TESTA is NOT defined")
#ENDIF
#endrem