unit uExpressionHelper;

interface

uses
	System.Bindings.EvalProtocol;

type
	ExpressionHelper = class
	private
		class var FScope: IScope;
	public
		/// <summary>
		///  	Evaluate simple math operation
		/// </summary>
		class function Evaluate(AValue: String): String;

		/// <summary>
		///  	Check that expression is save to evaluate (no div to zero option)
		/// </summary>
		class function ExpressionIsSafe(AValue: String): Boolean;

		class constructor Create;
	end;

implementation

uses
	System.Rtti,
	System.Bindings.Consts,
	System.Bindings.Evaluator,
	System.Bindings.EvalSys,
	System.SysUtils;

class constructor ExpressionHelper.Create;
begin
	FScope := TNestedScope.Create(BasicOperators, BasicConstants);
end;

class function ExpressionHelper.ExpressionIsSafe(AValue: String): Boolean;
begin
	Result := not AValue.Contains('/0');
end;

class function ExpressionHelper.Evaluate(AValue: String): String;
var
	CompiledExpression: ICompiledBinding;
	Expression: String;
	Answer: TValue;
begin
	try
		Expression := AValue;
		CompiledExpression := Compile(Expression, FScope);
		Answer := CompiledExpression.Evaluate(FScope, nil, nil).GetValue;
	finally
		Result := Answer.ToString;
	end;
end;

end.
