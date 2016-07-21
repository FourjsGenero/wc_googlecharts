IMPORT util

PUBLIC TYPE geo_rec RECORD
    data_col_count INTEGER,
    data_row_count INTEGER,
    data_column DYNAMIC ARRAY OF RECORD
        type STRING,
        label STRING,
        role STRING
    END RECORD,

    data DYNAMIC ARRAY WITH DIMENSION 2 OF STRING,

    color_axis RECORD
        min_value FLOAT,
        max_value FLOAT,
        values DYNAMIC ARRAY OF STRING,
        colors DYNAMIC ARRAY OF STRING
    END RECORD,
    display_mode STRING,
    height INTEGER,
    region STRING, 
    size_axis RECORD
        min_size FLOAT,
        max_size FLOAT,
        min_value FLOAT,
        max_value FLOAT
    END RECORD,
    width INTEGER
END RECORD

FUNCTION draw(fieldname, c)
DEFINE fieldname STRING
DEFINE c geo_rec

DEFINE s STRING
DEFINE result STRING

    LET s = util.JSON.stringify(c)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_geo",s],[result])
END FUNCTION