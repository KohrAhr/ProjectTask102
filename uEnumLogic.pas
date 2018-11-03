unit uEnumLogic;

interface

uses
	uLogicBase,
	System.Generics.Collections;

type
	/// <summary>
	/// 	Task optimized solution
	/// </summary>
	TMyXSubType = (op1 = 1, op2, op3, op4, op5);
	TMyXType = Array of TMyXSubType;

	TMyType = record
	private
		procedure _Inc(APosition: Integer);
	public
		Value: TMyXType;
		procedure Reset(ALength: Integer);
		procedure Inc;
		procedure SetMin;
		function IsMin: Boolean;
		function GetLength: Integer;
	end;

	TEnumLogic = class(TLogicBase)
	private
		FPattern: String;
	public
		function MyTypeToString(AValue: TMyType): String;

		/// <summary>
		/// </summary>
		procedure Iterate(APattern: String; AOperations: String;
			ARequiredResult: String);
	end;

implementation

uses
	System.SysUtils,
	uExpressionHelper;

{ TEnumLogic }

procedure TEnumLogic.Iterate(APattern: String; AOperations,
	ARequiredResult: String);
var
	LExpression: String;
	LResult: String;
	LCycleTest: LongInt;
	zz: TMyType;
begin
	FPattern := APattern;
	FOperations := AOperations;
	FRequiredResult := ARequiredResult;

	zz.Reset(APattern.Length - 1);

	LCycleTest := 0;
	repeat
		Inc(LCycleTest);

		// Build next option
		zz.Inc;

		// Merge strings
		LExpression := MergeStrings(MyTypeToString(zz), FPattern);

		// Skip not valid
		if not ExpressionHelper.ExpressionIsSafe(LExpression) then
			Continue;

		// Check value
		LResult := ExpressionHelper.Evaluate(LExpression);

		if LResult = FRequiredResult then
			FLogicResult.Add(LExpression);
	until zz.IsMin;

	Writeln('Cycles: ', LCycleTest);
end;


function TEnumLogic.MyTypeToString(AValue: TMyType): String;
var
	I: Integer;
begin
	Result := '';
	for I := 0 to Length(AValue.Value) - 1 do
		Result := Result + FOperations[Integer(AValue.Value[I])];
end;

{ TMyType }

procedure TMyType.Inc;
begin
	// Start from last one and back to top.
	_Inc(GetLength);
end;

procedure TMyType._Inc(APosition: Integer);
begin
	if Value[APosition] = High(TMyXSubType) then
		begin
			Value[APosition] := Low(TMyXSubType);
			if APosition - 1 < 0 then
				// Reset. We could handle also as Overflow.
				SetMin
			else
				_Inc(APosition - 1);
		end
	else
		Value[APosition] := Succ(Value[APosition]);
end;

function TMyType.IsMin: Boolean;
var
	I: Integer;
begin
	Result := True;
	for I := 0 to GetLength do
		if Value[I] <> Low(TMyXSubType) then
			begin
				Result := False;
				Break;
			end;
end;

function TMyType.GetLength: Integer;
begin
	Result := Length(Value) - 1;
end;

procedure TMyType.SetMin;
var
	I: Integer;
begin
	for I := 0 to GetLength do
		Value[I] := Low(TMyXSubType);
end;

procedure TMyType.Reset(ALength: Integer);
begin
	SetLength(Value, ALength);

	SetMin;
end;

end.
