unit Stein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, extctrls,
  GameType;

type
  TActionSet = record
     IsAction : Boolean;
     ActType  : TActionType;
     FaceNr   : Integer;
     end;
  TNoMovePossibleEvent  = procedure(Sender : TObject) of object;
  TMoveDoneEvent        = procedure(Sender : TObject) of object;
  TStein = class(TGraphicControl)
  private
     Farbe    : TColor;
     FaceOrig,
     Face     : TBitmap;
     MyIType  : Integer;
     MyNr     : Integer;
     Nachbar  : array[0..3] of TStein;
     iDT      : TDrawType;
     ActionSet: TActionSet;
     FOnNoMovePossible  : TNoMovePossibleEvent;
     FOnMoveDone        : TMoveDoneEvent;
     function getType  : Integer;
     function getColor : TColor;
     function getNr    : Integer;
     procedure setNr(Nr: Integer);
     procedure setDrawType(dt : TDrawType);
     function getAction: TActionSet;
     procedure setAction(ActSet : TActionSet);
     function CountUniNbs: Integer;
     procedure NoMovePossible; virtual;
     procedure OnMoveIsDone; virtual;
  protected
    procedure Paint; override;
    //procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    procedure PlayMe;
    procedure setNb(Nbs: Array of TStein);
    procedure BuildUpDeadList(List: TList);
    procedure ProcActionStones(Stein : TStein; List, ActList: TList);
    procedure BUDLBomb(List: TList);
    procedure BUDLRocketHoriz(List: TList);
    procedure BUDLRocketVert(List: TList);
    procedure BUDLRock(List: TList);
    procedure BUDLQuake(List: TList);
    procedure Fade(FadeIn: Boolean; FrameNr: Integer);
    procedure Animate(Restore: Boolean; Bmp: TBitmap);
    constructor Create(AOwner: TComponent; List: TImageList; ActionInfo: TActionInfo);virtual;
    destructor Destroy; override;
  published
    procedure Save(FS: TFileStream);
    procedure Read(FS: TFileStream);
    property OnClick;
    property Color  : TColor read getColor;
    property MyType : Integer read getType;
    property Nummer : Integer read getNr write setNr;
    property UniNeighbours : Integer read CountUniNbs;
    property DrawType   : TDrawType write setDrawType;
    property ActionType : TActionSet read getAction write setAction;
    property OnNoMovePossible : TNoMovePossibleEvent read FOnNoMovePossible write FOnNoMovePossible;
    property OnMoveDone       : TMoveDoneEvent       read FOnMovedone       write FOnMoveDone;
  //protected
  end;

{Dieser Stein ist eine eigene Komponente, die auch über die Komponenten-Palette
installiert werden könnte, wenn sie im Package installiert ist.
Für das Spiel muss ich sie natürlich dynamisch zu Laufzeit erzeugen.}

procedure Register;

implementation

uses Spielfeld;

var Sf : TSpielfeld;

constructor TStein.Create(AOwner: TComponent; List: TImageList; ActionInfo: TActionInfo);
var Act   : INteger;
    {Elemente im Set TActionType zählen}
    function CountActionStones: Integer;
    var i : TActionType;
    begin
    Result := 0;
    for I := Low(TActionType) to High(TActionType) do
       if (I in ActionInfo.TypeList) then Inc(Result);
    end;
    {Das gewünschte Element in Set TActionType zurückliefern}
    function ActionElement(ElementNr : Integer): TActionType;
    var i : TActionType;
        ii: Integer;
    begin
    ii := 0;
    Result := Low(TActionType);
    for i := Low(TActionType) to High(TActionType) do
    if (I in ActionInfo.TypeList) then begin
       if ii = ElementNr then Result := i;
       inc(ii);
       end;
    end;
begin
inherited create(AOwner);
FaceOrig := TBitmap.Create;
Face     := TBitmap.Create;
Sf := TSpielfeld(AOwner);
Self.Width := Sf.Steinbreite;
Self.Height := Sf.Steinhoehe;
MyIType := Random(Sf.NrOfColors);
if ActionInfo.Activate then begin
   if Random(ActionInfo.Frequ) = 1 then begin
        ActionSet.IsAction := true;
        Act := Random(CountActionStones);
        //ActionSet.FaceNr  := Sf.NrOfColors+Act;
        MyIType := Sf.NrOfColors+Act;
        ActionSet.ActType := ActionElement(Act);
      end;
   end;
{if not ActionSet.IsAction
   then List.GetBitmap(MyIType,FaceOrig)
   else List.GetBitmap(ActionSet.FaceNr, FaceOrig);}
List.GetBitmap(MyIType,FaceOrig);
faceOrig.Transparent := True;
faceOrig.TransparentColor := clFuchsia;
Face.Assign(FaceOrig);
end;

destructor TStein.Destroy;
begin
try
inherited;
Face.Free;
FaceOrig.Free;
except; end;
end;

procedure TStein.Save(FS: TFileStream);
begin
FS.Write(MyIType, SizeOf(MyIType));
FS.Write(MyNr, SizeOf(MyIType));
FS.Write(Farbe, SizeOf(Farbe));
FaceOrig.SaveToStream(FS);
Face.SaveToStream(FS);
FS.Write(ActionSet, SizeOf(ActionSet));
end;

procedure TStein.Read(FS: TFileStream);
begin
//Self.Create(nil, nil, TA);
FS.Read(MyIType, SizeOf(MyIType));
FS.Read(MyNr, SizeOf(MyIType));
FS.Read(Farbe, SizeOf(Farbe));
FaceOrig.LoadFromStream(FS);
Face.LoadFromStream(FS);
FS.Read(ActionSet, SizeOf(ActionSet));
end;

procedure Register;
begin
registerComponents('Matthias', [TStein]);
end;

function TStein.getColor;
begin
Result := Farbe;
end;

function TStein.getType;
begin
Result := myIType;
end;

function TStein.getNr;
begin
Result := MyNr;
end;

procedure TStein.setNr(Nr: Integer);
begin
MyNr := Nr;
end;

procedure TStein.setDrawType(dt : TDrawType);
begin
iDT := dt;
end;

function TStein.getAction: TActionSet;
begin
Result := ActionSet;
end;

procedure TStein.setAction(ActSet : TActionSet);
begin
ActionSet := ActSet;
end;

procedure TStein.setNb(Nbs: Array of TStein);
var i : Integer;
begin
for i := 0 to 3 do
   Nachbar[i] := Nbs[i];
end;

procedure TStein.NoMovePossible;
begin
if Assigned(FOnNoMovePossible) then FOnNoMovePossible(Self);
end;

procedure TStein.OnMoveIsDone;
begin
if Assigned(FOnMovedone) then FOnMovedone(Self);
end;

procedure TStein.Paint;
begin
//inherited Paint;
if (iDT = dtHideBack) and not sf.Creating then begin
   self.Canvas.Brush.Color := sf.BgColor;
   self.Canvas.FillRect(Rect(0,0,self.Width, self.Height));
   end;
Self.Canvas.Draw(0,0, Face);
//Self.Canvas.Brush.Style := bsClear;
//Self.Canvas.TextOut(8,8, Copy(Self.Name,6,100));
//Self.Canvas.TextOut(8,8, IntToStr(Self.Nummer));
//SetBkMode(Self.Canvas.handle, TRANSPARENT);
//SetBkColor(Self.Canvas.handle, 0);
//BitBlt(Self.Canvas.handle, 1, 1, Self.Width, Self.Height, Face.Canvas.Handle, 0,0,SRCCOPY);
end;

procedure TStein.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Hier wäre eine Überprüfung möglich, ob der Stein getroffen wurde.
  //if not PtInRegion(FKRgn,Message.xPos,Message.yPos) then exit;
  //inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then begin
     if sf.MoveInProgress then begin
        sf.AddActionToRecordList(self);
        exit;
        end;
     PlayMe;
     end;
end;

procedure TStein.PlayMe;
var CanPlay : Boolean;
begin
CanPlay := ((CountUniNbs > 0) or (ActionSet.IsAction) and not (ActionSet.ActType = atRock));
If not CanPlay then FOnNoMovePossible(Self)
else begin
   Sf.CallerStone := Self;
   Sf.DeleteList := TList.Create;
   Sf.MoveList   := TList.Create;
   Sf.ColumnList := TList.Create;
   Sf.ActionLists.Clear;
   //Sf.ActionList := TList.Create;
   BuildUpDeadList(Sf.DeleteList);
   //Sf.ProcMove(ActionSet.ActType = atEarthQuake);
   Sf.ProcMove(false);
   FOnMovedone(Self);
   end;
end;

function TStein.CountUniNbs: Integer;
var i : Integer;
begin
Result := 0;
if ActionSet.IsAction then Exit;
for i := 0 to 3 do
   if not (Nachbar[i] = nil) then
      if (Nachbar[i].MyType = Self.MyType) then Inc(Result);
end;

procedure TStein.BuildUpDeadList(List: TList);
var i, y : Integer;
    IsIn : boolean;
begin
// ActionStones abarbeiten
if ActionSet.IsAction then begin
   Case ActionSet.ActType of
      atBomb        : BUDLBomb(Sf.DeleteList);
      atRocketLeft  : BUDLRocketHoriz(Sf.DeleteList);
      atRocketRight : BUDLRocketHoriz(Sf.DeleteList);
      atRocketTop   : BUDLRocketVert(Sf.DeleteList);
      atRocketBottom: BUDLRocketVert(Sf.DeleteList);
      atRock        : BUDLRock(Sf.DeleteList);
      atEarthQuake  : BUDLQuake(Sf.DeleteList);
      end;
   exit;
   end;
// Normaler Zug abarbeiten
List.Add(Self);
for i := 0 to 3 do begin
   if not (Nachbar[i] = nil) then
      if (Nachbar[i].MyType = Self.MyType) then begin
         IsIn := false;
         for y := 0 to List.Count-1 do
            If (TStein(List[y]).Nummer = Nachbar[i].Nummer) then IsIn := true;
         if not IsIn then begin
            Nachbar[i].BuildUpDeadList(List);
            end;
      end;
  end;
end;

procedure TStein.BUDLBomb(List: TList);
var i : Integer;
    Stein : TStein;
         ActList  : TList;
begin
List.Add(Self);
//sf.ActionList := TList.Create;
ActList := TList.Create;
sf.ActionLists.Add(ActList);
for i := 0 to 7 do begin
   case i of
      0 : Stein := sf.ControlAtPos(Point(self.Left - Width, self.Top - Height),false) As TStein;
      1 : Stein := sf.ControlAtPos(Point(self.Left,         self.Top - Height),false) As TStein;
      2 : Stein := sf.ControlAtPos(Point(self.Left + Width, self.Top - Height),false) As TStein;
      3 : Stein := sf.ControlAtPos(Point(self.Left - Width, self.Top         ),false) As TStein;
      4 : Stein := sf.ControlAtPos(Point(self.Left + Width, self.Top         ),false) As TStein;
      5 : Stein := sf.ControlAtPos(Point(self.Left - Width, self.Top + Height),false) As TStein;
      6 : Stein := sf.ControlAtPos(Point(self.Left,         self.Top + Height),false) As TStein;
      7 : Stein := sf.ControlAtPos(Point(self.Left + Width, self.Top + Height),false) As TStein;
      end;
   ProcActionStones(Stein, List, ActList);
   end;
end;

procedure TStein.BUDLRocketHoriz(List: TList);
var i : Integer;
    Stein : TStein;
    ActList : TList;
begin
List.Add(Self);
ActList := TList.Create;
sf.ActionLists.Add(ActList);
for i := 1 to sf.Columns-1 do  begin
   if ActionSet.ActType = atRocketRight
      then Stein := sf.ControlAtPos(Point(self.Left + (Width*i), self.Top),false) As TStein
      else Stein := sf.ControlAtPos(Point(self.Left - (Width*i), self.Top),false) As TStein;
   ProcActionStones(Stein, List, ActList);
   end;
end;

procedure TStein.BUDLRocketVert(List: TList);
var i : Integer;
    Stein : TStein;
    ActList : TList;
begin
List.Add(Self);
ActList := TList.Create;
sf.ActionLists.Add(ActList);
for i := 1 to sf.Rows -1 do  begin
   if ActionSet.ActType = atRocketTop
      then Stein := sf.ControlAtPos(Point(self.Left, self.Top - (Height*i)),false) As TStein
      else Stein := sf.ControlAtPos(Point(self.Left, self.Top + (Height*i)),false) As TStein;
   ProcActionStones(Stein, List, ActList);
   end;
end;

procedure TStein.BUDLRock(List: TList);
begin
List.Add(Self);
end;

procedure TStein.BUDLQuake(List: TList);
var i,y : Integer;
    Stein : TStein;
    TopSteinLeft,
    TopSteinRight : TStein;
    TopPosRight,
    TopPosLeft    : Integer;
    MR    : PMoveRec;
    ActList: TList;
begin
Stein := nil; TopSteinLeft := nil; TopSteinRight := nil;
TopPosLeft := -1; TopPosRight := -1;
ActList := TList.Create;
sf.ActionLists.Add(ActList);
// Ein Erdbebenstein wird gelöscht, wenn er zuoberst auf einer Säule steht.
if self.Nachbar[0] = nil then begin
   List.Add(self);
   Exit;
   end;
// Ein Erdbebenstein wird gelöscht, wenn er von einer Rakete oder Bombe getroffen wird.
if List.Count > 0 then begin
   List.Add(self);
   Exit;
   end;
for i := sf.Rows -1 downto 1 do begin
   Stein := sf.ControlAtPos(Point(self.Left, self.Top - (Height*i)),false) As TStein;
   if not (Stein = nil) then begin
      ActList.Add(Stein);
      for y := 0 to sf.Rows-1 do begin
         TopSteinLeft := sf.ControlAtPos(Point(self.Left-width, Height*y),false) As TStein;
         if not (TopSteinLeft = nil) then break;
         end;
      for y := 0 to sf.Rows-1 do begin
         TopSteinRight := sf.ControlAtPos(Point(self.Left+width, Height*y),false) As TStein;
         if not (TopSteinRight = nil) then break;
         end;
      end;
   if not (TopSteinLeft = nil) and not (Stein = nil) then begin
      if TopPosLeft = -1 then TopPosLeft := TopSteinLeft.Top;
      if TopPosLeft > Stein.Top then begin
         New(MR);
         MR.Stein := Stein;
         MR.Offset := 1;
         MR.Direction := dHorizontal;
         sf.MoveList.Add(MR);
         New(MR);
         MR.Stein := Stein;
         MR.Offset := -(((Stein.Top - TopPosLeft) div Height)+1);
         MR.Direction := dVertical;
         sf.MoveList.Add(MR);
         Dec(TopPosLeft, Height);
         continue;
         end;
      end;
   if not (Stein = nil) then begin
      if (Stein.Left = (sf.Columns-1) * Width) then continue;
      if TopPosRight = -1 then begin
         if TopSteinRight = nil
            then TopPosRight := sf.Rows * Height
            else TopPosRight := TopSteinRight.Top;
         end;
      if TopPosRight > Stein.Top then begin
         New(MR);
         MR.Stein := Stein;
         MR.Offset := -1;
         MR.Direction := dHorizontal;
         sf.MoveList.Add(MR);
         New(MR);
         MR.Stein := Stein;
         MR.Offset := -(((Stein.Top - TopPosRight) div Height)+1);
         MR.Direction := dVertical;
         sf.MoveList.Add(MR);
         Dec(TopPosRight, Height);
         end;
      end;
   end;
end;

procedure TStein.ProcActionStones(Stein : TStein; List, ActList: TList);
var y : Integer;
    IsIn : boolean;
begin
if not (Stein = nil) then begin
   ActList.Add(Stein);
   IsIn := false;
   for y := 0 to List.Count-1 do
      If (TStein(List[y]).Nummer = Stein.Nummer) then IsIn := true;
   if not IsIn then begin
      Stein.BuildUpDeadList(List);
      end;
   end;
end;

procedure TStein.Fade(FadeIn: Boolean; FrameNr: Integer);
var F : Integer;
begin
F := sf.FramePerAnimation;
self.Canvas.CopyRect(Self.Canvas.ClipRect,sf.Background.Canvas,
   Rect(self.Left,self.Top,self.Left+self.Width,self.Top+self.Height));
Face.Canvas.Brush.Color := clFuchsia;
Face.Canvas.FillRect(Face.Canvas.ClipRect);
(*if (iDT = dtShowBack) then begin
   self.Canvas.CopyRect(Self.Canvas.ClipRect,sf.Background.Canvas,
      Rect(self.Left,self.Top,self.Left+self.Width,self.Top+self.Height));
   Face.Canvas.Brush.Color := clFuchsia;
   Face.Canvas.FillRect(Face.Canvas.ClipRect);
   end;
if (iDT = dtHideBack) then begin
   Face.Canvas.Brush.Color := sf.BgColor;
   Face.Canvas.FillRect(Face.Canvas.ClipRect);
   end;*)
if FadeIn
   then Face.Canvas.StretchDraw(Rect(FrameNr*2,FrameNr*2,Face.Width-FrameNr*2, Face.Height-FrameNr*2),FaceOrig)
   else Face.Canvas.StretchDraw(Rect((F-FrameNr)*2,(F-FrameNr)*2,Face.Width-(F-FrameNr)*2, Face.Height-(F-FrameNr)*2),FaceOrig);
if not FadeIn and (F-FrameNr = 0)
   then Face.Canvas.Draw(0,0,FaceOrig);
Self.Paint;
Self.Visible := true;
end;

procedure TStein.Animate(Restore: Boolean; Bmp: TBitmap);
begin
Face.Canvas.Brush.Color := sf.BgColor;
if (iDT = dtShowBack)
   then Face.Canvas.CopyRect(Self.Canvas.ClipRect,sf.Background.Canvas,
      Rect(self.Left,self.Top,self.Left+self.Width,self.Top+self.Height))
   else Face.Canvas.FillRect(Face.Canvas.ClipRect);
if not Restore
   then Face.Canvas.Draw(0,0,Bmp)
   else Face.Canvas.Draw(0,0,FaceOrig);
// Hier den Code verändern, wenn Grafiken über die Steingrösse hinaus gezeichnet werden können sollen
Self.Paint;
Self.Visible := true;
end;
end.

