' 
' Only supports the Military Hourly format 24 hours for now. It speaks the time when called.
'
' This program is free software; you can redistribute it and/or modify it
' under the terms of the GNU General Public License as published by the
' Free Software Foundation; either version 3 of the License, or ( at
' your option ) any later version.
'
' This program is distributed in the hope that it will be useful, but
' WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' General Public License for more details.
'
' You should have received a copy of the GNU General Public License
' along with this program.  If not, see <http://www.gnu.org/licenses/>.
' 
' 
' 
' 

Dim speaks
Dim speech

Dim currentTime
Dim currentHour
Dim currentMinute

Set speech    = CreateObject("sapi.spvoice")
currentTime   = Now()
currentHour   = hour( currentTime )
currentMinute = Minute( currentTime )

If currentHour < 12 Then
    dayPeriod = "AM"
Else
    dayPeriod   = "PM"
End If

If currentHour > 12 Then
    currentHour = currentHour - 12
End If

If currentMinute = 0 Then
    speaks = "The time is now, " & currentHour & " hours " & dayPeriod
Else
    speaks = "The time is now, " & currentHour & " hours and "
    speaks = speaks & currentMinute & " minutes " & dayPeriod
End If

speech.Speak speaks

