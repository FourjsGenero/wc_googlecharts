IMPORT FGL gc_column
IMPORT util

DEFINE g gc_column.column_rec

FUNCTION googlecharts_column_test()
DEFINE wc STRING
DEFINE data DYNAMIC ARRAY OF RECORD
    col01 STRING,
    col02 STRING,
    col03 STRING,
    col04 STRING,
    col05 STRING,
    col06 STRING,
    col07 STRING,
    col08 STRING,
    col09 STRING,
    col10 STRING
END RECORD

    CALL init_parameters()
    
    OPEN WINDOW column_test WITH FORM "wc_googlecharts_column_test"

    IF NOT gc_column.is_loaded("formonly.wc",15) THEN
        CALL FGL_WINMESSAGE("Error","Problem loading Web Component","stop")
        CLOSE WINDOW column_test
        RETURN
    END IF

    
    DIALOG ATTRIBUTES(UNBUFFERED)
        INPUT ARRAY g.data_column FROM data_column_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
            ON CHANGE label
                CALL set_column_headings_from_column_data(g.data_column)
            ON CHANGE role
                CALL set_column_headings_from_column_data(g.data_column)
            ON ROW CHANGE
                CALL set_column_headings_from_column_data(g.data_column)
        END INPUT
    
        INPUT ARRAY data FROM data_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.title, g.title_text_style.color, g.title_text_style.font_name, g.title_text_style.font_size, g.title_text_style.bold, g.title_text_style.italic
        FROM title, title_text_style_color, title_text_style_font_name, title_text_style_font_size, title_text_style_bold, title_text_style_italic
        ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.width, g.height,  g.font_size, g.font_name, g.is_stacked, g.orientation, g.reverse_categories, g.theme ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
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

        INPUT ARRAY g.colors 
        FROM colors_scr.*
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT
        
        -- Web Component
        INPUT BY NAME wc ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        ON ACTION draw ATTRIBUTES(TEXT="Draw")
            LABEL lbl_draw:
            LET g.data_col_count = g.data_column.getLength()
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, columnlist_string(g.data_col_count))
            
            LET g.data_row_count = data.getLength()
            CALL gc_column.draw("formonly.wc", g.*)

        ON ACTION example1 ATTRIBUTES(TEXT="Example 1")
            CALL init_parameters()
            CALL data.clear()
            
            LET g.data_column[1].label = "Element"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Density"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].role = "style"
            LET g.data_column[3].type = "string"

            LET g.data_column[4].role = "annotation"
            LET g.data_column[4].type = "string"

            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = "Copper"   LET data[1].col02 = 8.84  LET data[1].col03 = "#b87333" LET data[1].col04 = "Cu"
            LET data[2].col01 = "Silver"   LET data[2].col02 = 10.49 LET data[2].col03 = "silver"  LET data[2].col04 = "Ag"
            LET data[3].col01 = "Gold"     LET data[3].col02 = 19.30 LET data[3].col03 = "gold"    LET data[3].col04 = "Au"
            LET data[4].col01 = "Platinum" LET data[4].col02 = 21.45 LET data[4].col03 = "#e5e4e2" LET data[4].col04 = "Pt"
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()
            
            LET g.title = "Density of Precious Metals, in g/cm^3"
            LET g.legend.position = "none"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03,col04")
            
            CALL gc_column.draw("formonly.wc", g.*)

        ON ACTION example2 ATTRIBUTES(TEXT="Example 2")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_column[1].label = "Year"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Visitations"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].role = "style"
            LET g.data_column[3].type = "string"

            CALL set_column_headings_from_column_data(g.data_column)
            
            LET data[1].col01 = "2010"   LET data[1].col02 = 10  LET data[1].col03 = "color: gray"
            LET data[2].col01 = "2020"   LET data[2].col02 = 14  LET data[2].col03 = "color: #76A7FA"
            LET data[3].col01 = "2030"   LET data[3].col02 = 16  LET data[3].col03 = "opacity: 0.2"
            LET data[4].col01 = "2040"   LET data[4].col02 = 22  LET data[4].col03 = "stroke-color: #703593; stroke-width: 4; fill-color: #C5A5CF"
            LET data[5].col01 = "2050"   LET data[5].col02 = 28  LET data[5].col03 = "stroke-color: #871B47; stroke-opacity: 0.6; stroke-width: 8; fill-color: #BC5679; fill-opacity: 0.2"

            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()
            
            LET g.title = "Styles Extreme Example"
            LET g.legend.position = "none"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03")
            CALL gc_column.draw("formonly.wc", g.*)

        ON ACTION example3 ATTRIBUTES(TEXT="Example 3")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_column[1].label = "Genre"
            LET g.data_column[1].type = "string"
        
            LET g.data_column[2].label = "Fantasy & Sci Fi"
            LET g.data_column[2].type = "number"
    
            LET g.data_column[3].label = "Romance"
            LET g.data_column[3].type = "number"

            LET g.data_column[4].label = "Mystery/Crime"
            LET g.data_column[4].type = "number"

            LET g.data_column[5].label = "General"
            LET g.data_column[5].type = "number"

            LET g.data_column[6].label = " Western"
            LET g.data_column[6].type = "number"

            LET g.data_column[7].label = "Literature"
            LET g.data_column[7].type = "number"

            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = "2010" LET data[1].col02 = 10 LET data[1].col03 = 24 LET data[1].col04 = 20 LET data[1].col05 = 32 LET data[1].col06 = 18 LET data[1].col07 = 5  
            LET data[2].col01 = "2011" LET data[2].col02 = 16 LET data[2].col03 = 22 LET data[2].col04 = 23 LET data[2].col05 = 30 LET data[2].col06 = 16 LET data[2].col07 = 9  
            LET data[3].col01 = "2012" LET data[3].col02 = 28 LET data[3].col03 = 19 LET data[3].col04 = 29 LET data[3].col05 = 30 LET data[3].col06 = 12 LET data[3].col07 = 13 

            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()

            LET g.title = "Stacked Example"
            LET g.legend.position = "top"
            LET g.legend.max_lines = 3
            LET g.is_stacked = "true"

            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03,col04,col05,col06,col07")
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
PRIVATE FUNCTION map_array_to_data(n, d,  column_list)
DEFINE n om.DomNode
DEFINE d DYNAMIC ARRAY WITH DIMENSION 2 OF STRING
DEFINE column_list STRING

DEFINE r om.DomNode
DEFINE i,j INTEGER
DEFINE tok base.StringTokenizer

    CALL d.clear()
    FOR i = 1 TO n.getChildCount()
        LET r = n.getChildByIndex(i)
        LET j = 0
        LET tok = base.StringTokenizer.create(column_list,",")
        WHILE tok.hasMoreTokens()
            LET j = j + 1
            LET d[i,j] = get_record_node(r,tok.nextToken())
        END WHILE
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



PRIVATE FUNCTION columnlist_string(x)
DEFINE x INTEGER
DEFINE sb base.StringBuffer
DEFINE i iNTEGER

    LET sb = base.StringBuffer.create()
    FOR i = 1 TO x
        IF i > 1 THEN
            CALL sb.append(",")
        END IF
        CALL sb.append(SFMT("col%1", i USING "&&"))
    END FOR
    RETURN sb.toString()
END FUNCTION



PRIVATE FUNCTION set_column_headings_from_column_data(l_data_column)
DEFINE l_data_column DYNAMIC ARRAY OF RECORD
    type STRING,
    label STRING,
    role STRING
END RECORD

DEFINE w ui.Window
DEFINE f ui.Form
DEFINE i INTEGER

    LET w= ui.Window.getCurrent()
    LET f = w.getForm()

    FOR i = 1 TO l_data_column.getLength() 
        CALL f.setElementText(SFMT("formonly.col%1", i USING "&&"), nvl(l_data_column[i].label,l_data_column[i].role))
    END FOR
    FOR i = (l_data_column.getLength()+1) TO 10
        CALL f.setElementText(SFMT("formonly.col%1", i USING "&&"), "")
    END FOR
END FUNCTION


PRIVATE FUNCTION init_parameters()
    INITIALIZE g.* TO NULL
    LET g.chart_area.left = 50
    LET g.chart_area.top = 50
    LET g.chart_area.height = 200
    LET g.chart_area.width = 200
    LET g.height = 275
    LET g.width = 275
    LET g.colors[1] = "#3366CC"
    LET g.colors[2] = "#DC3912"
    LET g.colors[3] = "#FF9900"
    LET g.colors[4] = "#109618"
    LET g.colors[5] = "#990099"
    LET g.colors[6] = "#3B3EAC"
    LET g.colors[7] = "#0099C6"
    LET g.colors[8] = "#DD4477"
    LET g.colors[9] = "#66AA00"
    LET g.colors[10] = "#B82E2E"
    LET g.colors[11] = "#316395"
    LET g.colors[12] = "#994499"
    LET g.colors[13] = "#22AA99"
    LET g.colors[14] = "#AAAA11"
    LET g.colors[15] = "#6633CC"
    LET g.colors[16] = "#E67300"
    LET g.colors[17] = "#8B0707"
    LET g.colors[18] = "#329262"
    LET g.colors[19] = "#5574A6"
    LET g.colors[20] = "#3B3EAC"
END FUNCTION