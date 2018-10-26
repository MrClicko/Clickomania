unit UserName;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, LangSupp;

type
  TfrmUser = class(TForm)
    panelMain: TPanel;
    bttOK: TButton;
    bttCancel: TButton;
    lblName: TLabel;
    editName: TEdit;
    lblMail: TLabel;
    editMail: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmUser: TfrmUser;

implementation

uses Main;

{$R *.DFM}

procedure TfrmUser.FormCreate(Sender: TObject);
begin
LS.ProcStrings(self.Name);
end;

end.
