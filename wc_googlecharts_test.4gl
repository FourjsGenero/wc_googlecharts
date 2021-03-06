MAIN
    OPTIONS FIELD ORDER FORM
    OPTIONS INPUT WRAP
    CLOSE WINDOW SCREEN
    CALL ui.Interface.loadStyles("wc_googlecharts_test")
    OPEN WINDOW googlechart_test WITH FORM "wc_googlecharts_test" ATTRIBUTES(TEXT="GoogleCharts Test")

    MENU ""
        BEFORE MENU
            #CALL googlecharts_pie_test()
            
        ON ACTION gauge ATTRIBUTES(TEXT="Gauge")
            CALL googlecharts_gauge_test()

        ON ACTION pie ATTRIBUTES(TEXT="Pie")
            CALL googlecharts_pie_test()

        ON ACTION line ATTRIBUTES(TEXT="Line")
            CALL googlecharts_line_test()

        ON ACTION column ATTRIBUTES(TEXT="Column")
            CALL googlecharts_column_test()
            
        ON ACTION geo ATTRIBUTES(TEXT="Geo")
            CALL googlecharts_geo_test()
            
        ON ACTION org ATTRIBUTES(TEXT="Organisation Chart")
            CALL googlecharts_org_test()
            
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN