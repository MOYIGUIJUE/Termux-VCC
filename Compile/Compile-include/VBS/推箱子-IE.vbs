' Coding by 卵石之美, from VBS-Fans.
' 转载请注明原作者

Dim Game

Class CBox
    private m_X()
    private m_Y()
    private m_Img()
    private m_Count
    
    Public Property Get X(ByVal Count)
        X = m_X(Count)
    End Property
 
    Public Property Let X(ByVal Count,ByVal Value)
        m_X(Count) = Value
    End Property
    
    Public Property Get Y(ByVal Count)
        Y = m_Y(Count)
    End Property
 
    Public Property Let Y(ByVal Count,ByVal Value)
        m_Y(Count) = Value
    End Property
    
    Public Property Get Img(ByVal Count)
        Img = m_Img(Count)
    End Property
 
    Public Property Let Img(ByVal Count,ByVal Value)
        m_Img(Count) = Value
    End Property
    
    Public Property Get Count
        Count = m_Count
    End Property
    
    Public Function Inquiry(ByVal X,ByVal Y)
        If X <= 10 And Y <= 10 Then
            Dim ID
            For ID = 1 To m_Count
                If m_X(ID) = X And m_Y(ID) = Y Then
                    Inquiry = ID
                End If
            Next
        End If
    End Function
    
    Public Sub Add(ByVal X,ByVal Y,ByVal Img)
        If X <= 10 And Y <= 10 And Img <= 10 Then
            m_Count = m_Count + 1
            ReDim Preserve m_X(m_Count)
            ReDim Preserve m_Y(m_Count)
            ReDim Preserve m_Img(m_Count)
            m_X(m_Count) = X:m_Y(m_Count) = Y
            m_Img(m_Count) = Img
        End If
    End Sub
    
    Public Sub Init()
        m_Count = 0
        ReDim m_X(0)
        ReDim m_Y(0)
        ReDim m_Img(0)    
    End Sub
    
    Private Sub Class_Initialize()
        Call Init()
    End Sub
End Class

Class CData
    Private m_ImageData(10)
    Private m_GameWidth
    Private m_GameHeight
    Private m_Level
    Private m_MapData(10,10,15)
    Private m_PresentData(10,10)
    
    Public Property Get GameWidth
        GameWidth = m_GameWidth
    End Property
    
    Public Property Get GameHeight
        GameHeight = m_GameHeight
    End Property
    
    Public Property Get Level
        If m_Level Then level = m_Level
    End Property
    
    Public Property Let Level(ByVal NewData)
        m_Level = NewData
    End Property
    
    Public Function ImageData(ByVal Num)
        If Num And Num <= 10 Then 
            ImageData = "data:image/png;base64," & m_ImageData(Num)
        End If
    End Function
    
    Private Sub AddMap(ByVal Count,ByVal Text)
        Dim mArray
        mArray = Split(Text,",")
        Dim X,Y,I
        For Y = 1 To 10
            For X = 1 To 10 
                m_MapData(X,Y,Count) = mArray(I)
                I = I + 1
            Next
        Next
    End Sub 
    
    Public Function LoadMap(ByVal lLevel)
        Dim X,Y
        For Y = 1 To 10 
            For X = 1 To 10 
                With Game.Box
                    Temp = m_MapData(X,Y,lLevel)
                    m_PresentData(X,Y) = Temp
                    If Temp = 7 Then
                        .X(0) = X:.Y(0) = Y:.Img(0) = 7
                        m_PresentData(X,Y) = 1
                    ElseIf Temp = 4 Then
                        Call .Add(X,Y,Temp)
                        m_PresentData(X,Y) = 1
                    ElseIf Temp = 6 Then
                        Call .Add(X,Y,Temp)
                        m_PresentData(X,Y) = 5
                    End If
                End With
            Next
        Next
    End Function
    
    Public Function ReadMapData(ByVal X,ByVal Y)
        If X <= 10 And Y <= 10 Then
            ReadMapData = m_PresentData(X,Y)
        End If
    End Function
    
    Private Sub Class_Initialize()
        m_Level = 1
        m_GameWidth = 300
        m_GameHeight = 300
        m_ImageData(1) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAIAAAC0Ujn1AAAACXBIWXMAAAsTAAALEwEAmpwYAAABeElEQVRIibWVURqUMAyEZ5Kw3srbeC7PqUszPrDWWih00c0DXz6aTpufJPDb96+SSEoCcOJUfzI4MGdKlSIzmnNyy6z0+rNkKo0Pn90SAEjW58ihkQLJmeA/0i2+LJlF8fAOXzxcKdox60wp5WEXrH8v9UZju7O1LJmrzI3Nh+iBmJv5ENGIXiyOBV1wD2RzypoedqP4NrUhkC1g8P4Ni3pUm6OH77Nu/dkKqer4RDeOPv3IsgiAx1lnzrZM3fAqJKNmgNwYTyA2gQsgN259p9HbY8szS0kP87Du1v86VLOkUlmySl9apmqGZ9K+ONY3dAEczBBJ0muhwvLgXveS9V/SdZxuQv+/Zd5KXFJ5Zjz8JOZ+8W2/i+49ZorvomWa618A+YQdAAEAAXyvG7sA7IFIWH+sEpYvTnupXFaIUuszzRmLj4HotSRhPzFHgzdTWRKw+oc8AmKIxQSYc591e/3W8TASNDsDQtLCcFohOCoMc+uO/+BQ/QUtrIErFWiIZQAAAABJRU5ErkJggg=="
        m_ImageData(2) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAIAAAC0Ujn1AAAACXBIWXMAAAsTAAALEwEAmpwYAAAB0UlEQVRIibWV227CMAyGnVOLciqt1Jfc2+xp9lBIIBBN6SnZRaYsKgQCY/9FZbWpY39ObPT1+eGcQwg55wDgjhHszMUU8jQMQ9d1m82Gc575S67r/X4/DIMx5jnXCKHwTBlFUYzjyBjLWfzrOsZnjOm6rm3bFb6maZRSlNKbrC+XyzAMWmuMcZJ1+LCSDzyuUiwfEOe8KIokECGEECKVdYpeXdfb7RZjfA+IN3y58g9fzOHB4bPW3nz/lGjYKs5RSnmddWy/ckLefBsRQqnSp2SMAQAhxAMg+TkGuyzL/wJCCPFvHgN5Nuo/lREAjsfj+XxWSmmtV1H/qak657qum6bJGKOUigNPyVprraWUPnCNEKqqyhgjpczxCwAY43jlD2tr7TzPjDGIYEkp/d1ZbQlpxGvXzjnfN7TW7x9ghJCqqnKy9pqm6XQ6NU1zh9WLh48xVtc1RgjefmUAAGMMb5noL+gGEGutc45S+tRtXC2AayDzPO92u2VZ2rb1PSjnhIzjeDgcOOda6ySQZVmmaXLOzfMc2luQTyj0pqC+7/u+RwiFlnADSFmWTdNYa8PwjXOMw48NpRSlpCw394DE0+u66GG8rj4RQoSQq+3/sal+AwTepwMuM6wJAAAAAElFTkSuQmCC"
        m_ImageData(3) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAIAAAC0Ujn1AAAACXBIWXMAAAsTAAALEwEAmpwYAAAEq0lEQVRIiaVWWXLjRgwF0As37aqSPefJXXKVXDSVydiWREmkyN6AfLTF4Wj8F36wugACDbyHhfjXn38gAAACCHwe/ucjACACGgEUISIqIiJEAEDcbXfM3Lbt477Pp2mauq7PbRtDmMtJqd12l1I6nk4xsYhEFg0IRFgY9XCLIkIoAqwVAmCWZBcphqosWmGtaPoYABDBGIXAhVFGkQsxsmgAUISKaAohGyAiIk6S6TCXz1WESEQAQIRKEUTWiGi0pplra+1yuRQR732YJY6I2+3WGLPZbLquy9fnd1VVZVmKiHPOOQdIg4+akFar1XLRKKWyO2YexxERF4sFEVlrETGl5L0Xka7riGi1WllrtdZZklI6nU75+qZplDa34btOnNpL6914OByGYTifzxOyU6SLxeL9/d05N6dOa/36+joMQ9u2TyWijQEBDQA52L7v7/e7iDyYwXzuuk5rnUOeEBCREMIwDMMwTJLJynsvIHoeoDHmKTRANMYYY5AImH/VoDGGme/3+5Nca4Nj1AioSOWCraqKmefUKaXW67VSarfdXi+XeZEvFgtrrTEGAJ5MtLFtd9eIqLWOMb6/v+c767rebDa5ZUIIx+NxQnCz2Rhj+r7P6OV4iagsy9VqJSKXy8U5d+t6ZtYs7LzjpCawhmGw1oYQrtcrzPoCAJh5v9+fTqeU0lw1jmNRFCGEy+UiIolFMo0TRtPBOZdS+r1lvPcpJWZ+UolIjDHDgvg5jn66nqIGgLquY4x938/ZB4CmaTKr3vt51FrroiiUUrfbjR9sa63UZr0prJnuKMvCGFsURa65SU5ETdMAwOvray7TSVVVldZaa/3t27dxHH0I97ejTswhhLoq67r23h+Px/P5/EgZrTX7/d5ae71ez+fzx8dHzoOI6rre7XbM/Pb2lk2miqybBSJqEenvffDucDjcbrfcGg+I2Dl3uVx2u931eo0xThCnlLquWy6XXdc552fzCrz3PrQ/acyThX9tislLCPF3VaaOmQHkaYGICEzdiIhFUWR+Ji95fi4Wi6KwZVkOwzDxjIjW2qIoiGgYhnnNEFFV1b0LmpDKolyvlkoppdR+v89oAgAzi0gmc7VaZWJzVaSUcqMhYkZcKZVTBAAWyIBICGGaXrk5D4dDjPHj4yPGOKWZp2Bd16fTaV4hOYNs0rZtjDEmFmbNIokTzbDKFIUQwq8LUETatrXWdl33JB/HcRgG51w2ycPzi5YRkQz3XDJH/3cVIgJixmT6WCMgIc03Xl5gzOy9nwMCgLvdzhizXq9vt9s88KqqqrJka4dh8N4LMAJoIlqtV01V5W2Uech5bbfbDD0i8uMZx7Esy7IsM+0ikmIEgDzo1+s1IoaY+r//0YlTe279OB5eXoJzx+NxPtWIaL/fN01zPB7zCJ2mSlEULy8vIYS3t7f5bkLEqm4gY80iIYR73+cKnWfKzLfbTSk1LapJ5ZzLC2xe1JOJiGgASCwsQkT5l+FpYD7J5++smks+a4zzUBVgFh95cAFI5d+qOXUVqsF5JO3dOE9IG+NCBKSYRIQfZQaRedromBiST99/fMBXz/399KUcXLp2/36pCdEDyH/VXZi6zUD6sQAAAABJRU5ErkJggg=="
        m_ImageData(4) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEMklEQVRIibWWv48bVRDHP++tbc7e9drrtTlogNAgEImEkFLSBEGfFnoqEFSIf4CGnoI+EmX+gFAg0SBBEypoIqqQu13buUTeXXvfG4r1vtu9810cyE21O3pvvvPj+2ZGAVx/fTq89f6bvx5Ohm+jQCnFixQRAYFHy6f89PuDr/94cPSdeue1mE8/uvHU8zy/19FopXjBuAggAuuNwVjhzr37n6svb9/84NVZ+HNw0HWASqnKy0u+m//7nFdKYa3wNN/wMD2hcxgPf+h1PLQ+DVNrjR8E9LrdcykToXW20glaa6cz1uJpjTGGk5MTrLVbu4peR3MYDekAb9V3au+stRRFwXg0wvM8pxcRrIC3Ba6jsFIB1bpNadAKkiTBGNOKXmuFUoqOUora/36/T1EUiAhFnpMkCbPZ7LnJZq1lvpiTZZkD7fV6FEXhsDrNC74/IAgC0jQFIMsyjo+Pmc1maK1b9XKiAFFOZ61lnqYURb5NryYcjdFasV6v3bUWMCh83wcgTVOstQ58Op064y0HBKCqs7WWJEkoitzVPY5jei8dkGerFjHPAFcSBAEi4iJfrVYkScJkEqMaJGpKWRrSNCHP26C+77Mpzbnz54DrqA76A6LIslgsUEqRZRlpmjCJYzpeg+0Kyk3JYj6nKAqX3jiOCYJgp+2dwPW7BAjDEIDFYoGIkOc5i/mc6XSK1rpitTGkacragSpG47ErWTO9z0x1U8IwRGvNfD5HRFzap9MpUHFhsyWN1prxeEx/4D/L7MWpbv4HQYBSqsX2R0dHeFq7J6O1JooihsMhpbHOTtPe3qluSpPtZWnIsgxv+8SaRGoy/2yLvTTVu0Br3WAwoFhvWC4X6EZEURS1QJt3/lfEzVa6LgoXqYhgrGW1WuH7viPcf4r4IrHWkqYpeX5a001p0FqTb9vrdDrF87y97O0FXHekJpHiOMYYw3K53Mn25wY+m2ZjzE7Qmmxaa9L5HEXF9iRJGI0juh3vnL29a1xHulqt3MUomjhQpdS2JZY82c7dLMsQEWazWWuk1rYvBD49ZDlOUvI8dyCj8ZiBPzibI8JhiKc1i8UCGpFfNlJ3proabfMWaBRFBMMhIjvGolKEYYjneTtHatP2hcB1TfM8c81hMpm4iSXsHouXjdTRONpm8YJUN4l0tiPtK0EQsNmUPH68BKqRaoyh3++3zrWAm4uZUudH2z4bCEAwHKK1YrmswNfrNWVZnkm1yGOBUR0xVE/kotF2zoHGBtJ0qjnVrLVYa12pADoi/GiNfNaMvdvtYsrSedwEFHB9utKBIC2dteJW4E6n09q1rK2cVF/dvnnwyizMgoNua1++CqkX+n+SJ3+rd6/N+OTDG996Wn1TLfZXAyoCRWkxxnLn3v2ZArh+7WVuvffGweFkeFdp9fHVAAvGmO/v/vLnF7/99dD8CyiwsOZC0EdLAAAAAElFTkSuQmCC"
        m_ImageData(5) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjUlEQVRIia2XzXIbRRDHfzOzu5IibNlSLH/EclRFVSgeIHDjyhleIqekuFG8ABTFjQMHDpy5wSPAMQ8RSpZklDiH2LKk9X7MNIfdlUf+iijo007XbP+3/z3z714F8HRzc+PLvb2XvUbjYwClFP+niQgCnMQxv52efv3y7OyH4OnGBs/7/UnNmOZGGBJojVEKKV9ScOuzv75rj/+cO0fNGJ43Gt+LyEJ99+TJZx82m3/uN5sEZaZKKUTk3md/vc5+pRSZc/w9n/PXfE7QazR+3ogiQq2vAhqD6XQIo6h42adMBF3uVYATwTmHMWbpy6wlMAbJMpK3b8FaAEKt2Ygies4RKKU+qkCX2ViLnc95sLuLDoKlvwIJKhClcM6RO0fo+9KUUGviwQDJ85XsI61RShH4hyDY3MTO5+AcMpsRDwY86PehDLquibXEwyH5xUUBqjW6XscuFldYFT0AYatF1G4Tj0Yo58gvLliU4CoIwKvXdat8kufk4zFuNiv8xqB3dwm1xsXxEisA76QqRbi9DUA8HCIeeKPfh2sl8T9ARIpMBwPsbAYiKK1p9HrYZhOm0+W1WgJft6jdxjlHMh6DCNl0CoMBUa93J+0uTYmHw1XQoyPC7W1smt7Yv0K1n4VqtahZSzKZoID84gI3HFLv9QrafdAkIR2PlzVUxtDo9Yja7ZV9Sqk7qC4pq8Br3S4AyWSCOIebzUhPTjBHR6ggKE5qnpOMRkgFqjXh3t6yZP69fy/VvtW6XZQxXJ6cgHNk5+cwHNJ4/BgBLkcjiOMlaH1/HylB77M7qfbXUaeDUop4PC5O+3TK2atX1Iy5ujLGUN/fJ9rZIc2yq5J58dam2rew3S4yHI+ZJwl6OsWU4qKMoXF4SNhuL5XuupRWsVeovi9j3xdsbcHlJWoyoV5JrFLUDg6WoFW8/yXj6qvFWtRiQcMYEMGJMM8y1NkZ0fY2GPPvMl7HqtPrPBmcpinNIIDZjPj4mMbRESoM14q3FrDkeaG902kBWt3TLCN9/Xr1tB8drQ98X41dlt0KGm5vEwE6CAptB/LplHg4xBwcoKLoRry1ayzWEh8fF5IJoDX1R4+W4lBpe5Yk2NPTQttLTXb9/kpLrWK/v8bOsRiNsF5Nw91dTKt1Y2u0s4MzhmQyAZEi8/e01FupljwnuwZa298nfPgQd9s9V4pat1vQXomM11L92HdS7fKceDAoFKnsMvXDQ6JOBycC5fhTBfItbLdBqRstVR0cFIPfXVRLlt0ArVrbuha126RJgn3zZtlStbWEGxsr+1ao9gczStCV1rbGBAIQdjqEWnNZtlRZLMiS5AbV5wIt4GowM4bgjtbmr69PIJVPKLtaWXOxFqxdpVpEfk2sffaBpzi6VoM0vfpiP7gIuTfeSimd1vPlziHlWkcRtmybAKlziAjBOI6/CrV+tunN1i6OIY6xNwhd3/x3K2ZyES7SlJMkOVaftFq86Pe/jYz5ZrP8hVnnl8Rfr7PfiXCepiTW8uNgsKMAPt3a4otut37YaPyulPr8PyR6r1lrf/plPH7xx7t39h8YUMr9MWvoGQAAAABJRU5ErkJggg=="
        m_ImageData(6) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEaElEQVRIibWXv3MbRRTHP293TyfZEsF2fjgEJwqBgib8CamY/AW0pEyRhiYFFQwFFTMp6RigYphhho4ZOigpaSgYWzLgmCqJTpId6Xb3UZx0OklWokzCKzS6d7vft++779cJQHrz1vnm7Tu/ut32uwKICK9SVBUFwnGH/s/f3hv9/suXkt68xdadT1Rcgmk0EZuAMa/UMIB6TzzN0HzE428+uyc797/6oPbmO9+77ctgHVB4rKrP/F99Xme9iKA+xz86ZvzPn7hkt/2F2XgNcUkJaAUupkItscCMdtUIqoixVR5RjYhxpSoGj7EOH5V/TwNhctaC1RbJbhsnIlenRqenCwiDPPJ2s4Yzs1NrLH7EmpkXMRKDYtxMF8YedYaDfo6P896LqyEizI4JnKsZBl6JClkQ9rOcG68l2BeMNa/QzXKyXCcMCg0nDHItCZwzvJVadupw2PdEEbJcOeh73mq5wvPi7GdG/VTno9I9gcwXq40Il1PFJo6hV6YR4hYBdlKD4Oj2PUGV3jiWnhdk6lzATEVVCQr7E091YvTKpuWCCzwKzAXmkmGAnbpFY6Q7DCjQG0cOspx205y9YUJvp2LUirDXdFyoG2IeltYv4Uy92HJKvuE4OgkgQi9XOv1Au2lIF6j2qhz2Pb3KnbZbjp26XcJeSfU0LwF2NywIHA0DUZXMC4cnyvWW4qQAyhW6g0jPF/uNCFcasJ2aEq+KvdLjRdltWKzA38NAVHgyinTIud5KQJXuwJMFAbS80/N2mdpFWUl19flC3WJEOBx4IkJvrOw/GiKuNksZI1zZsFxqOGIeSpwq3tpUV2UnNYDjsO/xo1N6IhgtItwa4VrTFRkh8zhrU/2sHN1O4KnzPBwLJOnkHext2IlRWdrzUh6XpVRhoBYSO9FH4umQx3aTrbrFMdv7wh6vEq/QGQaySvSGYYapb5IFQ6dfBFyyZnldy7BX6PRzeuNZnl5rOfKN13l4okTmo32dbv7cO86j0un7mdFKIIHFGc/hwBdFZlysvZpC/WXuOGgB9GQUATACVyeBVAAV0Z7n8HAEcVLbDxVu1HSupU6xV3o8lQB0Ml/mqRHhjYawXVtgCLjYsIgTjsrars9tqWdS7aPSOWHO6JVNy6VUiglkschQVLjEyJktVSrYK6n2sThtNo5LXUZjZFVbhFlL7fR9Sft+ltOuF+9XUu2jcrDQ2totVxb8dWSnbhnnOUdPpWypXYVWTefWzRmuDmZGWGpt60wgUAyKWMvRsGipmYdhCPNUK/RQPTf1GIqU2Uv1zNb2rAmkqtttWJwIfw09ISqBSYTr1LDG7zQf3aXRLEFSIzxVw9HQMz/eKqCIVNueolERM9NpBBkXEZ4a4SRWUsqPUVVcOO5+ZPZqd6uz9WlQTgNAXKK0kLP67aJu9lwyEzzxtI8/7vwx/YT5XJLax6bRmhvsX6VoDMRh8Qnz5OtPtwQgfe8Wrfc/rLvL138Ukdv/i2Egz/MHgx8e3B/99lP4Dw/glzrCzT3IAAAAAElFTkSuQmCC"
        m_ImageData(7) = "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"
        m_ImageData(8) = "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"
        m_ImageData(9) = "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEAUlEQVRIiaWWX0xbVRjAf+fctrellJbMkGw4Apkh0YnbKhg0zpb9IfiysWh8mQ+YjJDFGNHo0yKUmMUHH2bcAyPRjD37MDQmEuNG2RJNFofMzRExjj+6qBOhwIbQ9t7jQ0cpbe9ti19y05zv3+9833fv6UEpRfbT29tLPtm/D3o6eTM+XnPRvNmgjB+fUD2d9IaCHM0bADm51x+HVUCmDJ9lz+FmxgUgBCA1kAKhNPq6iCgFSkH0Ohw8iSgmZ0FwKAitzYyLzHTC/fBXgNARrCEEHGiCb/pZOHSSyv8FDgVhZAC1CYoE6czYhA5qLb080Ehg+CxTbW9Qt2XwpXP8ILIbt15teh86mBlmAa3N1IaCHB0d4/OSwT0nQJPszTFIT9ZGPDkuQkBPJ0N287YER7q4mNcgsyvOBQO0NMILQfYAN4oGn3oNxBzt+cFlWWsdkGzqN6mqw0EGgX1Fgx2WfZD5K5ReMJdz1OHGPKOyA1tOJrvaAuDQ01ZYC7DlGyF9FvryvGq7k6SokystmgVYKyPfnO0kL9hUqTQ5rtlv9CZ4BRixTapEElylgI0kCEVMCAIbif3W0HV7Fvj0p3T0Ned3F0qpHGUkEuFUW5/f6WQjk2sXaF5rsDJh9Tbr7TZN0J7Jnx9sZnzodRajA3QIwSBCt4cCCAlaAIx5lIKe/oxulQK+MgYtXVy41E9U6tuiAmrtyYBjGyo5H+0doOX0+QKudsbRMfC+8/LM8eOv1C49mOUx/x3qKhYpdybSPklTMrXk5+dYNU1Vu5j+5U7440/eK7xHO6Nz/zF/4EjX+FcrDsyEj+hsDebaKspIbnbUNDSXh8txP8K3HWddw5nE1M23tgSWNY9TefDVmJBaau1yI102n1OGVJ74oHtu4N2PzNmJmZLB7rrdoDkQOX/IhUVoGu663YMrsxMtJYOFkAiZe4wUiQZk2M7DdsZW32BBMQ0KNcoSrJSibYfk8iIYD/mJ2BwOXwChbYSZyQTG/UWcgUfSurZqjc+Uim4JHJ/+ifcbvXgm4Iu7KV1yeYHk8gJS96BXPcrqnzOoRBwgDd7uhnPPefhn2BX5civg5MxtdnrlUM+TtF/922QhTup0UibCkbplCocTlYgjnHo6rq9BoEtY+vXW6JYqBvj66vVjh58Phqp/uzY6X9U0opVXhI3lGFJPXQg0vQzz3wdo3gpQCv/v4x0vHgmOj3w3xpVrea9axYHbOt4GGAV4KtQajT/7UnhxZ/1GsC+AwxegLHaXylvf8v35Dy84ztjyigNnSnWZFuHGEAlXGSv+Hay4/WE9uRb1LN/Dc/9esWlKBxuG0a5pWsQZX9nr+2ty+o/JydH6+vpuIUQ3QtQahhEtBfwfgIRR9LdWFJUAAAAASUVORK5CYII="
        m_ImageData(10) = "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"
        
        AddMap 1 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,3,3,3,2,2,2,2," & _
        "2,2,2,3,5,3,2,2,2,2," & _
        "2,2,2,3,1,3,3,3,3,2," & _
        "2,3,3,3,4,1,4,5,3,2," & _
        "2,3,5,1,4,7,3,3,3,2," & _
        "2,3,3,3,3,4,3,2,2,2," & _
        "2,2,2,2,3,5,3,2,2,2," & _
        "2,2,2,2,3,3,3,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 2 , _
        "3,3,3,3,3,2,2,2,2,2," & _
        "3,1,1,7,3,2,2,2,2,2," & _
        "3,1,4,4,3,2,3,3,3,2," & _
        "3,1,4,1,3,2,3,5,3,2," & _
        "3,3,3,1,3,3,3,5,3,2," & _
        "2,3,3,1,1,1,1,5,3,2," & _
        "2,3,1,1,1,3,1,1,3,2," & _
        "2,3,1,1,1,3,3,3,3,2," & _
        "2,3,3,3,3,3,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 3 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,3,3,3,3,2,2,2," & _
        "2,2,3,3,1,1,3,2,2,2," & _
        "2,2,3,1,7,4,3,2,2,2," & _
        "2,2,3,3,4,1,3,3,2,2," & _
        "2,2,3,3,1,4,1,3,2,2," & _
        "2,2,3,5,4,1,1,3,2,2," & _
        "2,2,3,5,5,6,5,3,2,2," & _
        "2,2,3,3,3,3,3,3,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 4 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,3,3,3,3,2,2,2,2," & _
        "2,2,3,7,1,3,3,3,2,2," & _
        "2,2,3,1,4,1,1,3,2,2," & _
        "2,3,3,3,1,3,1,3,3,2," & _
        "2,3,5,3,1,3,1,1,3,2," & _
        "2,3,5,4,1,1,3,1,3,2," & _
        "2,3,5,1,1,1,4,1,3,2," & _
        "2,3,3,3,3,3,3,3,3,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 5 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,3,3,3,3,3,3,2," & _
        "2,2,2,3,1,1,1,1,3,2," & _
        "2,3,3,3,4,4,4,1,3,2," & _
        "2,3,7,1,4,5,5,1,3,2," & _
        "2,3,1,4,5,5,5,3,3,2," & _
        "2,3,3,3,3,1,1,3,2,2," & _
        "2,2,2,2,3,3,3,3,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 6 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,3,3,3,3,3,2,2," & _
        "2,3,3,3,1,1,7,3,2,2," & _
        "2,3,1,1,4,5,1,3,3,2," & _
        "2,3,1,1,5,4,5,1,3,2," & _
        "2,3,3,3,1,6,4,1,3,2," & _
        "2,2,2,3,1,1,1,3,3,2," & _
        "2,2,2,3,3,3,3,3,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 7 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,3,3,3,3,2,2,2," & _
        "2,2,2,3,5,5,3,2,2,2," & _
        "2,2,3,3,1,5,3,3,2,2," & _
        "2,2,3,1,1,4,5,3,2,2," & _
        "2,3,3,1,4,1,1,3,3,2," & _
        "2,3,1,1,3,4,4,1,3,2," & _
        "2,3,1,1,1,1,1,1,3,2," & _
        "2,3,3,3,3,3,3,3,3,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 8 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,3,3,3,3,3,3,3,3,2," & _
        "2,3,1,1,3,1,1,1,3,2," & _
        "2,3,1,4,5,5,4,1,3,2," & _
        "2,3,7,4,5,6,1,3,3,2," & _
        "2,3,1,4,5,5,4,1,3,2," & _
        "2,3,1,1,3,1,1,1,3,2," & _
        "2,3,3,3,3,3,3,3,3,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 9 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "3,3,3,3,3,3,2,2,2,2," & _
        "3,1,1,1,1,3,2,2,2,2," & _
        "3,1,4,4,4,3,3,2,2,2," & _
        "3,1,1,3,5,5,3,3,3,2," & _
        "3,3,1,1,5,5,4,1,3,2," & _
        "2,3,1,1,1,1,1,1,3,2," & _
        "2,3,3,3,3,3,3,3,3,2," & _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 10 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,3,3,3,3,3,3,3,2,2," & _
        "2,3,5,5,4,5,5,3,2,2," & _
        "2,3,5,5,3,5,5,3,2,2," & _
        "2,3,1,4,4,4,1,3,2,2," & _
        "2,3,1,1,4,1,1,3,2,2," & _
        "2,3,1,4,4,4,1,3,2,2," & _
        "2,3,1,1,3,7,1,3,2,2," & _
        "2,3,3,3,3,3,3,3,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 11 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,3,3,3,3,3,2,2,2," & _
        "2,2,3,1,7,1,3,3,3,2," & _
        "2,3,3,1,3,4,1,1,3,2," & _
        "2,3,1,6,5,1,5,1,3,2," & _
        "2,3,1,1,4,4,1,3,3,2," & _
        "2,3,3,3,1,3,5,3,2,2," & _
        "2,2,2,3,1,1,1,3,2,2," & _
        "2,2,2,3,3,3,3,3,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 12 , _
        "2,2,3,3,3,3,3,3,2,2," & _
        "2,2,3,1,1,1,1,3,2,2," & _
        "2,2,3,1,4,1,7,3,2,2," & _
        "2,2,3,3,6,1,1,3,2,2," & _
        "2,2,3,1,6,1,3,3,2,2," & _
        "2,2,3,1,6,1,3,2,2,2," & _
        "2,2,3,1,6,1,3,2,2,2," & _
        "2,2,3,1,5,1,3,2,2,2," & _
        "2,2,3,3,3,3,3,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 13 , _
        "2,2,2,3,3,3,3,2,2,2," & _
        "2,2,2,3,2,2,3,2,2,2," & _
        "2,3,3,3,4,2,3,3,2,2," & _
        "2,3,2,2,6,2,7,3,2,2," & _
        "2,3,2,2,6,2,2,3,2,2," & _
        "2,3,2,2,6,2,3,3,2,2," & _
        "2,3,3,3,6,2,3,2,2,2," & _
        "2,2,2,3,5,3,3,2,2,2," & _
        "2,2,2,3,3,3,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 14 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "3,3,3,3,3,2,2,2,2,2," & _
        "3,1,1,1,3,3,3,3,3,2," & _
        "3,1,3,1,3,1,1,1,3,2," & _
        "3,1,4,1,1,1,4,1,3,2," & _
        "3,5,5,3,4,3,4,3,3,2," & _
        "3,5,7,4,1,1,1,3,2,2," & _
        "3,5,5,1,1,3,3,3,2,2," & _
        "3,3,3,3,3,3,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
        AddMap 15 , _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,3,3,3,3,3,3,2,2,2," & _
        "2,3,1,1,1,1,3,3,2,2," & _
        "3,3,5,3,3,4,1,3,2,2," & _
        "3,1,5,5,4,1,1,3,2,2," & _
        "3,1,1,3,4,1,1,3,2,2," & _
        "3,1,1,7,1,3,3,3,2,2," & _
        "3,3,3,3,3,3,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2," & _
        "2,2,2,2,2,2,2,2,2,2"
    End Sub
End Class

Class CView
    Private m_IE
    
    Public Function KeyCode()
        KeyCode = m_IE.document.parentwindow.event.keyCode
    End Function
    
    Public Sub MoveBox(ByVal ID,ByVal Image,ByVal X,ByVal Y)
        With m_IE.document.getElementById("Box" & ID)
            If Image Then .src = Game.Data.ImageData(Image)
            If X Then .style.left = X & "px"
            If Y Then .style.top = Y & "px"
        End With
    End Sub
    
    Public Function Load(ByVal Width,ByVal Height)
        If IsObject(m_IE) Then
            With m_IE
                .navigate "about:blank" '打开空白页面'
                .width = Width + 16
                .height = Height + 38
                .left = fix((.document.parentwindow.screen.availwidth-.width)/2)
                .top = fix((.document.parentwindow.screen.availheight-.height)/2)
                .visible = True '窗口可见'
                .document.onkeydown = getref("event_onkeydown")
            End With
            
            Call UpData()
            Load = True
        End If
    End Function
    
    Public Sub UpData()
        Dim m_HTML
        With Game.Data
            m_HTML = m_HTML & "<html>" 
            m_HTML = m_HTML & "<head>"
            m_HTML = m_HTML & " <title>Pushes the box - luanshizhimei</title>"
            m_HTML = m_HTML & " <style>"
            m_HTML = m_HTML & "  body,div{margin: 0px;padding: 0px;}"
            m_HTML = m_HTML & "  body{background: url('" & .ImageData(1) & "');}"
            m_HTML = m_HTML & "  #context{width: 300px;height: 300px;}"
            m_HTML = m_HTML & "  .Pixel{width: 30px;height: 30px;float: left;}"
            m_HTML = m_HTML & "  .Box{width: 30px;height: 30px;position: absolute;}"
            m_HTML = m_HTML & " </style>"
            m_HTML = m_HTML & "</head>"
            m_HTML = m_HTML & "<body>"
            m_HTML = m_HTML & "<div id=""context"">"            
            Dim X,Y,Temp
            For Y = 1 To 10 
                For X = 1 To 10
                    Temp = .ReadMapData(X,Y)
                    If Temp = 4  Or Temp = 7 Then
                        Temp = 1
                    ElseIf Temp = 6 Then
                        Temp = 5
                    End If
                    m_HTML = m_HTML & _
                    "<img id='P" & X & "_" & Y & "' class='Pixel'" & _
                    " src='" & .ImageData(Temp) & "'>"
                Next
            Next
        End With
        With Game.Box
            Dim I
            For I = 0 To .Count 
                m_HTML = m_HTML & _
                "<img id='Box" & I & "' class='Box'" & _
                " style='left: " & (.X(I) - 1) * 30 & "px;" & _
                "top: " & (.Y(I) - 1) * 30 & "px'" & _
                " src='" & Game.Data.ImageData(.img(I)) & "'>"
            Next
            m_HTML = m_HTML & "</div>"
            m_HTML = m_HTML & "</body>"
            m_HTML = m_HTML & "</html>"
            
            m_IE.Document.body.innerhtml = m_HTML
        End With
    End Sub
    
    Private Sub Class_Initialize()
        Set m_IE = wscript.createobject("internetexplorer.application","event_")
        With m_IE
            .menubar=0 '取消菜单栏'
            .addressbar=0 '取消地址栏'
            .toolbar=0 '取消工具栏'
            .statusbar=0 '取消状态栏'
        End With
    End Sub
    
    Private Sub Class_Terminate()
        If IsObject(m_IE) Then Set m_IE = Nothing
    End Sub
End Class

Public Sub event_onquit()
    Call Game.lEvent(0)
end Sub

Public Sub event_onkeydown(ByVal IE)
    'MsgBox IE.keycode
    Call Game.lEvent(1)
End sub

Class CGame
    Private m_View
    Private m_Data
    Private m_Box
    Private m_State
    
    Public Property Get State
        State = m_State
    End Property
    
    Public Property Get Data
        If IsObject(m_Data) Then Set Data = m_Data
    End Property
    
    Public Property Get Box
        If IsObject(m_Box) Then Set Box = m_Box
    End Property
    
    Public Sub lEvent(ByVal ID)
        Select Case ID
            Case 0
                Call Quit()
            Case 1
                Dim NewX,NewY,NewImg
                With m_Box
                    Select Case m_View.KeyCode
                        Case 65,37 'A
                            NewX = .X(0) - 1:NewY = .Y(0):NewImg = 10
                        Case 68,39 'D
                            NewX = .X(0) + 1:NewY = .Y(0):NewImg = 8
                        Case 87,38 'W
                            NewY = .Y(0) - 1:NewX = .X(0):NewImg = 9
                        Case 83,40 'S
                            NewY = .Y(0) + 1:NewX = .X(0):NewImg = 7
                    End Select
                    
                    If NewImg Then
                        Dim Temp 
                        Temp = m_Data.ReadMapData(NewX,NewY)
                        If Temp <> 3 Then
                            If .Inquiry(NewX,NewY) Then
                                Dim tX,tY,tID,ttID
                                tX = NewX+(NewX-.X(0))
                                tY = NewY+(NewY-.Y(0))
                                tPro = m_Data.ReadMapData(tX,tY)
                                tID = .Inquiry(NewX,NewY)
                                ttID = .Inquiry(tX,tY)
                                If tPro = 3 Or _
                                   .Img(ttID) = 4 Or .Img(ttID) = 6 Then
                                    Exit Sub
                                ElseIf tPro = 1 Or tPro = 4 Then
                                    m_View.MoveBox tID,4, _
                                    (tX - 1) * 30,(tY - 1) * 30
                                    .Img(tID) = 4
                                ElseIf tPro = 5 Then
                                    m_View.MoveBox tID,6, _
                                    (tX - 1) * 30,(tY - 1) * 30
                                    .Img(tID) = 6
                                    
                                End If
                                .X(tID) = tX:.Y(tID) = tY
                            End If
                            m_View.MoveBox 0,NewImg,(NewX - 1) * 30,(NewY - 1) * 30
                            .X(0) = NewX:.Y(0) = NewY
                        End If
                        
                        Dim lID,TempB
                        For lID = 1 To .Count
                            If .Img(lID) = 6 Then
                                TempB = TempB + 1
                            End If
                        Next
                        If TempB = .Count Then 
                            With m_Data
                                .Level = .Level + 1
                                If .Level = 16 Then
                                    MsgBox "恭喜你全部通关！"
                                    .Level = 1
                                End If
                                Call m_Box.Init()
                                Call .LoadMap(.Level)
                                Call m_View.UpData()
                            End With
                        End If
                    End If
                End With 
        End Select
    End Sub 
    
    Public Function Start()
        With m_Data
            Call .LoadMap(.Level)
            If m_View.Load(.GameWidth,.GameHeight) Then
                Start = True
            End If
        End With
    End Function
    
    Private Sub Quit()
        m_State = False
        wscript.Quit
    End Sub
    
    Private Sub Class_Initialize()
        m_State = True
        Set m_View = New CView
        Set m_Data = New CData
        Set m_Box = New CBox
    End Sub
    
    Private Sub Class_Terminate()
        Set m_View = Nothing
        Set m_Data = Nothing
        Set m_Box = Nothing
    End Sub
End Class

Private Sub Main()
    Set Game = New CGame
    With Game
        If .Start Then
            Do While .State
                WScript.Sleep 500
            Loop
        End If
    End With
    Set Game = Nothing
End Sub

Call Main()