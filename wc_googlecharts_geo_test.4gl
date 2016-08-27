IMPORT FGL gc_geo
IMPORT util

DEFINE g gc_geo.geo_rec

FUNCTION googlecharts_geo_test()
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
    
    OPEN WINDOW geo_test WITH FORM "wc_googlecharts_geo_test"

    IF NOT gc_geo.is_loaded("formonly.wc",15) THEN
        CALL FGL_WINMESSAGE("Error","Problem loading Web Component","stop")
        CLOSE WINDOW gauge_test
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

        INPUT BY NAME g.width, g.height, g.region, g.display_mode, g.domain, g.keep_aspect_ratio, g.marker_opacity, g.resolution, g.enable_region_interactivity 
        ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT g.background_color.fill, g.background_color.stroke, g.background_color.stroke_width
        FROM background_color_fill, background_color_stroke, background_color_stroke_width
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.legend.number_format, 
              g.legend.text_style.color, g.legend.text_style.font_name, g.legend.text_style.font_size, g.legend.text_style.bold, g.legend.text_style.italic
        FROM legend_number_format,
             legend_text_style_color, legend_text_style_font_name, legend_text_style_font_size, legend_text_style_bold, legend_text_style_italic
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.size_axis.min_size, g.size_axis.max_size, g.size_axis.min_value, g.size_axis.max_value FROM size_axis_min_size, size_axis_max_size,size_axis_min_value, size_axis_max_value  ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT g.color_axis.min_value, g.color_axis.max_value , g.dataless_region_color, g.default_color
        FROM color_axis_min_value, color_axis_max_value, dataless_region_color , default_color
        ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT ARRAY g.color_axis.values 
        FROM color_axis_values_scr.*
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT ARRAY g.color_axis.colors 
        FROM color_axis_colors_scr.*
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.magnifying_glass.enable, g.magnifying_glass.zoom_factor
        FROM magnifying_glass_enable, magnifying_glass_zoom_factor
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
            CALL init_parameters()
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
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02")
            
            CALL gc_geo.draw("formonly.wc", g.*)

        ON ACTION example2 ATTRIBUTES(TEXT="Example 2")
            CALL init_parameters()
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

        ON ACTION example3 ATTRIBUTES(TEXT="Example 3")
            CALL init_parameters()
            CALL data.clear()
            
            LET g.data_column[1].label = "Country"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Population"
            LET g.data_column[2].type = "number"

            LET g.data_column[3].label = "Area Percentage"
            LET g.data_column[3].type = "number"

            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = 'France'      LET data[1].col02 =  65700000   LET data[1].col03 =   50
            LET data[2].col01 = 'Germany'     LET data[2].col02 =  81890000   LET data[2].col03 =   27
            LET data[3].col01 = 'Poland'      LET data[3].col02 =  38540000   LET data[3].col03 =   23            
            
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()

            LET g.region = "155"
            LET g.display_mode = "markers"

            LET g.color_axis.colors[1] = "#e7711c"
            LET g.color_axis.colors[2] = "#4374e0"

            LET g.size_axis.min_value = 0
            LET g.size_axis.max_value = 100
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "col01,col02,col03")
            
            CALL gc_geo.draw("formonly.wc", g.*)

        ON ACTION example4 ATTRIBUTES(TEXT="Example 4")
            CALL init_parameters()
            CALL data.clear()
            
            LET g.data_column[1].label = "Country"
            LET g.data_column[1].type = "string"

            LET g.data_column[2].label = "Latitude"
            LET g.data_column[2].type = "number"
            
            CALL set_column_headings_from_column_data(g.data_column)

            LET data[1].col01 = "Algeria" LET data[1].col02 = 36
            LET data[2].col01 = "Angola" LET data[2].col02 = -8
            LET data[3].col01 = "Benin" LET data[3].col02 = 6
            LET data[4].col01 = "Botswana" LET data[4].col02 = -24
            LET data[5].col01 = 'Burkina Faso' LET data[5].col02 =12 
            LET data[6].col01 = 'Burundi' LET data[6].col02 =-3 
            LET data[7].col01 = 'Cameroon' LET data[7].col02 =3
            LET data[8].col01 = 'Canary Islands' LET data[8].col02 =28 
            LET data[9].col01 = 'Cape Verde' LET data[9].col02 =15
            LET data[10].col01 = 'Central African Republic' LET data[10].col02 =4 
            LET data[11].col01 = 'Ceuta' LET data[11].col02 =35 
            LET data[12].col01 = 'Chad' LET data[12].col02 =12
            LET data[13].col01 = 'Comoros' LET data[13].col02 =-12 
            LET data[14].col01 = 'Cote d\'Ivoire' LET data[14].col02 =6
            LET data[15].col01 = 'Democratic Republic of the Congo' LET data[15].col02 =-3 
            LET data[16].col01 = 'Djibouti' LET data[16].col02 =12
            LET data[17].col01 = 'Egypt' LET data[17].col02 =26 
            LET data[18].col01 = 'Equatorial Guinea' LET data[18].col02 =3 
            LET data[19].col01 = 'Eritrea' LET data[19].col02 =15
            LET data[20].col01 = 'Ethiopia' LET data[20].col02 =9 
            LET data[21].col01 = 'Gabon' LET data[21].col02 =0 
            LET data[22].col01 = 'Gambia' LET data[22].col02 =13 
            LET data[23].col01 = 'Ghana' LET data[23].col02 =5
            LET data[24].col01 = 'Guinea' LET data[24].col02 =10 
            LET data[25].col01 = 'Guinea-Bissau' LET data[25].col02 =12 
            LET data[26].col01 = 'Kenya' LET data[26].col02 =-1
            LET data[27].col01 = 'Lesotho' LET data[27].col02 =-29 
            LET data[28].col01 = 'Liberia' LET data[28].col02 =6 
            LET data[29].col01 = 'Libya' LET data[29].col02 =32 
            LET data[30].col01 = 'Madagascar' LET data[30].col02 =null
            LET data[31].col01 = 'Madeira' LET data[31].col02 =33 
            LET data[32].col01 = 'Malawi' LET data[32].col02 =-14 
            LET data[33].col01 = 'Mali' LET data[33].col02 =12 
            LET data[34].col01 = 'Mauritania' LET data[34].col02 =18
            LET data[35].col01 = 'Mauritius' LET data[35].col02 =-20 
            LET data[36].col01 = 'Mayotte' LET data[36].col02 =-13 
            LET data[37].col01 = 'Melilla' LET data[37].col02 =35
            LET data[38].col01 = 'Morocco' LET data[38].col02 =32 
            LET data[39].col01 = 'Mozambique' LET data[39].col02 =-25 
            LET data[40].col01 = 'Namibia' LET data[40].col02 =-22
            LET data[41].col01 = 'Niger' LET data[41].col02 =14 
            LET data[42].col01 = 'Nigeria' LET data[42].col02 =8 
            LET data[43].col01 = 'Republic of the Congo' LET data[43].col02 =-1
            LET data[44].col01 = 'Réunion' LET data[44].col02 =-21 
            LET data[45].col01 = 'Rwanda' LET data[45].col02 =-2 
            LET data[46].col01 = 'Saint Helena' LET data[46].col02 =-16
            LET data[47].col01 = 'São Tomé and Principe' LET data[47].col02 =0 
            LET data[48].col01 = 'Senegal' LET data[48].col02 =15
            LET data[49].col01 = 'Seychelles' LET data[49].col02 =-5 
            LET data[50].col01 = 'Sierra Leone' LET data[50].col02 =8 
            LET data[51].col01 = 'Somalia' LET data[51].col02 =2
            LET data[52].col01 = 'Sudan' LET data[52].col02 =15 
            LET data[53].col01 = 'South Africa' LET data[53].col02 =-30 
            LET data[54].col01 = 'South Sudan' LET data[54].col02 =5
            LET data[55].col01 = 'Swaziland' LET data[55].col02 =-26 
            LET data[56].col01 = 'Tanzania' LET data[56].col02 =-6 
            LET data[57].col01 = 'Togo' LET data[57].col02 =6 
            LET data[58].col01 = 'Tunisia' LET data[58].col02 =34
            LET data[59].col01 = 'Uganda' LET data[59].col02 =1 
            LET data[60].col01 = 'Western Sahara' LET data[60].col02 =25 
            LET data[61].col01 = 'Zambia' LET data[61].col02 =-15
            LET data[62].col01 = 'Zimbabwe' LET data[62].col02 =-18
              
            LET g.data_col_count = g.data_column.getLength()
            LET g.data_row_count = data.getLength()

            LET g.region = "002"
            
            LET g.color_axis.colors[1] = "#00853f"
            LET g.color_axis.colors[2] = "black"
            LET g.color_axis.colors[3] = "#e31b23"

            LET g.background_color.fill = "#81d4fa"
            LET g.dataless_region_color = "#f8bbd0"
            LET g.default_color = "#f5f5f5"
            
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


PRIVATE FUNCTION init_parameters()
    INITIALIZE g.* TO NULL
    LET g.height = 275
    LET g.width = 275
END FUNCTION