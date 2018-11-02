program ProjectTask102;

{
	NOV/2018
	Powered on: DELPHI 10 Seattle

	//

	задачку задали у нас, еЄ решал € целый час, и вышло у мен€ в ответе --
	2 землекопа и 2/3.....

	//

	ƒаны 10 символов: 1234567890.
	ћежду любыми двум€ символами можно поставить (а можно не ставить) любой из
	знаков математической операции: +, -, *, /.
	—колько существует способов расстановки знаков, чтобы результат был равен 97?
	Ќаписать программу на любом €зыке програмировани€, показать еЄ текст и все
	комбинации

	//

	¬ 90-х годах на олимпиаде по информатики было задание:

	Ќайти все возможные комбинации дл€ выражени€ AB * CDE = FGHI, где A <> B <> C
	<> D <> E <> F <> G <> H <> I, допустимые значени€ дл€ A..I: от 1 до 9. 0 не
	используетс€.

	//

	подобные задачи либо решаютс€ с помощью "линейного программировани€" (не имеет
	ничего общего с обычным программированием) и теми, кто "видит числа" :)
	и может	предоставить формулы, которые помогут наход€т все варианты решени€
	очень быстро,
	либо...
	либо с помощью перебора всех возможных вариантов (программа brute-force) :/
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
