MAIN
    OPTIONS FIELD ORDER FORM
    OPTIONS INPUT WRAP
    CALL ui.Interface.loadStyles("wc_googlecharts_test")
    MENU "Google Charts Test"
        BEFORE MENU
            CALL googlecharts_pie_test()
            
        ON ACTION gauge ATTRIBUTES(TEXT="Gauge")
            CALL googlecharts_gauge_test()

        ON ACTION pie ATTRIBUTES(TEXT="Pie")
            CALL googlecharts_pie_test()

        ON ACTION close
            EXIT MENU
    END MENU
END MAIN