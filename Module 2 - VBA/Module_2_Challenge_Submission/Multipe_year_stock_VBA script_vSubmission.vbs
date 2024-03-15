Sub fortickerloop_all_sheets()
    Dim ws As Worksheet
    Dim i, tickerrow As Long
    Dim firstOpening, lastClosing, yrchg, totalvol As Double
    Dim dateyear, year_start, year_end As Date
    Dim pc1 As String
    Dim lastRow As Long
    Dim maxIncrease As Double
    Dim maxDecrease As Double
    Dim maxVolume As Double
    Dim stockMaxIncrease As String
    Dim stockMaxDecrease As String
    Dim stockMaxVolume As String
    
    ' Loop through each worksheet in the workbook
    For Each ws In ThisWorkbook.Worksheets
        ws.Activate ' Activate the current worksheet
        ' Reset variables for each sheet
        tickerrow = 2
        totalvol = 0
        yrchg = 0
        maxIncrease = 0
        maxDecrease = 0
        maxVolume = 0
        year_start = 0

        firstOpening = Cells(2, 3).Value
        lastClosing = Cells(2, 6).Value
        year_start = Cells(2, 2).Value
        pc1 = FormatPercent(Cells(2, 11), 2)
        
        'Label cell I1 Ticker
        Cells(1, 9).Value = "Ticker"
        'Label cell J1 Yearly Change
        Cells(1, 10).Value = "Yearly Change"
        'Label cell K1 Percent Change
        Cells(1, 11).Value = "Percent Change"
        'Label cell L1 Total Stock Volume
        Cells(1, 12).Value = "Total Stock Volume"
        'Label cell Greatest %, Total, Tickers
        Cells(2, 14).Value = "Greatest % increase"
        Cells(3, 14).Value = "Greatest % decrease"
        Cells(4, 14).Value = "Greatest Total Volume"
        Cells(1, 15).Value = "Ticker"
        Cells(1, 16).Value = "Value"

        ' Loop through rows in the column
        For i = 2 To Cells(Rows.Count, 1).End(xlUp).Row
            'Calculation for total volume
            totalvol = totalvol + Cells(i, 7).Value
            'Searches for when the value of the next cell is different than that of the current cell
                If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
                    'In Column I, place the unique values from Column A
                    Cells(tickerrow, 9).Value = Cells(i, 1).Value
                    If year_start < 0 Then
                        'Find earliest date + input Opening Price into calculation
                        firstOpening = Cells(i, 3).Value
                    End If
                    If year_start > 0 Then
                        'Find latest date + input Closing Price into calculation
                        lastClosing = Cells(i, 6).Value
                    End If
                    If firstOpening >= 0 And lastClosing >= 0 Then
                        'Calculation for yearly change
                        yrchg = lastClosing - firstOpening
                        'In Column J, place the yearly change value
                        Cells(tickerrow, 10).Value = yrchg
                        'Calculation for percentage change
                        pc1 = yrchg / firstOpening
                        lastClosing = i + 1
                    End If
                    'In Column K, place percentchange
                    Cells(tickerrow, 11).Value = pc1
                    'In Column L, place the total stock volume from Column G
                    Cells(tickerrow, 12).Value = totalvol
                    
                    If Cells(tickerrow, 10).Value < 0 Then Cells(tickerrow, 10).Interior.ColorIndex = 3
                    If Cells(tickerrow, 10).Value > 0 Then Cells(tickerrow, 10).Interior.ColorIndex = 4
                    
                    ' Percentage Increase
                    If Cells(i, 11).Value > maxIncrease Then
                        maxIncrease = Cells(i, 11).Value
                        stockMaxIncrease = Cells(i, 9).Value ' Stock name corresponding to max increase
                        Cells(2, 16).Value = maxIncrease
                        Cells(2, 15).Value = stockMaxIncrease
                    End If
            
                    ' Percentage Decrease
                    If Cells(i, 11).Value < maxDecrease Then
                        maxDecrease = Cells(i, 11).Value
                        stockMaxDecrease = Cells(i, 9).Value ' Stock name corresponding to max decrease
                        Cells(3, 16).Value = maxDecrease
                        Cells(3, 15).Value = stockMaxDecrease
                    End If
            
                    ' Total Volume
                    If Cells(i, 12).Value > maxVolume Then
                        maxVolume = Cells(i, 12).Value
                        stockMaxVolume = Cells(i, 9).Value ' Stock name corresponding to max volume
                        Cells(4, 16).Value = maxVolume
                        Cells(4, 15).Value = stockMaxVolume
                    End If
                    totalvol = 0
                    tickerrow = tickerrow + 1
                End If
        Next i
    Next ws
    
End Sub

