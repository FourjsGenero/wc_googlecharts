IMPORT util

PUBLIC TYPE sliceType RECORD
        color STRING,
        offset FLOAT,
        text_style_color STRING, 
        text_style_font_name STRING,
        text_style_font_size INTEGER
END RECORD

PUBLIC TYPE column_rec RECORD
    data_col_count INTEGER,
    data_row_count INTEGER,
    data_column DYNAMIC ARRAY OF RECORD
        type STRING,
        label STRING,
        role STRING
    END RECORD,

    data DYNAMIC ARRAY WITH DIMENSION 2 OF STRING,

    --animation RECORD
        --duration INTEGER,
        --easing STRING, 
        --startup BOOLEAN
    --END RECORD,
    -- annotations RECORD
    --  END RECORD,
    --axisTitlesPosition STRING,

    background_color RECORD
        stroke_width INTEGER,
        stroke STRING,
        fill STRING
    END RECORD,

    --bar RECORD
        --group_width INTEGER
    --END RECORD,
    --bars STRING,
    chart_area RECORD
        background_color RECORD
            stroke STRING,
            stroke_width INTEGER
        END RECORD,
        left INTEGER,
        top INTEGER,
        width INTEGER,
        height INTEGER,
        subtitle STRING,
        title STRING
    END RECORD,
    colors DYNAMIC ARRAY OF STRING,
    --data_opacity FLOAT,
    --enableInteractivity BOOLEAN,
    -- explorer 
    --focus_target BOOLEAN
    font_size INTEGER,
    font_name STRING,
    --forceIFrame BOOLEAN,
    --h_axis RECORD
        --baseline FLOAT,
        --baseline_color STRING,
        --direction INTEGER,
        --format STRING,
        --gridlines RECORD
            --color STRING,
            --count INTEGER,
            --units RECORD
                --years STRING,
                --months STRING,
                --days STRING,
                --hours STRING,
                --minutes STRING,
                --seconds STRING,
                --milliseconds STRING
            --END RECORD
        --END RECORD,
        --minor_gridlines RECORD
            --color STRING,
            --count INTEGER,
            --units RECORD
                --years STRING,
                --months STRING,
                --days STRING,
                --hours STRING,
                --minutes STRING,
                --seconds STRING,
                --milliseconds STRING
            --END RECORD
        --END RECORD,
        --log_scale BOOLEAN,
        --scale_type STRING,
        --text_position STRING,
        --text_style RECORD
            --color STRING,
            --font_name STRING,
            --font_size INTEGER,
            --bold BOOLEAN,
            --italic BOOLEAN
        --END RECORD,
        --ticks STRING,
        --title STRING,
        --title_text_style RECORD
            --color STRING,
            --font_name STRING,
            --font_size INTEGER,
            --bold BOOLEAN,
            --italic BOOLEAN
        --END RECORD,
        --allow_container_boundary_text_cutoff BOOLEAN,
        --slanted_text BOOLEAN,
        --slanted_text_angle FLOAT,
        --max_alternation INTEGER,
        --max_text_lines INTEGER,
        --min_text_spacing INTEGER,
        --show_text_every INTEGER,
        --max_value FLOAT,
        --min_value FLOAT,
        --view_window_mode STRING,
        --view_window RECORD
            --max FLOAT,
            --min FLOAT
        --END RECORD
    --END RECORD,
    height INTEGER,
    is_stacked STRING,
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
    orientation STRING,
    reverse_categories BOOLEAN,
    -- series
    theme STRING,
    --title_position STRING,
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
    -- trend_lines 
    -- vAxes 
    width INTEGER
END RECORD
        
    
 
FUNCTION draw(fieldname, col)
DEFINE fieldname STRING
DEFINE col column_rec

DEFINE jo util.JSONObject
DEFINE result STRING

    LET jo = util.JSONObject.fromFGL(col)
    CALL ui.Interface.frontCall("webcomponent","call",[fieldname,"draw_column",jo.toString()],[result])
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
