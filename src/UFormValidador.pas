unit UFormValidador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  uValidadorPfPj;

type
  TFormValidador = class(TForm)
    TtxtPjPf: TLabeledEdit;
    TBtnValidar: TButton;
    TlblStatus: TLabel;
    TEditNumeroFormatado: TEdit;
    TLblUfCPF: TLabel;
    procedure TBtnValidarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormValidador: TFormValidador;

implementation

{$R *.dfm}

procedure TFormValidador.TBtnValidarClick(Sender: TObject);
var
  Validador: TValidadorPfPj;
begin

  Validador := TValidadorPfPj.Create(TtxtPjPf.Text);
  if Validador.Validar then
  begin
    // Caso seja válido
    TlblStatus.Caption := 'Status: ' + Validador.Tipo + ' Válido';
    TlblStatus.Font.Color := clGreen;

    TEditNumeroFormatado.Text := Validador.Formatar;

    if Validador.Tipo = 'CPF' then
      TLblUfCPF.Caption := 'UF Origem: ' + Validador.UfCpf
    else
      TLblUfCPF.Caption := '';
  end
  else
  begin
    // Caso seja inválido
    TlblStatus.Caption := 'Status: Documento Inválido';
    TlblStatus.Font.Color := clRed;

    TEditNumeroFormatado.Clear;
    TLblUfCPF.Caption := '';

    TtxtPjPf.SetFocus;
  end;
end;

end.
