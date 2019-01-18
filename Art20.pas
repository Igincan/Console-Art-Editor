program Art20;
uses crt;
var ch:char;
    x,y,color,scolor:integer;
    picture:array [22..96,6..26] of integer;
    slot,slots:text;
    info1:array [1..8] of integer;
procedure Head;
  var i,j:integer;
  begin
    readkey;
    x:=22;
    y:=6;
    gotoxy(x,y);
    color:=8;
    textbackground(0);
    textcolor(15);
    for i:=22 to 96 do
      for j:=6 to 26 do picture[i,j]:=7;
    assign(slots,'saves/inf1.txt');
    reset(slots);
    for i:=1 to 8 do readln(slots,info1[i]);
    close(slots);
    scolor:=8;
  end;
procedure AssignSlot(s1:integer);
  begin
    case s1 of
      1:assign(slot,'saves/save1.txt');
      2:assign(slot,'saves/save2.txt');
      3:assign(slot,'saves/save3.txt');
      4:assign(slot,'saves/save4.txt');
      5:assign(slot,'saves/save5.txt');
      6:assign(slot,'saves/save6.txt');
      7:assign(slot,'saves/save7.txt');
      8:assign(slot,'saves/save8.txt');
    end;
  end;
procedure Load;
  var s,i,j:integer;
  begin
    s:=1;
    textbackground(black);
    gotoxy(101,9);
    write('-');
    repeat
      gotoxy(x,y);
      ch:=readkey;
      case ch of
        #72:s:=s-1;
        #80:s:=s+1;
        #13:begin
              AssignSlot(s);
              reset(slot);
              for i:=22 to 96 do
                for j:=6 to 26 do
                begin
                  readln(slot,picture[i,j]);
                  gotoxy(i,j);
                  textbackground(picture[i,j]);
                  write(' ');
                end;
              textbackground(black);
              close(slot);
            end;
        'd','D':begin
                  textcolor(8);
                  gotoxy(103,8+s);
                  write('Slot ',s,'.');
                  info1[s]:=0;
                  rewrite(slots);
                  for i:=1 to 8 do writeln(slots,info1[i]);
                  close(slots);
                  AssignSlot(s);
                  rewrite(slot);
                  for i:=22 to 96 do
                    for j:=6 to 26 do writeln(slot,'7');
                  close(slot);
                end;
      end;
      if s=0 then s:=1;
      if s=9 then s:=8;
      for i:=1 to 8 do
      begin
        gotoxy(101,8+i);
        if s=i then write('-')
               else write(' ');
      end;
    until (ch=#13) or (ch=#27);
    gotoxy(101,8+s);
    write(' ');
    ch:=#11;
  end;
procedure Save;
  var s,i,j:integer;
  begin
    s:=1;
    textbackground(black);
    gotoxy(101,9);
    write('*');
    repeat
      gotoxy(x,y);
      ch:=readkey;
      case ch of
        #72:s:=s-1;
        #80:s:=s+1;
        #13:begin
              AssignSlot(s);
              rewrite(slot);
              for i:=22 to 96 do
                for j:=6 to 26 do writeln(slot,picture[i,j]);
              close(slot);
              textcolor(blue);
              gotoxy(103,8+s);
              write('Slot ',s,'.');
              textcolor(8);
              info1[s]:=1;
              rewrite(slots);
              for i:=1 to 8 do writeln(slots,info1[i]);
              close(slots);
            end;
      end;
      if s=0 then s:=1;
      if s=9 then s:=8;
      for i:=1 to 8 do
      begin
        gotoxy(101,8+i);
        if s=i then write('*')
               else write(' ');
      end;
    until (ch=#27) or (ch=#13);
    gotoxy(101,8+s);
    write(' ');
    ch:=#11;
  end;
procedure Change_color;
  var i:integer;
  begin
    textbackground(8);
    textcolor(15);
    repeat
      ch:=readkey;
      case ch of
        #72:color:=color-1;
        #80:color:=color+1;
        #9:begin
             scolor:=color;
           end;

      end;
      if color=0 then color:=8;
      if color=9 then color:=1;
      for i:=1 to 8 do
      begin
        gotoxy(5,8+i);
        if color=i then write('*')
                   else write(' ');
        gotoxy(15,8+i);
        if scolor=i then write('*')
                    else write(' ');
      end;
      gotoxy(x,y);
    until (ch=#13) or (ch=#32);
    ch:=#13;
  end;
procedure Display;
  var i,j:integer;
  begin
    gotoxy(5,7);
    write('COLORS:');
    for i:=1 to 8 do
    begin
      gotoxy(7,8+i);
      textcolor(i);
      case i of
        1:write('BLUE');
        2:write('GREEN');
        3:write('CYAN');
        4:write('RED');
        5:write('MAGENTA');
        6:write('BROWN');
        7:write('WHITE');
        8:write('BLACK');
      end;
    end;
    gotoxy(5,16);
    textcolor(15);
    write('*');
    textbackground(white);
    for i:=22 to 96 do
  		for j:=6 to 26 do
  	  begin
  	    gotoxy(i,j);
  	    write(' ');
  	  end;
    textbackground(black);
    gotoxy(101,7);
    write('SAVES:');
    textcolor(8);
    for i:=1 to 8 do
    begin
      gotoxy(103,8+i);
      write('Slot ',i,'.');
      if info1[i]=1 then
      begin
        textcolor(blue);
        gotoxy(103,8+i);
        write('Slot ',i,'.');
        textcolor(8);
      end;
    end;
    gotoxy(8,28);
    write('Esc-End program  D-Delete picture  C-Change color  S-Save picture  L-Load picture("D" to delete slot)');
    gotoxy(15,16);
    textcolor(white);
    write('*');
    gotoxy(22,6);
  end;
procedure Drawing;
  var i,j:integer;
  begin
    ch:=readkey;
    case ch of
      #72:y:=y-1;
      #80:y:=y+1;
      #75:x:=x-1;
      #77:x:=x+1;
      'c','C':Change_color;
      's','S':Save;
      'd','D':begin
                for i:=22 to 96 do
                  for j:=6 to 26 do
                  begin
                    textbackground(7);
                    gotoxy(i,j);
                    write(' ');
                  end;
                for i:=22 to 96 do
                  for j:=6 to 26 do picture[i,j]:=7;
              end;
      'l','L':Load;
    end;
    if x=21 then x:=22;
    if x=97 then x:=96;
    if y=5 then y:=6;
    if y=27 then y:=26;
    gotoxy(x,y);
    if ch=#32 then
    begin
      textbackground(color);
      write(' ');
      picture[x,y]:=color;
    end;
    if ch=#9 then
    begin
      textbackground(scolor);
      write(' ');
      picture[x,y]:=scolor;
    end;
    gotoxy(x,y);
  end;
procedure Escape;
  begin
    gotoxy(45,3);
    textcolor(white);
    textbackground(black);
    write('Are you sure you want to exit?');
    gotoxy(45,4);
    write('          [ENTER]');
    ch:=readkey;
    gotoxy(45,3);
    clreol;
    gotoxy(45,4);
    clreol;
    gotoxy(x,y);
  end;
begin
  Head;
  Display;
  repeat
    repeat
    	Drawing;
    until ch=#27;
    Escape;
  until ch=#13;
end.