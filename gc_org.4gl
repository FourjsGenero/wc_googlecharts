IMPORT util

PUBLIC TYPE org_rec RECORD
    data_col_count INTEGER,
    data_row_count INTEGER,
    data_column DYNAMIC ARRAY OF RECORD
        type STRING,
        label STRING
    END RECORD,

    data DYNAMIC ARRAY WITH DIMENSION 2 OF STRING,

    allow_html BOOLEAN,
    background_color RECORD
        stroke_width INTEGER,
        stroke STRING,
        fill STRING
    END RECORD,

    height INTEGER,
    title STRING,
    width INTEGER
END RECORD

 
FUNCTION draw(fieldname, org)
DEFINE fieldname STRING
DEFINE org org_rec

DEFINE s STRING
DEFINE result STRING

    LET s = util.JSON.stringify(org)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_org",s],[result])
END FUNCTION