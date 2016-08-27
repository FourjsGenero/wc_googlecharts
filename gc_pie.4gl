IMPORT util

PUBLIC TYPE sliceType RECORD
        color STRING,
        offset FLOAT,
        text_style_color STRING, 
        text_style_font_name STRING,
        text_style_font_size INTEGER
END RECORD

PUBLIC TYPE pie_rec RECORD
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
    chart_area RECORD
        background_color RECORD
            stroke STRING,
            stroke_width INTEGER
        END RECORD,
        left INTEGER,
        top INTEGER,
        width INTEGER,
        height INTEGER
    END RECORD,
    colors DYNAMIC ARRAY OF STRING,
    enableInteractivity BOOLEAN,
    font_size INTEGER,
    font_name STRING,
    forceIFrame BOOLEAN,
    height INTEGER,
    is3d BOOLEAN,
    legend RECORD
        alignment STRING,
        position STRING,
        max_lines INTEGER,
        text_style RECORD
            color STRING,
            font_name STRING,
            font_size INTEGER,
            bold BOOLEAN,
            italic BOOLEAN
        END RECORD
    END RECORD,
    pie_hole FLOAT,
    pie_slice RECORD
        border_color STRING,
        text STRING,
        text_style RECORD
            color STRING,
            font_name STRING,
            font_size INTEGER
        END RECORD
    END RECORD,
    pie_start_angle FLOAT,
    reverse_categories BOOLEAN,
    pie_residue_slice_color STRING,
    pie_residue_slice_label STRING,
    slices DYNAMIC ARRAY OF sliceTYPE,

    slice_visibility_threshold FLOAT,
    title STRING,
    title_text_style RECORD
        color STRING,
        font_name STRING,
        font_size INTEGER,
        bold BOOLEAN,
        italic BOOLEAN
    END RECORD,
    tooltip RECORD
        ignore_bounds BOOLEAN,
        is_html BOOLEAN,
        show_color_code BOOLEAN,
        text STRING,
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
        
    
 
FUNCTION draw(fieldname, pie)
DEFINE fieldname STRING
DEFINE pie pie_rec

DEFINE s STRING
DEFINE result STRING

    LET s = util.JSON.stringify(pie)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_pie",s],[result])
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