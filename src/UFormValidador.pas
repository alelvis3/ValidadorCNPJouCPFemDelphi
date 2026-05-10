unit UFormValidador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  uValidadorPfPj, System.RegularExpressions, System.MaskUtils;

type
  TFormValidador = class(TForm)
    TtxtPjPf: TLabeledEdit;
    TBtnValidar: TButton;
    TlblStatus: TLabel;
    TEditNumeroFormatado: TEdit;
    TLblUfCPF: TLabel;
    procedure TBtnValidarClick(Sender: TObject);
    procedure TtxtPjPfKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFormValidador.TtxtPjPfKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LTexto: string;
begin
  // 1. Ignora teclas de controle para não quebrar a digitação
  if (Key = VK_BACK) or (Key = VK_DELETE) or (Key = VK_LEFT) or (Key = VK_RIGHT)
  then
    Exit;

  // 2. Limpa caracteres não alfanuméricos
  LTexto := TRegEx.Replace(TtxtPjPf.Text, '[^a-zA-Z0-9]', '');

  // 3. Aplica máscara baseada no tamanho (11 = CPF, >11 = CNPJ)
  if LTexto.Length <= 11 then
  begin
    // Formato CPF: 000.000.000-00
    if LTexto.Length > 9 then
      LTexto := FormatMaskText('999.999.999-99;0;_', LTexto)
    else if LTexto.Length > 6 then
      LTexto := FormatMaskText('999.999.999;0;_', LTexto)
    else if LTexto.Length > 3 then
      LTexto := FormatMaskText('999.999;0;_', LTexto);
  end
  else
  begin
    // Formato CNPJ: 00.000.000/0000-00
    if LTexto.Length > 14 then
      LTexto := LTexto.Substring(0, 14);

    if LTexto.Length > 12 then
      LTexto := FormatMaskText('99.999.999/9999-99;0;_', LTexto)
    else if LTexto.Length > 8 then
      LTexto := FormatMaskText('99.999.999/9999;0;_', LTexto)
    else
      LTexto := FormatMaskText('99.999.999;0;_', LTexto);
  end;

  // 4. Atualiza o componente
  TtxtPjPf.Text := LTexto.ToUpper;
  TtxtPjPf.SelStart := LTexto.Length; // Mantém o cursor no fim
end;

end.
