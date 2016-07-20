IMPORT FGL gc_line
IMPORT util

FUNCTION googlecharts_line_test()
DEFINE g gc_line.line_rec
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
DEFINE i INTEGER

    INITIALIZE g.* TO NULL

    -- Set some minumum settings for the line chart
    LET g.chart_area.left = 50
    LET g.chart_area.top = 50
    LET g.chart_area.height = 200
    LET g.chart_area.width = 200
    LET g.height = 275
    LET g.title = "Example Line Chart"
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
    
    OPEN WINDOW line_test WITH FORM "wc_googlecharts_line_test"
    
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

        INPUT BY NAME g.width, g.height,  g.font_size, g.font_name, g.orientation, g.reverse_categories, g.theme ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
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
            CALL gc_line.draw("formonly.wc", g.*)

        ON ACTION example1 ATTRIBUTES(TEXT="Example 1")
            CALL g.data_column.clear()
            CALL data.clear()

            LET g.data_column[1].label = "Year"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Sales"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].label = "Expenses"
            LET g.data_column[3].type = "number"
            
            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = "2004"   LET data[1].col02 = 1000  LET data[1].col03 = "400" 
            LET data[2].col01 = "2005"   LET data[2].col02 = 1170  LET data[2].col03 = "460" 
            LET data[3].col01 = "2006"   LET data[3].col02 = 660   LET data[3].col03 = "1120" 
            LET data[4].col01 = "2007"   LET data[4].col02 = 1030  LET data[4].col03 = "540"
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()
            
            LET g.title = "Company Performance"
            LET g.legend.position = "bottom"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03")
            
            CALL gc_line.draw("formonly.wc", g.*)

        ON ACTION example2 ATTRIBUTES(TEXT="Example 2")
            CALL g.data_column.clear()
            CALL data.clear()

            LET g.data_column[1].label = "Day"
            LET g.data_column[1].type = "number"

            LET g.data_column[2].label = "Guardians of the Galaxy"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].label = "The Avengers"
            LET g.data_column[3].type = "number"

            LET g.data_column[4].label = "Transformers: Age of Extinction"
            LET g.data_column[4].type = "number"
            
            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = 1    LET data[1].col02 =37.8   LET data[1].col03 =80.8   LET data[1].col04 =41.8
            LET data[2].col01 = 2    LET data[2].col02 =30.9   LET data[2].col03 =69.5   LET data[2].col04 =32.4
            LET data[3].col01 = 3    LET data[3].col02 =25.4   LET data[3].col03 =57     LET data[3].col04 =25.7
            LET data[4].col01 = 4    LET data[4].col02 =11.7   LET data[4].col03 =18.8   LET data[4].col04 =10.5
            LET data[5].col01 = 5    LET data[5].col02 =11.9   LET data[5].col03 =17.6   LET data[5].col04 =10.4
            LET data[6].col01 = 6    LET data[6].col02 =8.8    LET data[6].col03 =13.6   LET data[6].col04 =7.7
            LET data[7].col01 = 7    LET data[7].col02 =7.6    LET data[7].col03 =12.3   LET data[7].col04 =9.6
            LET data[8].col01 = 8    LET data[8].col02 =12.3   LET data[8].col03 =29.2   LET data[8].col04 =10.6
            LET data[9].col01 = 9    LET data[9].col02 =16.9   LET data[9].col03 =42.9   LET data[9].col04 =14.8
            LET data[10].col01 = 10  LET data[10].col02 =12.8  LET data[10].col03 =30.9  LET data[10].col04 =11.6
            LET data[11].col01 = 11  LET data[11].col02 =5.3   LET data[11].col03 =7.9   LET data[11].col04 =4.7
            LET data[12].col01 = 12  LET data[12].col02 =6.6   LET data[12].col03 =8.4   LET data[12].col04 =5.2
            LET data[13].col01 = 13  LET data[13].col02 =4.8   LET data[13].col03 =6.3   LET data[13].col04 =3.6
            LET data[14].col01 = 14  LET data[14].col02 =4.2   LET data[14].col03 =6.2   LET data[14].col04 =3.4
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()
            
            LET g.title = "Box Iffce Earnings in First Two Weeks of Opening"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03,col04")
            
            CALL gc_line.draw("formonly.wc", g.*)
            
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW line_test
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