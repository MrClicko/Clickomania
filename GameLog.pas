unit GameLog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Stein;

type
  PLogRec = ^TLogRec;
  TLogRec = record
    DeletedStones  : TList;
    MovedCols      : TList;
    MovedRows      : TList;
    Bonus          : Integer;
    end;
  TGameLog = class(TObject)
  private
    Owner  : TComponent;
    List   : TList;
    BState : Boolean;
    function getCount: Integer;
    function getBonus: Integer;
    function getBonusState: Boolean;
    //function getItem: TLogRec;
  protected
    function Get(Index: Integer): Pointer;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy;
    property Items[Index: Integer]: Pointer read Get; default;
  published
    procedure Add(AddRec: PLogRec);
    procedure Delete(Index: Integer);
    procedure Save;
    function Read: Boolean;
    property Count: Integer read getCount;
    property BonusPoints : Integer read getBonus;
    property BonusState  : Boolean read getBonusState;
  end;

const
   StoneKillBonus = 200;

implementation

uses Spielfeld, GameType;

constructor TGameLog.Create(AOwner: TComponent);
begin
Owner := AOwner;
List := TList.Create;
inherited Create;
end;

destructor TGameLog.Destroy;
var i,y    : Integer;
    LogRec : PLogRec;
    Stein  : TStein;
    CList  : TList;
begin
for i := List.Count -1 downto 0 do begin
   LogRec := (List[i]);
   CList := LogRec.DeletedStones;
   for y := CList.Count-1 downto 0 do begin
      Stein := CList[y];
      Stein.Free;
      end;
   CList.Free;
   CList := LogRec.MovedCols;
   CList.Free;
   CList := LogRec.MovedRows;
   CList.Free;
   end;
end;

function TGameLog.getCount;
begin
Result := List.Count;
end;

function TGameLog.getBonus;
var TotalBonus : Integer;
    i          : Integer;
    LogRec     : ^TLogRec;
begin
TotalBonus := 0;
for i := 0 to List.Count -1 do begin
   LogRec := (List[i]);
   Inc(TotalBonus, LogRec.Bonus);
   end;
Result := TotalBonus;
end;

function TGameLog.getBonusState;
begin
result := BState;
end;

procedure TGameLog.Add(AddRec: PLogRec);
begin
List.Add(AddRec);
BState := (AddRec.Bonus > 0);
//BState := true;
end;

function TGameLog.get(Index: Integer) : Pointer;
begin
Result := List[Index];
end;

procedure TGameLog.Delete(Index: Integer);
begin
List.Delete(Index);
end;

// Speichern und laden funktioniert (noch?) nicht: Es fehlt die Save/Load-Funktion des Spielfelds

procedure TGameLog.Save;
var i,y : Integer;
    FS : TFileStream;
    LogRec : PLogRec;
    Stein  : TStein;
    CList  : TList;
    MR     : PMoveRec;
    tInt   : Integer;
    Sp     : Tspielfeld;
begin
FS := TFileStream.Create('current.log', fmCreate);
Sp := TSpielfeld(Owner);
tInt := Sp.ControlCount-1;
FS.Write(tInt, SizeOf(tInt));
for y := 0 to tInt-1 do begin
   Stein := Sp.Controls[y] as TStein;
   if not (Stein = nil) then Stein.Save(FS);
   end;
FS.Write(List.Count, SizeOf(List.Count));
for i := 0 to List.Count -1 do begin
   LogRec := (List[i]);
   CList := LogRec.DeletedStones;
   FS.Write(CList.Count, SizeOf(CList.Count));
   for y := 0 to CList.Count-1 do begin
      Stein := CList[y];
      if not (Stein = nil) then Stein.Save(FS);
      end;
   CList := LogRec.MovedCols;
   FS.Write(CList.Count, SizeOf(CList.Count));
   for y := 0 to CList.Count-1 do begin
      MR := CList[y];
      tInt := MR.Stein.Nummer;
      FS.Write(tInt, SizeOf(tInt));
      FS.Write(Mr.Offset, SizeOf(Mr.Offset));
      FS.Write(MR.Direction, SizeOf(Mr.Direction));
      end;
   CList := LogRec.MovedRows;
   FS.Write(CList.Count, SizeOf(CList.Count));
   for y := 0 to CList.Count-1 do begin
      MR := CList[y];
      tInt := MR.Stein.Nummer;
      FS.Write(tInt, SizeOf(tInt));
      FS.Write(Mr.Offset, SizeOf(Mr.Offset));
      FS.Write(MR.Direction, SizeOf(Mr.Direction));
      end;
   end;
FS.Free;
end;

function TGameLog.Read: Boolean;
var i,y,z  : Integer;
    FS     : TFileStream;
    LogRec : PLogRec;
    Stein  : TStein;
    CList  : TList;
    MR     : PMoveRec;
    tInt,
    tInt2  : Integer;
    TA     : TActionInfo;
begin
Result := false;
if not FileExists('current.log') then Exit;
try
FS := TFileStream.Create('current.log', fmOpenRead);
FS.Read(tInt, SizeOf(tInt));
if tInt <= 0 then begin
   Exit;
   end;
Ta.Activate := false;
Ta.TypeList := [];
TA.Frequ    := 14;
for y := 0 to tInt-1 do begin
   Stein := TStein.Create(nil,nil,TA);
   Stein.Read(FS);
   end;
FS.Read(tInt, SizeOf(tInt));
for i := 0 to tInt -1 do begin
   New(LogRec);
   FS.Read(tInt, SizeOf(tInt));
   for y := 0 to tInt-1 do begin
      Stein.Read(FS);
      LogRec.DeletedStones.Add(Stein);
      end;
   FS.Read(tInt, SizeOf(tInt));
   for y := 0 to tInt-1 do begin
      tInt2 := FS.Write(tInt2, SizeOf(tInt));
      for z := 0 to LogRec.DeletedStones.Count-1 do begin
         Stein := TStein(LogRec.DeletedStones[z]);
         if Stein.Nummer = tInt2 then begin
            Mr.Stein := Stein;
            end;
        end;
      FS.Read(Mr.Offset, SizeOf(Mr.Offset));
      FS.Read(MR.Direction, SizeOf(Mr.Direction));
      LogRec.MovedRows.Add(Stein);
      end;
   FS.Read(tInt, SizeOf(tInt));
   for y := 0 to CList.Count-1 do begin
      tInt2 := FS.Write(tInt2, SizeOf(tInt));
      for z := 0 to LogRec.DeletedStones.Count-1 do begin
         Stein := TStein(LogRec.DeletedStones[z]);
         if Stein.Nummer = tInt2 then begin
            Mr.Stein := Stein;
            end;
        end;
      FS.Read(Mr.Offset, SizeOf(Mr.Offset));
      FS.Read(MR.Direction, SizeOf(Mr.Direction));
      LogRec.MovedCols.Add(Stein);
      end;
   end;
Result := true;
finally
FS.Free;
end;
end;

end.
