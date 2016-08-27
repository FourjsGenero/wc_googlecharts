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

    background_color RECORD
        stroke_width INTEGER,
        stroke STRING,
        fill STRING
    END RECORD,
    color_axis RECORD
        min_value FLOAT,
        max_value FLOAT,
        values DYNAMIC ARRAY OF STRING,
        colors DYNAMIC ARRAY OF STRING
    END RECORD,
    dataless_region_color STRING,
    default_color STRING,
    display_mode STRING,
    domain STRING,
    enable_region_interactivity BOOLEAN,
    height INTEGER,
    keep_aspect_ratio BOOLEAN,
    legend RECORD
        number_format STRING,
        text_style RECORD
            color STRING,
            font_name STRING,
            font_size INTEGER,
            bold BOOLEAN,
            italic BOOLEAN
        END RECORD
    END RECORD,
    magnifying_glass RECORD
        enable BOOLEAN,
        zoom_factor FLOAT
    END RECORD,
    marker_opacity FLOAT,
    region STRING, 
    resolution STRING,
    size_axis RECORD
        min_size FLOAT,
        max_size FLOAT,
        min_value FLOAT,
        max_value FLOAT
    END RECORD,
    tooltip RECORD
        ignore_bounds BOOLEAN,
        is_html BOOLEAN,
        show_color_code BOOLEAN,
--        text STRING,
        text_style RECORD
            color STRING,
            font_name STRING,
            font_size INTEGER,
            bold BOOLEAN,
            italic BOOLEAN
        END RECORD,
        trigger STRING
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