unit StoneStat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,  stdctrls,
  PicPanel, Spielfeld, GameType, Stein;

type
  TStoneStat = class(TPaintBox)
  private
    procedure CreateBack;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent; F: TSpielfeld; G: TGameType);virtual;
    destructor Destroy;override;
    procedure ShowStoneStats;
    procedure RenewBack;
  published
    { Published-Deklarationen }
  end;

implementation

var Feld :TSpielfeld;
    Game : TGameType;
    Back : TBitmap;

constructor TStoneStat.Create(AOwner: TComponent; F: TSpielfeld; G: TGameType);
begin
Feld := F;
Game := G;
inherited create(AOwner);
end;

destructor TStoneStat.Destroy;
begin
inherited;
Back.Free;
Back := nil;
end;

procedure TStoneStat.Paint;
begin
inherited;
try
ShowStoneStats;
except;
end;
end;

procedure TStoneStat.ShowStoneStats;
var bmp : TBitmap;
    i,y : Integer;
    StoneCntr : Integer;
    PosLeft : Integer;
    Stein   : TStein;
    Font    : TFont;
begin
if (Feld = nil) or (Stein = nil) or (Game = nil) then Exit;
CreateBack;
Font := TFont.Create;
PosLeft := 10;
Self.Canvas.Draw(1,1,Back);
for i := 0 to feld.NrOfColors-1 do begin
   Bmp := TBitmap.Create;
   Bmp.Transparent := True;
   Bmp.TransparentColor := clFuchsia;
   Game.BallsList.GetBitmap(i, bmp);
   Self.Canvas.StretchDraw(Rect(PosLeft,1,20+PosLeft,20), bmp);
   StoneCntr := 0;
   for y := 0 to Feld.ControlCount-1 do begin
       Stein := Feld.Controls[y] as TStein;
       if Stein.MyType = i then Inc(StoneCntr);
       end;
   Font.Name := 'Arial';
   Font.Color := clWhite;
   Self.Canvas.Brush.Style := bsClear;
   Self.Canvas.Font := Font;
   Self.Canvas.TextOut(PosLeft+22,3,IntToStr(StoneCntr));
   Inc(PosLeft,40);
   Bmp.Free;
   end;
Font.Free;
end;

procedure TStoneStat.CreateBack;
var PL      : TPicPanel;
begin
PL := self.Parent As TPicPanel;
if (Back = nil) then begin
   Back := TBitmap.Create;
   PL := self.Parent As TPicPanel;
   Back.Width := self.Width;
   Back.Height := self.Height;
   Back.Canvas.CopyRect(Back.Canvas.ClipRect, PL.Background.Canvas, Rect(self.left,self.Top,self.left+self.width, self.Top+self.Height));
   end;
end;

procedure TStoneStat.RenewBack;
begin
Back.Free;
Back := nil;
ShowStoneStats;
end;

end.
