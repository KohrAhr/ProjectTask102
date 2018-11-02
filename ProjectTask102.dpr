program ProjectTask102;

{
	NOV/2018
	Powered on: DELPHI 10 Seattle

	//

	������� ������ � ���, � ����� � ����� ���, � ����� � ���� � ������ --
	2 ��������� � 2/3.....

	//

	���� 10 ��������: 1234567890.
	����� ������ ����� ��������� ����� ��������� (� ����� �� �������) ����� ��
	������ �������������� ��������: +, -, *, /.
	������� ���������� �������� ����������� ������, ����� ��������� ��� ����� 97?
	�������� ��������� �� ����� ����� ���������������, �������� � ����� � ���
	����������

	//

	� 90-� ����� �� ��������� �� ����������� ���� �������:

	����� ��� ��������� ���������� ��� ��������� AB * CDE = FGHI, ��� A <> B <> C
	<> D <> E <> F <> G <> H <> I, ���������� �������� ��� A..I: �� 1 �� 9. 0 ��
	������������.

	//

	�������� ������ ���� �������� � ������� "��������� ����������������" (�� �����
	������ ������ � ������� �����������������) � ����, ��� "����� �����" :)
	� �����	������������ �������, ������� ������� ������� ��� �������� �������
	����� ������,
	����...
	���� � ������� �������� ���� ��������� ��������� (��������� brute-force) :/
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  uExpressionHelper in 'uExpressionHelper.pas',
	uLogic in 'uLogic.pas';

const
	CONST_INCOMMING_DATA = '1234567890';
	CONST_EXPECTING_DATA = 97;
	CONST_ALLOWED_OPERATIONS = '+-*/';

var
	LLogic: TLogic;

begin
	ReportMemoryLeaksOnShutdown := True;

	Writeln('Start time: ', DateTimeToStr(Now));

	{ Just quick self test for evaluation function }
	Assert(ExpressionHelper.Evaluate('9/3') = '3');
	Assert(ExpressionHelper.Evaluate('3+7') = '10');
	Assert(ExpressionHelper.Evaluate('-2-9') = '-11');
	Assert(ExpressionHelper.Evaluate('-2+3*4/6') = '0');

	LLogic := TLogic.Create;
	try
		LLogic.Iterate(CONST_INCOMMING_DATA.Length, CONST_ALLOWED_OPERATIONS,
			IntToStr(CONST_EXPECTING_DATA));
		LLogic.DisplayResult;
	finally
		LLogic.Free;
	end;

	Writeln('End time: ', DateTimeToStr(Now));
	Write('Press Enter for close application...');
	Readln;
end.
