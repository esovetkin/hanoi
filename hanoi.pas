program hanoy;
uses ptccrt, ptcgraph;
const p=10; pp=7; del=18; ll=9; kk=1; llc=14;
var gd,gm,MX,MY,ff: integer;
    rings: array [1..3,1..p] of integer;

procedure start_position;
var i:integer;
begin for i:=1 to p do begin rings[1,i]:=p-i+1; rings[2,i]:=0; rings[3,i]:=0 end
end;

procedure stergni(k,l:integer);
var i,j: integer;
begin SetFillStyle(ll,llc);
      for i:=1 to 3 do
      begin bar(i*MX div 4-pp*(4)-3, MY-25,i*MX div 4+pp*(4)+3,MY-20);
	    bar(i*MX div 4-3,MY-25,i*MX div 4+3,MY-30-p*20);
      end;
      for i:=1 to 3 do
      for j:=1 to p do
      begin SetFillStyle(kk,rings[i,j]+ff);
            if rings[i,j]<>0 then
            bar(i* MX div 4-pp*rings[i,j],MY-20*(j-1)-30,i*MX div 4+pp*rings[i,j],MY-20*j-25)
      end;
end;

procedure rtransp(k,l:integer);
var j,t,o,i,u,uu:integer;
begin if (l-k)<0 then o:=-1 else o:=1; j:=p; i:=p;
      while (rings[k,j]=0) and (j>=1) do dec(j);
      while (rings[l,i]=0) and (i>=1) do dec(i);
      for t:=1 to (p-j)*20+70 do
      begin SetFillStyle(1,0);
            bar(k*MX div 4-pp*rings[k,j],MY-20*(j-1)-30-t+1,k*MX div 4+pp*rings[k,j], MY-20*j-25-t+1);
            SetFillStyle(ll,llc);
      	    bar(k*MX div 4-3,MY-20*(j-1)-26,k*MX div 4+3,MY-30-p*20);
            SetFillStyle(kk,rings[k,j]+ff);
            bar(k*MX div 4-pp*rings[k,j],MY-20*(j-1)-30-t,k*MX div 4+pp*rings[k,j], MY-20*j-t-25);
            for u:=1 to 20000 do for uu:=1 to del do begin end;
      end;
      for t:=1 to (MX div 4)*abs(k-l) do
      begin SetFillStyle(1,0);
            bar(k*MX div 4-pp*rings[k,j]+o*(t-1),MY-20*p-80,k*MX div 4+pp*rings[k,j]+o*(t-1),MY-20*p-95);
            SetFillStyle(kk,rings[k,j]+ff);
            bar(k*MX div 4-pp*rings[k,j]+o*(t),MY-20*p-80,k*MX div 4+pp*rings[k,j]+o*(t),MY-20*p-95);
            for u:=1 to 20000 do for uu:=1 to del+2 do begin end;
      end;
      for t:=1 to (p-i-1)*20+70 do
      begin SetFillStyle(1,0);
            bar(l*MX div 4-pp*rings[k,j],MY-20*p-80+t-1,l*MX div 4+pp*rings[k,j],MY-20*p-95+t-1);
            bar(0,MY-20*p-80,MX,MY-20*p-95);
            SetFillStyle(ll,llc);
      	    bar(l*MX div 4-3,MY-20*i-26,l*MX div 4+3,MY-30-p*20);
            SetFillStyle(kk,rings[k,j]+ff);
            bar(l*MX div 4-pp*rings[k,j],MY-20*p-80+t,l*MX div 4+pp*rings[k,j],MY-20*p-95+t);
            for u:=1 to 20000 do for uu:=1 to del do begin end;
      end;
      rings[l,i+1]:=rings[k,j];
      rings[k,j]:=0;
end;

procedure towers(n:byte; A,C,B : char);
begin if n=1 then rtransp(ord(A) mod 64, ord(C) mod 64)
             else begin Towers(n-1, A,B,C);
                        rtransp(ord(A) mod 64, ord(C) mod 64);
                        Towers(n-1, B,C,A)
                  end
end;

begin clrscr;
      randomize; ff:=random(5);
      Gd := Detect;
      InitGraph(Gd, Gm, '');
      MX:=GetMaxX; MY:=GetMaxY;
      start_position; stergni(p,0); readkey;
      towers(p, 'A', 'C', 'B');
      repeat until keypressed;
      CloseGraph;
end.
