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

DEFINE s STRING
DEFINE result STRING

    LET s = util.JSON.stringify(org)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_org",s],[result])
END FUNCTION