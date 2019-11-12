/*
 * ComboBox Sample n� 11
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use an array to set the
 * combo's ITEMSOURCE clause.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   LOCAL oWnd, oCombo1, oCombo2, oValue1, oItem1, oValue2, oItem2

   OpenTables()

   DEFINE WINDOW MAIN OBJ oWnd ;
      TITLE "OOHG - set ITEMSOURCE using an array" ;
      WIDTH 400 ;
      HEIGHT 400 ;
      ON RELEASE CloseTables()

      @ 10,10 COMBOBOX Combo1 OBJ oCombo1 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 'Test', 'Name', 'tName' } ) ;
         VALUESOURCE 'test->Code' ;
         ON CHANGE ( oValue1:value := "Value (code) is: " + ;
                                      AutoType(oCombo1:Value), ;
                     oItem1:value := "Item (name) is: " + ;
                                     oCombo1:ItemBySource(oCombo1:Value) )
/*
 * You can replace ItemBySource(oCombo1:Value) with
 * Item(ASCAN(oCombo1:aValues, oCombo1:Value)).
 */

      @ 13,220 LABEL Dummy1 VALUE "WITH VALUESOURCE" AUTOSIZE

      @ 60,10 LABEL Label11 OBJ oValue1 ;
         VALUE "Select an item to see it's value (code)" ;
         AUTOSIZE

      @ 80,10 LABEL Label12 OBJ oItem1 ;
         VALUE "Select an item to see it's caption (name)" ;
         AUTOSIZE

      @ 210,10 COMBOBOX Combo2 OBJ oCombo2 ;
         WIDTH 200 ;
         DISPLAYEDIT ;
         ITEMSOURCE ( { 'Test', 'Name', 'tName' } ) ;
         ON CHANGE ( oValue2:value := "Value (recno) is: " + ;
                                      AutoType(oCombo2:Value), ;
                     oItem2:value := "Item (name) is: " + ;
                                     oCombo2:ItemBySource(oCombo2:Value) )
/*
 * You can replace ItemBySource(oCombo2:Value) with
 * Item(oCombo2:Value).
 */

      @ 213,220 LABEL Dummy2 VALUE "WITHOUT" AUTOSIZE

      @ 260,10 LABEL Label21 OBJ oValue2 ;
         VALUE "Select an item to see it's value (recno)" ;
         AUTOSIZE

      @ 280,10 LABEL Label22 OBJ oItem2 ;
         VALUE "Select an item to see it's caption (name)" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION oWnd:Release()
   END WINDOW

   CENTER WINDOW MAIN
   ACTIVATE WINDOW MAIN

RETURN NIL

FUNCTION OpenTables()

   LOCAL aDbf[ 2, 4 ], i

   aDbf[1] := { "Code", "N", 3, 0 }
   aDbf[2] := { "Name", "C", 25, 0 }

   REQUEST DBFCDX

   dbCreate( "Test", aDbf )

   USE test VIA "DBFCDX"

   FOR i := 1 TO 50
      APPEND BLANK
      REPLACE Code WITH i * 3
      REPLACE Name WITH Replicate( Chr( hb_RandomInt( 97, 122  ) ), 9 ) + " code=" + Str( Code, 3, 0 ) + " rec=" + Str( RecNo(), 2, 0 )
   NEXT i

   INDEX ON Name TAG tName TO Test
   INDEX ON Code TAG tCode TO Test

RETURN NIL

FUNCTION CloseTables()

   CLOSE DATABASES
   ERASE Test.dbf
   ERASE Test.cdx

RETURN NIL

/*
 * EOF
 */
