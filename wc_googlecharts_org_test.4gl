IMPORT FGL gc_org
IMPORT util

DEFINE g gc_org.org_rec

FUNCTION googlecharts_org_test()

DEFINE wc STRING
DEFINE data DYNAMIC ARRAY OF RECORD
    id STRING,
    parent_id STRING,
    tooltip STRING,
    text STRING
END RECORD

    CALL init_parameters()

    OPEN WINDOW org_test WITH FORM "wc_googlecharts_org_test"
    
    DIALOG ATTRIBUTES(UNBUFFERED)
        INPUT ARRAY data FROM data_scr.* ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT g.title
        FROM title
        ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
        END INPUT

        INPUT BY NAME g.allow_html, g.width, g.height ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        INPUT g.background_color.fill, g.background_color.stroke, g.background_color.stroke_width
        FROM background_color_fill, background_color_stroke, background_color_stroke_width
        ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
        END INPUT

        

        
        -- Web Component
        INPUT BY NAME wc ATTRIBUTES(WITHOUT DEFAULTS=TRUE) 
        END INPUT

        ON ACTION draw ATTRIBUTES(TEXT="Draw")
            LABEL lbl_draw:
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "id","parent_id","tooltip","text")
            LET g.data_row_count = data.getLength()
            CALL gc_org.draw("formonly.wc", g.*)

         ON ACTION example1 ATTRIBUTES(TEXT="Example 1")
            CALL init_parameters()
            CALL data.clear()

            LET g.allow_html = TRUE
            LET g.title = "Org Chart"

            LET g.data_col_count = 4
            LET g.data_column[1].label = "ID"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Manager"
            LET g.data_column[2].type = "string"
            LET g.data_column[3].label = "ToolTip"
            LET g.data_column[3].type = "string"
            LET g.data_column[4].label = "Name"
            LET g.data_column[4].type = "string"
            
            LET data[1].id = "Mike"     LET data[1].parent_id = NULL    LET data[1].text = 'Mike<div style="color:red; font-style:italic">President</div>'      LET data[1].tooltip = "The President"
            LET data[2].id = "Jim"      LET data[2].parent_id = "Mike"  LET data[2].text = 'Jim<div style="color:red; font-style:italic">Vice President</div>'  LET data[2].tooltip = "VP"
            LET data[3].id = "Alice"    LET data[3].parent_id = "Mike" 
            LET data[4].id = "Bob"      LET data[4].parent_id = "Jim"   LET data[4].tooltip = "Bob Sponge"
            LET data[5].id = "Carol"    LET data[5].parent_id = "Bob" 
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "id","parent_id","tooltip","text")
            LET g.data_row_count = data.getLength()
            
            CALL gc_org.draw("formonly.wc", g.*)

        ON ACTION example2  ATTRIBUTES(TEXT="Example 2")
            CALL init_parameters()
            CALL data.clear()

            LET g.allow_html = TRUE
            LET g.title = "Breeding Chart"

            LET g.data_col_count = 4
            LET g.data_column[1].label = "ID"
            LET g.data_column[1].type = "string"
            LET g.data_column[2].label = "Parent"
            LET g.data_column[2].type = "string"
            LET g.data_column[3].label = "ToolTip"
            LET g.data_column[3].type = "string"
            LET g.data_column[4].label = "Name"
            LET g.data_column[4].type = "string"
            
            LET data[1].id = "Four Jays"            LET data[1].parent_id = NULL 
            
            LET data[2].id = "Nuclear Canyon"       LET data[2].parent_id = "Four Jays" 
            LET data[3].id = "Deblo"                LET data[3].parent_id = "Four Jays"

            LET data[4].id = "No Nukes"             LET data[4].parent_id = "Nuclear Canyon"
            LET data[5].id = "Babylon"              LET data[5].parent_id = "Nuclear Canyon"
            LET data[6].id = "Wee Win"              LET data[6].parent_id = "Deblo"
            LET data[7].id = "Lisa Harrow"          LET data[7].parent_id = "Deblo"

            LET data[8].id = "Oil Burner"           LET data[8].parent_id = "No Nukes"
            LET data[9].id = "Gidget Lobell"        LET data[9].parent_id = "No Nukes"
            LET data[10].id = "Tarport Effrat"      LET data[10].parent_id = "Babylon"
            LET data[11].id = "Sterling Princess"   LET data[11].parent_id = "Babylon"
            LET data[12].id = "Out to Win"          LET data[12].parent_id = "Wee Win"
            LET data[13].id = "Foaming Lass"        LET data[13].parent_id = "Wee Win"
            LET data[14].id = "Lumber Dream"        LET data[14].parent_id = "Lisa Harrow"
            LET data[15].id = "First Actress"       LET data[15].parent_id = "Lisa Harrow"
            
            CALL map_array_to_data(base.TypeInfo.create(data), g.data, "id","parent_id","tooltip","text")
            LET g.data_row_count = data.getLength()
            
            CALL gc_org.draw("formonly.wc", g.*)
        
        ON ACTION close
            EXIT DIALOG

        ON ACTION cancel
            EXIT DIALOG
    END DIALOG
    CLOSE WINDOW pie_test
END FUNCTION



-- Take a 4gl array and map to data for passing to web component
-- Note: array is passed in via base.Typeinfo.create(array_name)
PRIVATE FUNCTION map_array_to_data(n, d, id_column, parent_id_column, tooltip_column, text_column)
DEFINE n om.DomNode
DEFINE d DYNAMIC ARRAY WITH DIMENSION 2 OF STRING
DEFINE id_column, parent_id_column, tooltip_column, text_column  STRING

DEFINE r om.DomNode
DEFINE i INTEGER

    CALL d.clear()
    FOR i = 1 TO n.getChildCount()
        LET r = n.getChildByIndex(i)

        LET d[i,1] = get_record_node(r,id_column)
        LET d[i,2] = get_record_node(r,parent_id_column)
        LET d[i,3] = get_record_node(r,tooltip_column)
        LET d[i,4] = get_record_node(r,text_column)
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

    LET g.height = 275
    LET g.width = 275
END FUNCTION