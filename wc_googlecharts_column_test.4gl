IMPORT FGL gc_column
IMPORT util

FUNCTION googlecharts_column_test()
DEFINE g gc_column.column_rec
DEFINE wc STRING
DEFINE data DYNAMIC ARRAY OF RECORD
    label STRING,
    value STRING,
    tooltip STRING
END RECORD
DEFINE i INTEGER

    INITIALIZE g.* TO NULL

    -- Set the data
    LET g.data_col_count = 3
    LET g.data_row_count = 4
    LET g.data_column[1].label = "Area"
    LET g.data_column[1].type = "string"
    LET g.data_column[2].label = "Sales"
    LET g.data_column[2].type = "number"
    LET g.data_column[3].role = "tooltip"
    LET g.data_column[3].type = "string"

    LET data[1].label = "North"      LET data[1].value = 1000
    LET data[2].label = "East"       LET data[2].value = 2000
    LET data[3].label = "South"      LET data[3].value = 3000
    LET data[4].label = "West"       LET data[4].value = 4000

    -- Set some minumum settings for the pie chart
    LET g.chart_area.left = 50
    LET g.chart_area.top = 50
    LET g.chart_area.height = 200
    LET g.chart_area.width = 200
    LET g.height = 275
    LET g.title = "Example Column Chart"
    LET g.width = 275
    LET g.colors[1] = "blue"

    -- Other settings can be set programmatically similar to ...
    --LET g.title_text_style.color = "blue"
    --LET g.title_text_style.font_name = "Arial"
    --LET g.title_text_style.font_size = 16
    --LET g.title_text_style.bold = TRUE
    --LET g.title_text_style.italic = TRUE
    --LET g.is3D = TRUE

    --LET g.legend.alignment="center"
    --LET g.legend.position = "right"
    --LET g.legend.max_lines = 1
    --LET g.legend.text_style.color = "red"
    --LET g.legend.text_style.font_name = "Arial"
    --LET g.legend.text_style.font_size = 25
    --LET g.legend.text_style.bold = FALSE
    --LET g.legend.text_style.italic = FALSE
    --LET g.chart_area.background_color.stroke = "red"
    --LET g.chart_area.background_color.stroke_width= 100
    
    OPEN WINDOW column_test WITH FORM "wc_googlecharts_column_test"
    
    DIALOG ATTRIBUTES(UNBUFFERED)
        INPUT ARRAY data FROM data_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.title, g.title_text_style.color, g.title_text_style.font_name, g.title_text_style.font_size, g.title_text_style.bold, g.title_text_style.italic
        FROM title, title_text_style_color, title_text_style_font_name, title_text_style_font_size, title_text_style_bold, title_text_style_italic
        ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.width, g.height,  g.font_size, g.font_name ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT g.background_color.fill, g.background_color.stroke, g.background_color.stroke_width
        FROM background_color_fill, background_color_stroke, background_color_stroke_width
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.chart_area.background_color.stroke, g.chart_area.background_color.stroke_width,
              g.chart_area.left, g.chart_area.top, g.chart_area.width, g.chart_area.height
        FROM  chart_area_background_color_stroke, chart_area_background_color_stroke_width,
              chart_area_left, chart_area_top, chart_area_width, chart_area_height
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.legend.alignment, g.legend.position, g.legend.max_lines,
              g.legend.text_style.color, g.legend.text_style.font_name, g.legend.text_style.font_size, g.legend.text_style.bold, g.legend.text_style.italic
        FROM legend_alignment, legend_position, legend_max_lines,
             legend_text_style_color, legend_text_style_font_name, legend_text_style_font_size, legend_text_style_bold, legend_text_style_italic
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.tooltip.ignore_bounds, g.tooltip.is_html, g.tooltip.show_color_code, {g.tooltip.text,}
        g.tooltip.text_style.color, g.tooltip.text_style.font_name, g.tooltip.text_style.font_size, g.tooltip.text_style.bold, g.tooltip.text_style.italic, 
        g.tooltip.trigger
        FROM tooltip_ignore_bounds, tooltip_is_html, tooltip_show_color_code, {tooltip_text,}
        tooltip_text_style_color, tooltip_text_style_font_name, tooltip_text_style_font_size, tooltip_text_style_bold, tooltip_text_style_italic, 
        tooltip_trigger
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        --INPUT ARRAY g.colors 
        --FROM colors_scr.*
        --ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        --END INPUT
        
        -- Web Component
        INPUT BY NAME wc ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        ON ACTION draw ATTRIBUTES(TEXT="Draw")
            LABEL lbl_draw:
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","tooltip")
            LET g.data_row_count = data.getLength()
            CALL gc_column.draw("formonly.wc", g.*)

        ON ACTION random ATTRIBUTES(TEXT="Random")
            -- randomise data
            FOR i = 1 TO data.getLength()
                LET data[i].value = util.Math.rand(10000)+1
            END FOR
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","tooltip")
            CALL gc_column.draw("formonly.wc", g.*)
            
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW column_test
END FUNCTION



-- Take a 4gl array and map to data for passing to web component
-- Note: array is passed in via base.Typeinfo.create(array_name)
PRIVATE FUNCTION map_array_to_data(n, d, label_column, value_column, tooltip_column)
DEFINE n om.DomNode
DEFINE d DYNAMIC ARRAY WITH DIMENSION 2 OF STRING
DEFINE label_column, value_column, tooltip_column STRING

DEFINE r om.DomNode
DEFINE i INTEGER

    CALL d.clear()
    FOR i = 1 TO n.getChildCount()
        LET r = n.getChildByIndex(i)
        LET d[i,1] = get_record_node(r,label_column)
        LET d[i,2] = get_record_node(r,value_column)
        LET d[i,3] = get_record_node(r,tooltip_column)
    END FOR
END FUNCTION







PRIVATE FUNCTION get_record_node(r,c)
DEFINE r om.DomNode
DEFINE nl om.NodeList
DEFINE f om.DomNode
DEFINE c STRING

    LET nl = r.selectByPath(SFMT("//Field[@name='%1']",c))
    IF nl.getLength() != 1 THEN
        RETURN NULL
    ELSE
        LET f = nl.item(1)
        RETURN f.getAttribute("value")
    END IF
END FUNCTION