IMPORT util

PUBLIC TYPE org_rec RECORD
    data_col_count INTEGER,
    data_row_count INTEGER,
    data_column DYNAMIC ARRAY OF RECORD
        type STRING,
        label STRING
    END RECORD,

    data DYNAMIC ARRAY WITH DIMENSION 2 OF STRING,

    allow_collapse BOOLEAN,
    allow_html BOOLEAN,
    size STRING
END RECORD

 
FUNCTION draw(fieldname, org)
DEFINE fieldname STRING
DEFINE org org_rec

DEFINE jo util.JSONObject
DEFINE result STRING

    LET jo = util.JSONObject.fromFGL(org)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_org",jo.toString()],[result])
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