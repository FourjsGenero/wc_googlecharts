IMPORT FGL gc_gauge
IMPORT util

FUNCTION googlecharts_gauge_test()
DEFINE g gc_gauge.gauge_rec

DEFINE wc STRING
   
    LET g.data_label = "Title"
    LET g.data_value = 50

    LET g.animation.duration = 500
    LET g.animation.easing = "linear"

    LET g.height = 275
    LET g.width = 275
    
    LET g.major_ticks[1] = "0"
    LET g.major_ticks[2] = "20"
    LET g.major_ticks[3] = "40"
    LET g.major_ticks[4] = "60"
    LET g.major_ticks[5] = "80"
    LET g.major_ticks[6] = "100"

    LET g.max = g.major_ticks[g.major_ticks.getLength()]
    LET g.min = g.major_ticks[1]

    LET g.minor_ticks = 4
    
    LET g.green_color = "#00FF00"
    LET g.green_from = g.min
    LET g.green_to = g.major_ticks[4]
    LET g.yellow_color= "orange"
    LET g.yellow_from = g.green_to
    LET g.yellow_to = g.major_ticks[5]
    LET g.red_color = "red"
    LET g.red_from = g.yellow_to
    LET g.red_to = g.max
    
    OPEN WINDOW gauge_test WITH FORM "wc_googlecharts_gauge_test"

    IF NOT gc_gauge.is_loaded("formonly.wc",15) THEN
        CALL FGL_WINMESSAGE("Error","Problem loading Web Component","stop")
        CLOSE WINDOW gauge_test
        RETURN
    END IF
   
    DIALOG ATTRIBUTES(UNBUFFERED)
        -- Single record
        INPUT BY NAME g.data_label, g.data_value ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.width, g.height, g.min, g.max, g.minor_ticks, g.green_color, g.green_from, g.green_to, g.yellow_color, g.yellow_from, g.yellow_to, g.red_color, g.red_from,g.red_to ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT ARRAY g.major_ticks FROM major_ticks_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.animation.duration, g.animation.easing ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        -- Web Component
        INPUT BY NAME wc ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        BEFORE DIALOG
            GOTO lbl_draw 

        ON ACTION draw ATTRIBUTES(TEXT="Draw")
            LABEL lbl_draw:
            CALL gc_gauge.draw("formonly.wc", g.*)

        ON ACTION random ATTRIBUTES(TEXT="Random")
            LET g.data_value = util.Math.rand(g.max-g.min)+g.min
            CALL gc_gauge.update("formonly.wc", g.data_value)
            
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW gauge_test
END FUNCTION