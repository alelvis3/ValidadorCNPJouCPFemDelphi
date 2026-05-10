unit uValidadorPfPj;

interface

uses
  System.SysUtils, System.RegularExpressions, System.Character;

type
  { Utilizando Record para melhor performance (alocação na Stack) }
  TValidadorPfPj = record
  private
    FCpfOrCnpj: string;
    FTipo: string;
    FFormatar: string;
    FUfCpf: string;
    function ValidarCPF(const ACpf: string): Boolean;
    function ValidarCNPJ(const ACnpj: string): Boolean;
    function CalcularDigitoCPF(const ANum: string; APesoInicial, APosicao: Integer): Char;
    function CalcularDigitoCNPJ(const ANum: string; const APesos: array of Integer): Char;
    function IdentificadorUf(ADigito: Char): string;
  public
    constructor Create(const ACpfOrCnpj: string);
    function Validar: Boolean;

    property Tipo: string read FTipo;
    property Formatar: string read FFormatar;
    property UfCpf: string read FUfCpf;
  end;

implementation

{ TValidadorPfPj }

constructor TValidadorPfPj.Create(const ACpfOrCnpj: string);
begin
  // Remove caracteres não alfanuméricos e converte para UpperCase (Regra CNPJ Alfanumérico)
  FCpfOrCnpj := TRegEx.Replace(ACpfOrCnpj, '[^a-zA-Z0-9]', '').ToUpper;
  FTipo := '';
  FFormatar := '';
  FUfCpf := '';
end;

function TValidadorPfPj.Validar: Boolean;
begin
  case FCpfOrCnpj.Length of
    11: Result := ValidarCPF(FCpfOrCnpj);
    14: Result := ValidarCNPJ(FCpfOrCnpj);
  else
    Result := False;
  end;
end;

function TValidadorPfPj.ValidarCPF(const ACpf: string): Boolean;
var
  Dig10, Dig11: Char;
begin
  // Valida se todos os caracteres são iguais ou sequência óbvia
  if TRegEx.IsMatch(ACpf, '^(\d)\1{10}$') or (ACpf = '12345678909') then
    Exit(False);

  try
    Dig10 := CalcularDigitoCPF(ACpf, 10, 9);
    Dig11 := CalcularDigitoCPF(ACpf, 11, 10);

    Result := (Dig10 = ACpf[10]) and (Dig11 = ACpf[11]);
    if Result then
    begin
      FTipo := 'CPF';
      FFormatar := TRegEx.Replace(ACpf, '(\d{3})(\d{3})(\d{3})(\d{2})', '$1.$2.$3-$4');
      FUfCpf := IdentificadorUf(ACpf[9]);
    end;
  except
    Result := False;
  end;
end;

function TValidadorPfPj.ValidarCNPJ(const ACnpj: string): Boolean;
const
  Pesos1: array[0..11] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  Pesos2: array[0..12] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
var
  Dig13, Dig14: Char;
begin
  if (ACnpj.Length <> 14) or TRegEx.IsMatch(ACnpj, '^(\w)\1{13}$') then
    Exit(False);

  try
    Dig13 := CalcularDigitoCNPJ(ACnpj, Pesos1);
    Dig14 := CalcularDigitoCNPJ(ACnpj, Pesos2);

    Result := (Dig13 = ACnpj[13]) and (Dig14 = ACnpj[14]);

    if Result then
    begin
      FTipo := 'CNPJ';
      FFormatar := TRegEx.Replace(ACnpj, '([A-Z0-9]{2})([A-Z0-9]{3})([A-Z0-9]{3})([A-Z0-9]{4})(\d{2})',
                                  '$1.$2.$3/$4-$5');
    end;
  except
    Result := False;
  end;
end;

function TValidadorPfPj.CalcularDigitoCPF(const ANum: string; APesoInicial, APosicao: Integer): Char;
var
  I, Soma, Resto, Peso: Integer;
begin
  Soma := 0;
  Peso := APesoInicial;
  for I := 1 to APosicao do
  begin
    Soma := Soma + (Ord(ANum[I]) - Ord('0')) * Peso;
    Dec(Peso);
  end;
  Resto := 11 - (Soma mod 11);
  if Resto >= 10 then Result := '0' else Result := Chr(Resto + Ord('0'));
end;

function TValidadorPfPj.CalcularDigitoCNPJ(const ANum: string; const APesos: array of Integer): Char;
var
  I, Soma, Resto, ValorCalculo: Integer;
begin
  Soma := 0;
  for I := 0 to High(APesos) do
  begin
    // Regra oficial CNPJ Alfanumérico: Valor ASCII - 48
    ValorCalculo := Ord(ANum[I + 1]) - 48;
    Soma := Soma + (ValorCalculo * APesos[I]);
  end;
  Resto := Soma mod 11;
  if Resto < 2 then Result := '0' else Result := Chr((11 - Resto) + Ord('0'));
end;

function TValidadorPfPj.IdentificadorUf(ADigito: Char): string;
begin
  case ADigito of
    '1': Result := 'DF, GO, MS, MT e TO';
    '2': Result := 'PA, AM, AC, AP, RO e RR';
    '3': Result := 'CE, MA e PI';
    '4': Result := 'PE, RN, PB e AL';
    '5': Result := 'BA e SE';
    '6': Result := 'MG';
    '7': Result := 'RJ e ES';
    '8': Result := 'SP';
    '9': Result := 'PR e SC';
    '0': Result := 'RS';
  else
    Result := 'UF Desconhecida';
  end;
end;

end.

