IMPORT util

PUBLIC TYPE gauge_rec RECORD
    animation RECORD
        duration INTEGER,
        easing STRING
    END RECORD,
    data_value FLOAT,
    data_label STRING,
    green_color STRING,
    green_from FLOAT,
    green_to FLOAT,
    height INTEGER,
    major_ticks DYNAMIC ARRAY OF STRING,
    max FLOAT,
    min FLOAT,
    minor_ticks INTEGER,
    red_color STRING,
    red_from FLOAT,
    red_to FLOAT,
    width INTEGER,
    yellow_color STRING,
    yellow_from FLOAT,
    yellow_to FLOAT
END RECORD

FUNCTION draw(fieldname, gauge)
DEFINE fieldname STRING
DEFINE gauge gauge_rec

DEFINE s STRING
DEFINE result STRING

    LET s = util.JSON.stringify(gauge)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_gauge",s],[result])
END FUNCTION

FUNCTION update(fieldname, val)
DEFINE fieldname STRING
DEFINE val FLOAT

DEFINE result STRING

    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_gauge_value",val],[result])
END FUNCTION

FUNCTION is_loaded(fieldname, timeout)
DEFINE fieldname STRING
DEFINE timeout INTEGER

DEFINE loaded STRING

    WHILE timeout > 0
        TRY
            CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"is_loaded"],[loaded])
        CATCH
        END TRY
        IF loaded = "Y" THEN
            RETURN TRUE
        END IF
        SLEEP 1
        LET timeout = timeout - 1
    END WHILE
    RETURN FALSE
END FUNCTION



