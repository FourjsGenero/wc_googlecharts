IMPORT FGL gc_pie
IMPORT util

DEFINE g gc_pie.pie_rec

FUNCTION googlecharts_pie_test()

DEFINE wc STRING
DEFINE data DYNAMIC ARRAY OF RECORD
    label STRING,
    value STRING,
    tooltip STRING,
    color STRING,
    offset FLOAT,
    text_style_color STRING, 
    text_style_font_name STRING,
    text_style_font_size INTEGER
END RECORD

    CALL init_parameters()

    OPEN WINDOW pie_test WITH FORM "wc_googlecharts_pie_test"
    
    DIALOG ATTRIBUTES(UNBUFFERED)
        INPUT ARRAY data FROM data_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.title, g.title_text_style.color, g.title_text_style.font_name, g.title_text_style.font_size, g.title_text_style.bold, g.title_text_style.italic
        FROM title, title_text_style_color, title_text_style_font_name, title_text_style_font_size, title_text_style_bold, title_text_style_italic

        ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.width, g.height, g.is3D, g.font_size, g.font_name ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
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

        INPUT g.pie_hole, g.pie_slice.border_color, g.pie_slice.text, 
              g.pie_slice.text_style.color, g.pie_slice.text_style.font_name, g.pie_slice.text_style.font_size,
              g.pie_start_angle, g.reverse_categories
        FROM pie_hole, pie_slice_border_color, pie_slice_text, 
             pie_slice_text_style_color, pie_slice_text_style_font_name, pie_slice_text_style_font_size,
             pie_start_angle, reverse_categories
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.slice_visibility_threshold, g.pie_residue_slice_color, g.pie_residue_slice_label
        FROM slice_visibility_threshold, pie_residue_slice_color, pie_residue_slice_label
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.tooltip.ignore_bounds, g.tooltip.is_html, g.tooltip.show_color_code, g.tooltip.text,
        g.tooltip.text_style.color, g.tooltip.text_style.font_name, g.tooltip.text_style.font_size, g.tooltip.text_style.bold, g.tooltip.text_style.italic, 
        g.tooltip.trigger
        FROM tooltip_ignore_bounds, tooltip_is_html, tooltip_show_color_code, tooltip_text,
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
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","tooltip")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)

         ON ACTION example1 ATTRIBUTES(TEXT="Example 1")
            CALL init_parameters()
            CALL data.clear()

            LET g.title = "My Daily Activities"

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Task"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Hours per Day"
            LET g.data_column[2].type = "number"
   

            LET data[1].label = "Work"       LET data[1].value = 11
            LET data[2].label = "Eat"        LET data[2].value = 2
            LET data[3].label = "Commute"    LET data[3].value = 2
            LET data[4].label = "Watch TV"   LET data[4].value = 2
            LET data[5].label = "Sleep"      LET data[5].value = 7            
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)

         ON ACTION example2 ATTRIBUTES(TEXT="Example 2")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Task"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Hours per Day"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = "Work"       LET data[1].value = 11
            LET data[2].label = "Eat"        LET data[2].value = 2
            LET data[3].label = "Commute"    LET data[3].value = 2
            LET data[4].label = "Watch TV"   LET data[4].value = 2
            LET data[5].label = "Sleep"      LET data[5].value = 7  

            LET g.title = "My Daily Activities"
            LET g.is3d = TRUE  
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)

         ON ACTION example3 ATTRIBUTES(TEXT="Example 3")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Task"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Hours per Day"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = "Work"       LET data[1].value = 11
            LET data[2].label = "Eat"        LET data[2].value = 2
            LET data[3].label = "Commute"    LET data[3].value = 2
            LET data[4].label = "Watch TV"   LET data[4].value = 2
            LET data[5].label = "Sleep"      LET data[5].value = 7  

            LET g.title = "My Daily Activities"
            LET g.pie_hole = 0.4
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)

        ON ACTION example4 ATTRIBUTES(TEXT="Example 4")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Language"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Speakers (in millions)"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = "German"     LET data[1].value = 5.85
            LET data[2].label = "French"     LET data[2].value = 1.66
            LET data[3].label = "Italian"    LET data[3].value = 0.316
            LET data[4].label = "Romansh"    LET data[4].value = 0.0791

            LET g.title = "Swiss Language Use"
            LET g.legend.position = "none"
            LET g.pie_slice.text = "label"
            LET g.pie_start_angle= 100
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)

        ON ACTION example5 ATTRIBUTES(TEXT="Example 5")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Language"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Speakers (in millions)"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = "Assamese"     LET data[1].value = 13
            LET data[2].label = "Bengali"     LET data[2].value = 83
            LET data[3].label = "Bodo"     LET data[3].value = 1.4
            LET data[4].label = "Dogri"     LET data[4].value = 2.3
            LET data[5].label = "Gujarati"     LET data[5].value = 46
            LET data[6].label = "Hindi"     LET data[6].value = 300
            LET data[7].label = "Kannada"     LET data[7].value = 38
            LET data[8].label = "Kashmiri"     LET data[8].value = 5.5
            LET data[9].label = "Konkani"     LET data[9].value = 5
            LET data[10].label = "Maithili"     LET data[10].value = 20
            LET data[11].label = "Malayalam"     LET data[11].value = 33
            LET data[12].label = "Manipuri"     LET data[12].value = 1.5
            LET data[13].label = "Marathi"     LET data[13].value = 72
            LET data[14].label = "Nepali"     LET data[14].value = 2.9
            LET data[15].label = "Oriya"     LET data[15].value = 33
            LET data[16].label = "Punjabi"     LET data[16].value = 29
            LET data[17].label = "Sanskrit"     LET data[17].value = 0.01
            LET data[18].label = "Santhali"     LET data[18].value = 6.5
            LET data[19].label = "Sindhi"     LET data[19].value = 2.5
            LET data[20].label = "Tamil"     LET data[20].value = 61
            LET data[21].label = "Telugu"     LET data[21].value = 74
            LET data[22].label = "Urdu"     LET data[21].value = 52
        
            LET data[5].offset = 0.2
            LET data[13].offset = 0.3
            LET data[15].offset = 0.4
            LET data[16].offset = 0.5
            
            LET g.title = "Indian Language Use"
            LET g.legend.position = "none"
            LET g.pie_slice.text = "label"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)       

        ON ACTION example6 ATTRIBUTES(TEXT="Example 6")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Pac Man"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Percentage"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = ""     LET data[1].value = 75
            LET data[2].label = ""     LET data[2].value = 25
            
            LET data[1].color = "yellow"
            LET data[2].color = "transparent"

            LET g.title = ""
            LET g.legend.position = "none"
            LET g.pie_slice.text = "none"
            LET g.pie_start_angle= 135
            LET g.tooltip.trigger = "none"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)      
   
        ON ACTION example7 ATTRIBUTES(TEXT="Example 7")
            CALL init_parameters()
            CALL data.clear()

            LET g.data_col_count = 2
            LET g.data_column[1].label = "Pizza"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Popularity"
            LET g.data_column[2].type = "number"
   
            LET data[1].label = "Pepperoni"     LET data[1].value = 33
            LET data[2].label = "Hawaiian"      LET data[2].value = 26
            LET data[3].label = "Mushroom"      LET data[3].value = 22
            LET data[4].label = "Sausage"       LET data[4].value = 10
            LET data[5].label = "Anchovies"     LET data[5].value = 9
            
            LET g.title = "Popularity of Types of Pizza"
            LET g.slice_visibility_threshold = 0.2
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "label","value","")
            LET g.data_row_count = data.getLength()
            CALL map_array_to_slice(base.TypeInfo.create(data), g.slices,"color","offset","text_style_color","text_style_font_name","text_style_font_size")
            CALL gc_pie.draw("formonly.wc", g.*)       
            
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW pie_test
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



-- Take a 4gl array and map to slices for passing to web component
-- Note: ar
PRIVATE FUNCTION map_array_to_slice(n, d, color_column,offset_column,text_style_color_column,text_style_font_name_column,text_style_font_size_column)
DEFINE n om.DomNode
DEFINE d DYNAMIC ARRAY OF sliceType
DEFINE color_column,offset_column,text_style_color_column,text_style_font_name_column,text_style_font_size_column STRING

DEFINE r om.DomNode
DEFINE i INTEGER

    CALL d.clear()
    FOR i = 1 TO n.getChildCount()
        LET r = n.getChildByIndex(i)
        LET d[i].color = get_record_node(r,color_column)
        LET d[i].offset = get_record_node(r,offset_column)
        LET d[i].text_style_color = get_record_node(r,text_style_color_column)
        LET d[i].text_style_font_name = get_record_node(r,text_style_font_name_column)
        LET d[i].text_style_font_size = get_record_node(r,text_style_font_size_column)
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



PRIVATE FUNCTION init_parameters()
    INITIALIZE g.* TO NULL
    LET g.chart_area.left = 50
    LET g.chart_area.top = 50
    LET g.chart_area.height = 200
    LET g.chart_area.width = 200
    LET g.height = 275
    LET g.width = 275

    -- remove if NULL colors array can be passed to web component
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