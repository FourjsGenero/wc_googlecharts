IMPORT FGL gc_geo
IMPORT util

FUNCTION googlecharts_geo_test()
DEFINE g gc_geo.geo_rec
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

    INITIALIZE g.* TO NULL

    -- Set some minumum settings for the pie chart
    LET g.height = 275
    LET g.width = 275
    

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
    
    OPEN WINDOW geo_test WITH FORM "wc_googlecharts_geo_test"
    
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

        INPUT BY NAME g.width, g.height, g.region, g.display_mode ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT g.color_axis.min_value, g.color_axis.max_value FROM color_axis_min_value, color_axis_max_value ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT ARRAY g.color_axis.values 
        FROM color_axis_values_scr.*
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT ARRAY g.color_axis.colors 
        FROM color_axis_colors_scr.*
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
            CALL gc_geo.draw("formonly.wc", g.*)

        ON ACTION example1 ATTRIBUTES(TEXT="Example 1")
            CALL g.data_column.clear()
            CALL data.clear()
            
            LET g.data_column[1].label = "Country"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Popularity"
            LET g.data_column[2].type = "number"

            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = "Germany"         LET data[1].col02 = 200  
            LET data[2].col01 = "United States"   LET data[2].col02 = 300 
            LET data[3].col01 = "Brazil"          LET data[3].col02 = 400 
            LET data[4].col01 = "Canada"          LET data[4].col02 = 500 
            LET data[5].col01 = "France"          LET data[5].col02 = 600 
            LET data[6].col01 = "RU"              LET data[6].col02 = 700 
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()

            INITIALIZE g.region TO NULL
            INITIALIZE g.display_mode TO NULL
            CALL g.color_axis.colors.clear()
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02")
            
            CALL gc_geo.draw("formonly.wc", g.*)

        ON ACTION example2 ATTRIBUTES(TEXT="Example 2")
            CALL g.data_column.clear()
            CALL data.clear()
            
            LET g.data_column[1].label = "Country"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Population"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].label = "Area"
            LET g.data_column[3].type = "number"

            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = 'Rome'      LET data[1].col02 =  2761477   LET data[1].col03 =   1285.31
            LET data[2].col01 = 'Milan'     LET data[2].col02 =  1324110   LET data[2].col03 =    181.76
            LET data[3].col01 = 'Naples'    LET data[3].col02 =   959574   LET data[3].col03 =    117.27
            LET data[4].col01 = 'Turin'     LET data[4].col02 =   907563   LET data[4].col03 =    130.17
            LET data[5].col01 = 'Palermo'   LET data[5].col02 =   655875   LET data[5].col03 =    158.9
            LET data[6].col01 = 'Genoa'     LET data[6].col02 =   607906   LET data[6].col03 =    243.60
            LET data[7].col01 = 'Bologna'   LET data[7].col02 =   380181   LET data[7].col03 =    140.7
            LET data[8].col01 = 'Florence'  LET data[8].col02 =   371282   LET data[8].col03 =    102.41
            LET data[9].col01 = 'Fiumicino' LET data[9].col02 =    67370   LET data[9].col03 =    213.44
            LET data[10].col01 = 'Anzio'    LET data[10].col02 =   52192   LET data[10].col03 =    43.43
            LET data[11].col01 = 'Ciampino' LET data[11].col02 =   38262   LET data[11].col03 =    11
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()

            LET g.region = "IT"
            LET g.display_mode = "markers"

            LET g.color_axis.colors[1] = "green"
            LET g.color_axis.colors[2] = "blue"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03")
            
            CALL gc_geo.draw("formonly.wc", g.*)
            
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW geo_test
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