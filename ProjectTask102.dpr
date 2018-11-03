program ProjectTask102;

{
	NOV/2018
	Powered on: DELPHI 10 Seattle

	//

	задачку задали у нас, её решал я целый час, и вышло у меня в ответе --
	2 землекопа и 2/3.....

	//

	Даны 10 символов: 1234567890.
	Между любыми двумя символами можно поставить (а можно не ставить) любой из
	знаков математической операции: +, -, *, /.
	Сколько существует способов расстановки знаков, чтобы результат был равен 97?
	Написать программу на любом языке програмирования, показать её текст и все
	комбинации

	//

	В 90-х годах на олимпиаде по информатики было задание:

	Найти все возможные комбинации для выражения AB * CDE = FGHI, где A <> B <> C
	<> D <> E <> F <> G <> H <> I, допустимые значения для A..I: от 1 до 9. 0 не
	используется.

	//

	подобные задачи либо решаются с помощью "линейного программирования" (не имеет
	ничего общего с обычным программированием) и теми, кто "видит числа" :)
	и может	вывести/предоставить формулу(ы), которые помогут найти все варианты
	решения очень быстро,
	либо...
	либо с помощью перебора всех возможных вариантов (программа brute-force) :/
}

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  uExpressionHelper in 'uExpressionHelper.pas',
  uLogic in 'uLogic.pas',
  uEnumLogic in 'uEnumLogic.pas',
  uLogicBase in 'uLogicBase.pas',
  uBruteForceLogic in 'uBruteForceLogic.pas';

const
	/// <summary>
	///  	For "smart" algorithm we need to know only length.
	///  	For "brute force" algorithm we need to pass entire string.
	/// </summary>
	CONST_INCOMMING_DATA = '1234567890';
	CONST_EXPECTING_DATA = 97;
	/// <summary>
	///  	We really pass them and then split by char
	/// </summary>
	CONST_ALLOWED_OPERATIONS = '+-*/ ';

var
	LLogic: TLogic;
	LEnumLogic: TEnumLogic;
	LBruteForceLogic: TBruteForceLogic;

begin
	ReportMemoryLeaksOnShutdown := True;

	{ Just quick self test for evaluation function }
	Assert(ExpressionHelper.Evaluate('9/3') = '3');
	Assert(ExpressionHelper.Evaluate('3+7') = '10');
	Assert(ExpressionHelper.Evaluate('-2-9') = '-11');
	Assert(ExpressionHelper.Evaluate('-2+3*4/6') = '0');

	// Way 1

	Writeln('Logic start time: ', DateTimeToStr(Now));
	LLogic := TLogic.Create;
	try
		LLogic.Iterate(CONST_INCOMMING_DATA.Length, CONST_ALLOWED_OPERATIONS,
			IntToStr(CONST_EXPECTING_DATA));
		LLogic.DisplayResult;
	finally
		LLogic.Free;
	end;
	Writeln('Logic end time: ', DateTimeToStr(Now));

	// Way 2

	Writeln('EnumLogic start time: ', DateTimeToStr(Now));
	LEnumLogic := TEnumLogic.Create;
	try
		LEnumLogic.Iterate(CONST_INCOMMING_DATA, CONST_ALLOWED_OPERATIONS,
			IntToStr(CONST_EXPECTING_DATA));
		LEnumLogic.DisplayResult;
	finally
		LEnumLogic.Free;
	end;
	Writeln('EnumLogic end time: ', DateTimeToStr(Now));

	// Not good way 3

	Writeln('BruteForceLogic start time: ', DateTimeToStr(Now));
	LBruteForceLogic := TBruteForceLogic.Create;
	try
		LBruteForceLogic.Iterate(CONST_INCOMMING_DATA, CONST_ALLOWED_OPERATIONS,
			IntToStr(CONST_EXPECTING_DATA));
		LBruteForceLogic.DisplayResult;
	finally
		LBruteForceLogic.Free;
	end;
	Writeln('BruteForceLogic end time: ', DateTimeToStr(Now));

	//

	Write('Press Enter for close application...');
	Readln;
end.
