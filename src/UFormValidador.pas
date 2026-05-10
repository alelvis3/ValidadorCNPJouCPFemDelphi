unit UFormValidador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TFormValidador = class(TForm)
    TtxtPjPf: TLabeledEdit;
    TBtnValidar: TButton;
    TlblStatus: TLabel;
    TEditNumeroFormatado: TEdit;
    TLblUfCPF: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormValidador: TFormValidador;

implementation

{$R *.dfm}

end.
